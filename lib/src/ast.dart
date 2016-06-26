part of rethinkdb;

class RqlQuery {
  p.Term_TermType tt;

  int _errDepth = 0;
  List args = [];
  Map optargs = {};

  RqlQuery([List args, Map optargs]) {
    if (args != null)
      args.forEach((e) {
      if (_checkIfOptions(e, tt)) {
        optargs ??= e;
      } else {
        this.args.add(_expr(e));
      }
    });
    if (optargs != null)
      optargs.forEach((k, v) {
      this.optargs[k] = _expr(v);
    });
    //args = [new Args(args)];
  }

  _expr(val, [nestingDepth = 20]) {
    if (nestingDepth <= 0)
      throw new RqlDriverError("Nesting depth limit exceeded");

    if (nestingDepth is int == false)
      throw new RqlDriverError("Second argument to `r.expr` must be a number.");

    if (val is RqlQuery)
      return val;
    else if (val is List) {
      val.forEach((v) {
        v = _expr(v, nestingDepth - 1);
      });

      return new MakeArray(val);
    } else if (val is Map) {
      Map obj = {};

      val.forEach((k, v) {
        obj[k] = _expr(v, nestingDepth - 1);
      });

      return new MakeObj(obj);
    } else if (val is Function)
      return new Func(val);
    else if (val is DateTime) {
      return new Time(new Args([
        val.year,
        val.month,
        val.day,
        val.hour,
        val.minute,
        val.second,
        _formatTimeZoneOffset(val)
      ]));
    } else
      return new Datum(val);
  }

  String _formatTimeZoneOffset(DateTime val) {
    String tz = val.timeZoneOffset.inHours.toString();

    if (!val.timeZoneOffset.inHours.isNegative) tz = "+$tz";

    if (tz.length == 2) tz = tz.replaceRange(0, 1, tz[0] + "0");

    return tz;
  }

  Future run(Connection c, [globalOptargs]) {
    if (c == null)
      throw new RqlDriverError(
          "RqlQuery.run must be given a connection to run on.");

    globalOptargs ??= {};
    return c._start(this, globalOptargs);
  }

  //since a term that may take multiple options can now be passed
  //one or two, we can't know if the final argument in a query
  //is actually an option or just another arg.  _check_if_options
  //checks if all of the keys in the object are in options
  _checkIfOptions(obj, p.Term_TermType tt) {
    if (obj is Map == false) {
      return false;
    } else {
      List options = new _RqlAllOptions(tt).options;

      bool isOptions = true;
      obj.keys.forEach((k) {
        if (!options.contains(k)) {
          isOptions = false;
        }
      });
      return isOptions;
    }
  }

  build() {
    List res = [];
    if (this.tt != null) res.add(this.tt.value);
    List argList = [];
    args.forEach((arg) {
      if (arg != null) argList.add(arg.build());
    });
    res.add(argList);

    if (optargs.length > 0) {
      Map optArgsMap = {};
      optargs.forEach((k, v) {
        optArgsMap[k] = v.build();
      });
      res.add(optArgsMap);
    }
    return res;
  }

  _recursivelyConvertPseudotypes(obj, formatOpts) {
    if (obj is Map) {
      obj.forEach((k, v) {
        obj[k] = _recursivelyConvertPseudotypes(v, formatOpts);
      });
      obj = _convertPseudotype(obj, formatOpts);
    } else if (obj is List) {
      obj.forEach((e) {
        e = _recursivelyConvertPseudotypes(e, formatOpts);
      });
    }
    return obj;
  }

  _listify(args, [parg]) {
    if (args is List) {
      args.insert(0, parg);
      return args;
    } else {
      if (args != null) {
        if (parg != null)
          return [parg, args];
        else
          return [args];
      } else
        return [];
    }
  }

  _ivarScan(query) {
    if (!(query is RqlQuery)) {
      return false;
    }

    if (query is ImplicitVar) {
      return true;
    }
    if (query.args.any(_ivarScan)) {
      return true;
    }

    var optArgKeys = query.optargs.values;

    if (optArgKeys.any(_ivarScan)) {
      return true;
    }
    return false;
  }

  // Called on arguments that should be functions
  _funcWrap(val) {
    val = _expr(val);
    if (_ivarScan(val)) {
      return new Func((x) => val);
    }
    return val;
  }

  _reqlTypeTimeToDatetime(Map obj) {
    if (obj["epoch_time"] == null) {
      throw new RqlDriverError(
          'pseudo-type TIME object $obj does not have expected field "epoch_time".');
    } else {
      String s = obj["epoch_time"].toString();
      if (s.indexOf(".") >= 0) {
        List l = s.split('.');
        while (l[1].length < 3) {
          l[1] = l[1] + "0";
        }
        s = l.join("");
      } else {
        s += "000";
      }
      return new DateTime.fromMillisecondsSinceEpoch(int.parse(s));
    }
  }

  _reqlTypeGroupedDataToObject(Map obj) {
    if (obj['data'] == null) {
      throw new RqlDriverError(
          'pseudo-type GROUPED_DATA object $obj does not have the expected field "data".');
    }

    Map retObj = {};
    obj['data'].forEach((e) {
      retObj[e[0]] = e[1];
    });
    return retObj;
  }

  _convertPseudotype(Map obj, Map formatOpts) {
    String reqlType = obj['\$reql_type\$'];
    if (reqlType != null) {
      if (reqlType == 'TIME') {
        if (formatOpts == null || formatOpts.isEmpty) {
          formatOpts = {"time_format": "native"};
        }
        String timeFormat = formatOpts['time_format'];
        if (timeFormat != null || timeFormat == 'native') {
          // Convert to native dart DateTime
          return _reqlTypeTimeToDatetime(obj);
        } else if (timeFormat != 'raw')
          throw new RqlDriverError(
              "Unknown time_format run option $timeFormat.");
      } else if (reqlType == 'GROUPED_DATA') {
        if (formatOpts == null ||
            formatOpts.isEmpty ||
            formatOpts['group_format'] == 'native')
          return _reqlTypeGroupedDataToObject(obj);
        else if (formatOpts['group_format'] != 'raw')
          throw new RqlDriverError(
              "Unknown group_format run option ${formatOpts['group_format']}.");
      } else if (reqlType == "BINARY") {
        if (formatOpts == null || formatOpts["binary_format"] == "native") {
          /**the official drivers decode the BASE64 string to binary data
            *this driver currently has a bug with its [_reqlTypeBinaryToBytes]
            * for some reason, when trying to convert the index function for
            * `indexWait` commands, we get a FormatException.
            *  so for the short term we will just return the BASE64 string
            *  with a TODO to find out what is wrong and fix it.
            **/

          try {
            return _reqlTypeBinaryToBytes(obj);
          } on FormatException catch (e) {
            return obj['data'];
          }
        } else
          throw new RqlDriverError(
              "Unknown binary_format run option: ${formatOpts["binary_format"]}");
      } else if (reqlType == "GEOMETRY") {
        obj.remove('\$reql_type\$');
        return obj;
      } else {
        throw new RqlDriverError("Unknown pseudo-type $reqlType");
      }
    }

    return obj;
  }

  _reqlTypeBinaryToBytes(Map obj) {
    return BASE64.decode(obj['data']);
  }

  Update update(args, [options]) => new Update(this, _funcWrap(args), options);

  // Comparison operators
  Eq eq(other) => new Eq(this, other);

  Ne ne(other) => new Ne(this, other);

  Lt lt(other) => new Lt(this, other);

  Le le(other) => new Le(this, other);

  Gt gt(other) => new Gt(this, other);

  Ge ge(other) => new Ge(this, other);

  // Numeric operators
  Not not() => new Not(this);

  Add add(other) => new Add(this, other);

  Sub sub(other) => new Sub(this, other);

  Mul mul(other) => new Mul(this, other);

  Div div(other) => new Div(this, other);

  Mod mod(other) => new Mod(this, other);

  And and(other) => new And([this, other]);

  Or or(other) => new Or([this, other]);

  Contains contains(args) => new Contains(this, _funcWrap(args));

  HasFields hasFields(args) => new HasFields(this, args);

  WithFields withFields([args]) => new WithFields(this, args);

  Keys keys() => new Keys(this);

  Values values() => new Values(this);

  Changes changes([Map opts]) => new Changes(this, opts);

  // Polymorphic object/sequence operations
  Pluck pluck(args) => new Pluck(_listify(args, this));

  Without without(items) => new Without(_listify(items, this));

  FunCall rqlDo(arg, [expression]) {
    if (expression == null) {
      return new FunCall(this, _funcWrap(arg));
    } else {
      return new FunCall(_listify(arg, this), _funcWrap(expression));
    }
  }

  Default rqlDefault(args) => new Default(this, args);

  Replace replace(expr, [options]) =>
      new Replace(this, _funcWrap(expr), options);

  Delete delete([options]) => new Delete(this, options);

  // Rql type inspection
  coerceTo(String type) => new CoerceTo(this, type);

  Ungroup ungroup() => new Ungroup(this);

  TypeOf typeOf() => new TypeOf(this);

  Merge merge(obj) => new Merge(this, _funcWrap(obj));

  Append append(val) => new Append(this, val);

  Floor floor() => new Floor(this);

  Ceil ceil() => new Ceil(this);

  Round round() => new Round(this);

  Prepend prepend(val) => new Prepend(this, val);

  Difference difference(List ar) => new Difference(this, ar);

  SetInsert setInsert(val) => new SetInsert(this, val);

  SetUnion setUnion(ar) => new SetUnion(this, ar);

  SetIntersection setIntersection(ar) => new SetIntersection(this, ar);

  SetDifference setDifference(ar) => new SetDifference(this, ar);

  GetField getField(index) => new GetField(this, index);

  Nth nth(int index) => new Nth(this, index);

  Match match(String regex) => new Match(this, regex);

  Split split([seperator = " ", maxSplits]) =>
      new Split(this, seperator, maxSplits);

  Upcase upcase() => new Upcase(this);

  Downcase downcase() => new Downcase(this);

  IsEmpty isEmpty() => new IsEmpty(this);

  Slice slice(int start, [end, Map options]) =>
      new Slice(this, start, end, options);

  Fold fold(base, function, [options]) =>
      new Fold(this, base, function, options);

  Skip skip(int i) => new Skip(this, i);

  Limit limit(int i) => new Limit(this, i);

  Reduce reduce(reductionFunction, [base]) =>
      new Reduce(this, _funcWrap(reductionFunction), base);

  Sum sum([args]) => new Sum(this, args);

  Avg avg([args]) => new Avg(this, args);

  Min min([args]) => new Min(this, args);

  Max max([args]) => new Max(this, args);

  RqlMap map(mappingFunction) {
    if (mappingFunction is List) {
      mappingFunction.insert(0, this);
      var item = _funcWrap(mappingFunction.removeLast());
      return new RqlMap(mappingFunction, item);
    }
    return new RqlMap([this], mappingFunction);
  }

  Filter filter(expr, [options]) => new Filter(this, _funcWrap(expr), options);

  ConcatMap concatMap(mappingFunction) =>
      new ConcatMap(this, _funcWrap(mappingFunction));

  Get get(id) => new Get(this, id);

  OrderBy orderBy(attrs, [index]) {
    if (attrs is Map && attrs.containsKey("index")) {
      index = attrs;
      attrs = [];

      index.forEach((k, ob) {
        if (ob is Asc || ob is Desc) {
          //do nothing
        } else
          ob = _funcWrap(ob);
      });
    } else if (attrs is List) {
      if (index is Map == false && index != null) {
        attrs.add(index);
        index = null;
      }
      attrs.forEach((ob) {
        if (ob is Asc || ob is Desc) {
          //do nothing
        } else
          ob = _funcWrap(ob);
      });
    } else {
      List tmp = [];
      tmp.add(attrs);
      if (index is Map == false && index != null) {
        tmp.add(index);
        index = null;
      }
      attrs = tmp;
    }

    return new OrderBy(_listify(attrs, this), index);
  }

  operator +(other) => this.add(other);
  operator -(other) => this.sub(other);
  operator *(other) => this.mul(other);
  operator /(other) => this.div(other);
  operator ==(other) => this.eq(other);
  operator <=(other) => this.le(other);
  operator >=(other) => this.ge(other);
  operator <(other) => this.lt(other);
  operator >(other) => this.gt(other);
  operator %(other) => this.mod(other);
  operator [](attr) => this.pluck(attr);

  Between between(lowerKey, [upperKey, options]) =>
      new Between(this, lowerKey, upperKey, options);

  Distinct distinct() => new Distinct(this);

  Count count([filter]) {
    if (filter == null) return new Count(this);
    return new Count(this, _funcWrap(filter));
  }

  Union union(sequence, opts) => new Union(this, [sequence, opts]);

  InnerJoin innerJoin(otherSequence, [predicate]) =>
      new InnerJoin(this, otherSequence, predicate);

  OuterJoin outerJoin(otherSequence, [predicate]) =>
      new OuterJoin(this, otherSequence, predicate);

  EqJoin eqJoin(leftAttr, [otherTable, options]) =>
      new EqJoin(this, _funcWrap(leftAttr), otherTable, options);

  Zip zip() => new Zip(this);

  Group group(args, [options]) => new Group(this, args, options);

  ForEach forEach(writeQuery) => new ForEach(this, _funcWrap(writeQuery));

  Info info() => new Info(this);

  //Array only operations

  InsertAt insertAt(index, [value]) => new InsertAt(this, index, value);

  SpliceAt spliceAt(index, [ar]) => new SpliceAt(this, index, ar);

  DeleteAt deleteAt(index, [end]) => new DeleteAt(this, index, end);

  ChangeAt changeAt(index, [value]) => new ChangeAt(this, index, value);

  Sample sample(int i) => new Sample(this, i);

  // Time support
  ToISO8601 toISO8601() => new ToISO8601(this);

  ToEpochTime toEpochTime() => new ToEpochTime(this);

  During during(start, [end, options]) => new During(this, start, end, options);

  Date date() => new Date(this);

  TimeOfDay timeOfDay() => new TimeOfDay(this);

  Timezone timezone() => new Timezone(this);

  Year year() => new Year(this);

  Month month() => new Month(this);

  Day day() => new Day(this);

  DayOfWeek dayOfWeek() => new DayOfWeek(this);

  DayOfYear dayOfYear() => new DayOfYear(this);

  Hours hours() => new Hours(this);

  Minutes minutes() => new Minutes(this);

  Seconds seconds() => new Seconds(this);

  InTimezone inTimezone(tz) => new InTimezone(this, tz);

  Binary binary(data) => new Binary(data);

  Distance distance(geo, [opts]) => new Distance(this, geo, opts);

  Fill fill() => new Fill(this);

  ToGeoJson toGeojson() => new ToGeoJson(this);

  GetIntersecting getIntersecting(geo, Map options) =>
      new GetIntersecting(this, geo, options);

  GetNearest getNearest(point, [Map options]) =>
      new GetNearest(this, point, options);

  Includes includes(geo) => new Includes(this, geo);

  Intersects intersects(geo) => new Intersects(this, geo);

  PolygonSub polygonSub(var poly) => new PolygonSub(this, poly);

  Config config() => new Config(this);

  Rebalance rebalance() => new Rebalance(this);

  Reconfigure reconfigure(Map options) => new Reconfigure(this, options);

  Status status() => new Status(this);

  Wait wait([Map options]) => new Wait(this, options);

  noSuchMethod(Invocation invocation) {
    if (this._errDepth == 0) {
      _errDepth++;
      Symbol methodName = invocation.memberName;
      List argsList = [];
      argsList.addAll(invocation.positionalArguments);
      Map options = {};

      if (argsList.length > 1 && argsList.last is Map) {
        options = argsList.removeLast();
      }

      InstanceMirror im = reflect(this);

      return im.invoke(methodName, [argsList, options]).reflectee;
    } else {
      throw new RqlDriverError(
          "${this.runtimeType} has no function ${MirrorSystem.getName(invocation.memberName)}");
    }
  }

  call(attr) {
    return new GetField(this, attr);
  }
}

//TODO write pretty compose functions
class RqlBoolOperQuery extends RqlQuery {
  RqlBoolOperQuery([List args, Map optargs]) : super(args, optargs);
}

class RqlBiOperQuery extends RqlQuery {
  RqlBiOperQuery([List args, Map optargs]) : super(args, optargs);
}

class RqlBiCompareOperQuery extends RqlBiOperQuery {
  RqlBiCompareOperQuery([List args, Map optargs]) : super(args, optargs);
}

class RqlTopLevelQuery extends RqlQuery {
  RqlTopLevelQuery([List args, Map optargs]) : super(args, optargs);
}

class RqlMethodQuery extends RqlQuery {
  RqlMethodQuery([List args, Map optargs]) : super(args, optargs);
}

class RqlBracketQuery extends RqlMethodQuery {
  RqlBracketQuery([List args, Map optargs]) : super(args, optargs);
}

class Datum extends RqlQuery {
  List args = [];
  Map optargs = {};
  var data;

  Datum(val) : super([], null) {
    this.data = val;
  }

  build() {
    return this.data;
  }
}

class MakeArray extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.MAKE_ARRAY;

  MakeArray(args) : super(args);
}

class MakeObj extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.MAKE_OBJ;

  MakeObj(objDict) : super([], objDict);

  build() {
    var res = {};
    optargs.forEach((k, v) {
      res[k is RqlQuery ? k.build() : k] = v is RqlQuery ? v.build() : v;
    });
    return res;
  }
}

class Var extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.VAR;

  Var(args) : super([args]);

  call(arg) => new GetField(this, arg);
}

class JavaScript extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.JAVASCRIPT;

  JavaScript(args, [optargs]) : super([args], optargs);
}

class Http extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.HTTP;

  Http(args, [optargs]) : super([args], optargs);
}

class UserError extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.ERROR;

  UserError(args, [optargs]) : super([args], optargs);
}

class Random extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.RANDOM;

  Random(optargs) : super([], optargs == null ? {} : optargs);

  Random.leftBound(left, optargs)
      : super([left], optargs == null ? {} : optargs);

  Random.rightBound(left, right, optargs)
      : super([left, right], optargs == null ? {} : optargs);
}

class Changes extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.CHANGES;

  Changes([arg, opts]) : super([arg], opts);
}

class Fold extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.FOLD;

  Fold(seq, base, func, [opts]) : super([seq, base, func], opts);
}

class Grant extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.GRANT;

  Grant([scope, user, options]) : super([scope, user], options);
}

class Default extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DEFAULT;

  Default(obj, value) : super([obj, value]);
}

class ImplicitVar extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.IMPLICIT_VAR;

  ImplicitVar() : super();

  call(arg) => new GetField(this, arg);
}

class Eq extends RqlBiCompareOperQuery {
  p.Term_TermType tt = p.Term_TermType.EQ;

  Eq(comparable, numb) : super([comparable, numb]);
}

class Ne extends RqlBiCompareOperQuery {
  p.Term_TermType tt = p.Term_TermType.NE;

  Ne(comparable, numb) : super([comparable, numb]);
}

class Lt extends RqlBiCompareOperQuery {
  p.Term_TermType tt = p.Term_TermType.LT;

  Lt(comparable, numb) : super([comparable, numb]);
}

class Le extends RqlBiCompareOperQuery {
  p.Term_TermType tt = p.Term_TermType.LE;

  Le(comparable, numb) : super([comparable, numb]);
}

class Gt extends RqlBiCompareOperQuery {
  p.Term_TermType tt = p.Term_TermType.GT;

  Gt(comparable, numb) : super([comparable, numb]);
}

class Ge extends RqlBiCompareOperQuery {
  p.Term_TermType tt = p.Term_TermType.GE;

  Ge(comparable, numb) : super([comparable, numb]);
}

class Not extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.NOT;

  Not([args]) : super([args]);
}

class Add extends RqlBiOperQuery {
  p.Term_TermType tt = p.Term_TermType.ADD;

  Add(addable, obj) : super([addable, obj]);
}

class Sub extends RqlBiOperQuery {
  p.Term_TermType tt = p.Term_TermType.SUB;

  Sub(subbable, obj) : super([subbable, obj]);
}

class Mul extends RqlBiOperQuery {
  p.Term_TermType tt = p.Term_TermType.MUL;

  Mul(mulable, obj) : super([mulable, obj]);
}

class Div extends RqlBiOperQuery {
  p.Term_TermType tt = p.Term_TermType.DIV;

  Div(divable, obj) : super([divable, obj]);
}

class Mod extends RqlBiOperQuery {
  p.Term_TermType tt = p.Term_TermType.MOD;

  Mod(modable, obj) : super([modable, obj]);
}

class Append extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.APPEND;

  Append(ar, val) : super([ar, val]);
}

class Floor extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.FLOOR;

  Floor(ar) : super([ar]);
}

class Ceil extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.CEIL;

  Ceil(ar) : super([ar]);
}

class Round extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.ROUND;

  Round(ar) : super([ar]);
}

class Prepend extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.PREPEND;

  Prepend(ar, val) : super([ar, val]);
}

class Difference extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DIFFERENCE;

  Difference(diffable, ar) : super([diffable, ar]);
}

class SetInsert extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SET_INSERT;

  SetInsert(ar, val) : super([ar, val]);
}

class SetUnion extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SET_UNION;

  SetUnion(un, val) : super([un, val]);
}

class SetIntersection extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SET_INTERSECTION;

  SetIntersection(inter, ar) : super([inter, ar]);
}

class SetDifference extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SET_DIFFERENCE;

  SetDifference(diff, ar) : super([diff, ar]);
}

class Slice extends RqlBracketQuery {
  p.Term_TermType tt = p.Term_TermType.SLICE;

  Slice(selection, int start, [end, Map options])
      : super([selection, start, end], options);
}

class Skip extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SKIP;

  Skip(selection, int number) : super([selection, number]);
}

class Limit extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.LIMIT;

  Limit(selection, int number) : super([selection, number]);
}

class GetField extends RqlBracketQuery {
  p.Term_TermType tt = p.Term_TermType.BRACKET;

  GetField(obj, field) : super([obj, field]);
}

class Contains extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.CONTAINS;

  Contains(tbl, items) : super([tbl, items]);
}

class HasFields extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.HAS_FIELDS;

  HasFields(obj, items) : super([obj, items]);
}

class WithFields extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.WITH_FIELDS;

  WithFields(obj, fields) : super([obj, fields]);
}

class Keys extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.KEYS;

  Keys(obj) : super([obj]);
}

class Values extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.VALUES;

  Values(obj) : super([obj]);
}

class RqlObject extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.OBJECT;

  RqlObject(args) : super(args);
}

class Pluck extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.PLUCK;

  Pluck(items) : super(items);
}

class Without extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.WITHOUT;

  Without(items) : super(items);
}

class Merge extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.MERGE;

  Merge(sequence, obj) : super([sequence, obj]);
}

class Between extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.BETWEEN;

  Between(tbl, lower, upper, [options]) : super([tbl, lower, upper], options);
}

class DB extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.DB;

  DB(String dbName) : super([dbName]);

  TableList tableList() => new TableList(this);

  TableCreate tableCreate(String tableName, [Map options]) =>
      new TableCreate.fromDB(this, tableName, options);

  TableDrop tableDrop(String tableName) =>
      new TableDrop.fromDB(this, tableName);

  Table table(String tableName, [Map options]) =>
      new Table.fromDB(this, tableName, options);

  Grant grant(String user, [Map options]) => new Grant(this, user, options);
}

class FunCall extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.FUNCALL;

  FunCall(argslist, expression) : super([]) {
    List temp = [];
    temp.add(expression);
    if (argslist is List)
      temp.addAll(argslist);
    else
      temp.add(argslist);

    this.args.addAll(temp.map(_expr));
  }
}

class Table extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.TABLE;

  Table(String tableName, [Map options]) : super([tableName], options);

  Table.fromDB(DB db, String tableName, [Map options])
      : super([db, tableName], options);

  Insert insert(records, [options]) => new Insert(this, records, options);

  Grant grant(user, [options]) => new Grant(this, user, options);

  IndexList indexList() => new IndexList(this);

  IndexCreate indexCreate(indexName, [indexFunction, Map options]) {
    if (indexFunction == null && options == null) {
      return new IndexCreate(this, indexName);
    } else if (indexFunction != null && indexFunction is Map) {
      return new IndexCreate(this, indexName, indexFunction);
    }
    return new IndexCreate.withIndexFunction(
        this, indexName, indexFunction, options);
  }

  IndexDrop indexDrop(indexName) => new IndexDrop(this, indexName);

  IndexRename indexRename(oldName, newName, [Map options]) =>
      new IndexRename(this, oldName, newName, options);

  IndexStatus indexStatus([indexes]) {
    if (indexes == null) {
      return new IndexStatus.all(this);
    }
    return new IndexStatus(this, indexes);
  }

  IndexWait indexWait([indexes]) {
    if (indexes == null) {
      return new IndexWait.all(this);
    }
    return new IndexWait(this, indexes);
  }

  Update update(args, [options]) => new Update(this, _funcWrap(args), options);

  Sync sync() => new Sync(this);

  GetAll getAll(args, [options]) {
    if (options != null && options is Map == false) {
      args = _listify(args, this);
      options = args.add(options);
      return new GetAll(args, options);
    }
    return new GetAll(_listify(args, this), options);
  }

  InnerJoin innerJoin(otherSeq, [predicate]) =>
      new InnerJoin(this, otherSeq, predicate);

  noSuchMethod(Invocation invocation) {
    if (this._errDepth == 0) {
      _errDepth++;
      Symbol methodName = invocation.memberName;
      List argsList = [];
      argsList.addAll(invocation.positionalArguments);

      InstanceMirror im = reflect(this);

      return im.invoke(methodName, [argsList]).reflectee;
    } else {
      throw new RqlDriverError(
          "${this.runtimeType} has no function ${MirrorSystem.getName(invocation.memberName)}");
    }
  }
}

class Get extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.GET;

  Get(table, key) : super([table, key]);

  call(attr) {
    return new GetField(this, attr);
  }
}

class GetAll extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.GET_ALL;

  GetAll(keys, [options]) : super(keys, options);

  call(attr) {
    return new GetField(this, attr);
  }
}

class Reduce extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.REDUCE;

  Reduce(seq, reductionFunction, [base])
      : super([seq, reductionFunction], base);
}

class Sum extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SUM;

  Sum(obj, args) : super([obj, args]);
}

class Avg extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.AVG;

  Avg(obj, args) : super([obj, args]);
}

class Min extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.MIN;

  Min(obj, args) : super([obj, args]);
}

class Max extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.MAX;

  Max(obj, args) : super([obj, args]);
}

class RqlMap extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.MAP;

  RqlMap(argslist, expression) : super([]) {
    List temp = [];
    temp.addAll(argslist);
    temp.add(_funcWrap(expression));
    this.args.addAll(temp.map(_expr));
  }
}

class Filter extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.FILTER;

  Filter(selection, predicate, [Map options])
      : super([selection, predicate], options);
}

class ConcatMap extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.CONCAT_MAP;

  ConcatMap(seq, mappingFunction) : super([seq, mappingFunction]);
}

class OrderBy extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.ORDER_BY;

  OrderBy(args, [Map options]) : super(args, options);
}

class Distinct extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DISTINCT;

  Distinct(sequence) : super([sequence]);
}

class Count extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.COUNT;

  Count([seq, filter]) : super([seq, filter]);
}

class Union extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.UNION;

  Union(first, second) : super([first, second]);
}

class Nth extends RqlBracketQuery {
  p.Term_TermType tt = p.Term_TermType.NTH;

  Nth(selection, int index) : super([selection, index]);
}

class Match extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.MATCH;

  Match(obj, regex) : super([obj, regex]);
}

class Split extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SPLIT;

  Split(tbl, [obj, maxSplits]) : super([tbl, obj, maxSplits]);
}

class Upcase extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.UPCASE;

  Upcase(obj) : super([obj]);
}

class Downcase extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DOWNCASE;

  Downcase(obj) : super([obj]);
}

class OffsetsOf extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.OFFSETS_OF;

  OffsetsOf(seq, index) : super([seq, index]);
}

class IsEmpty extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.IS_EMPTY;

  IsEmpty(selection) : super([selection]);
}

class Group extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.GROUP;

  Group(obj, group, [options]) : super([obj, group], options);
}

class InnerJoin extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INNER_JOIN;

  InnerJoin(first, second, predicate) : super([first, second, predicate]);
}

class OuterJoin extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.OUTER_JOIN;

  OuterJoin(first, second, predicate) : super([first, second, predicate]);
}

class EqJoin extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.EQ_JOIN;

  EqJoin(first, second, predicate, [Map options])
      : super([first, second, predicate], options);
}

class Zip extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.ZIP;

  Zip(seq) : super([seq]);
}

class CoerceTo extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.COERCE_TO;

  CoerceTo(obj, String type) : super([obj, type]);
}

class Ungroup extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.UNGROUP;

  Ungroup(obj) : super([obj]);
}

class TypeOf extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TYPE_OF;

  TypeOf(obj) : super([obj]);
}

class Update extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.UPDATE;

  Update(tbl, expression, [Map options]) : super([tbl, expression], options);
}

class Delete extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DELETE;

  Delete(selection, [Map options]) : super([selection], options);
}

class Replace extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.REPLACE;

  Replace(table, expression, [options]) : super([table, expression], options);
}

class Insert extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INSERT;

  Insert(table, records, [Map options]) : super([table, records], options);
}

class DbCreate extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.DB_CREATE;

  DbCreate(String dbName, [Map options]) : super([dbName], options);
}

class DbDrop extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.DB_DROP;

  DbDrop(String dbName, [Map options]) : super([dbName], options);
}

class DbList extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.DB_LIST;

  DbList() : super();
}

class Range extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.RANGE;

  Range(end) : super([end]);

  Range.asStream() : super([]);

  Range.withStart(start, end) : super([start, end]);
}

class TableCreate extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TABLE_CREATE;

  TableCreate(table, [Map options]) : super([table], options);

  TableCreate.fromDB(db, table, [Map options]) : super([db, table], options);
}

class TableDrop extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TABLE_DROP;

  TableDrop(tbl, [Map options]) : super([tbl], options);

  TableDrop.fromDB(db, tbl, [Map options]) : super([db, tbl], options);
}

class TableList extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TABLE_LIST;

  TableList([db]) : super(db == null ? [] : [db]);
}

class IndexCreate extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INDEX_CREATE;

  IndexCreate(tbl, index, [Map options]) : super([tbl, index], options);

  IndexCreate.withIndexFunction(tbl, index, [indexFunction, Map options])
      : super([tbl, index, indexFunction], options);
}

class IndexDrop extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INDEX_DROP;

  IndexDrop(table, index) : super([table, index]);
}

class IndexRename extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INDEX_RENAME;

  IndexRename(table, oldName, newName, options)
      : super([table, oldName, newName], options);
}

class IndexList extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INDEX_LIST;

  IndexList(table) : super([table]);
}

class IndexStatus extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INDEX_STATUS;

  IndexStatus(tbl, indexList)
      : super([tbl, indexList is List ? new Args(indexList) : indexList]);
  IndexStatus.all(tbl) : super([tbl]);
}

class IndexWait extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INDEX_WAIT;

  IndexWait(tbl, indexList)
      : super([tbl, indexList is List ? new Args(indexList) : indexList]);
  IndexWait.all(tbl) : super([tbl]);
}

class Sync extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SYNC;

  Sync(table) : super([table]);
}

class Branch extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.BRANCH;

  Branch(predicate, trueBranch, falseBranch)
      : super([predicate, trueBranch, falseBranch]);
  Branch.fromArgs(Args args) : super([args]);
}

class Or extends RqlBoolOperQuery {
  p.Term_TermType tt = p.Term_TermType.OR;

  Or(orables) : super(orables);
}

class And extends RqlBoolOperQuery {
  p.Term_TermType tt = p.Term_TermType.AND;

  And(andables) : super(andables);
}

class ForEach extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.FOR_EACH;

  ForEach(obj, writeQuery) : super([obj, writeQuery]);
}

class Info extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INFO;

  Info(knowable) : super([knowable]);
}

class InsertAt extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INSERT_AT;

  InsertAt(ar, index, value) : super([ar, index, value]);
}

class SpliceAt extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SPLICE_AT;

  SpliceAt(ar, index, value) : super([ar, index, value]);
}

class DeleteAt extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DELETE_AT;

  DeleteAt(ar, index, value) : super([ar, index, value]);
}

class ChangeAt extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.CHANGE_AT;

  ChangeAt(ar, index, value) : super([ar, index, value]);
}

class Sample extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SAMPLE;

  Sample(selection, int i) : super([selection, i]);
}

class Uuid extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.UUID;
  Uuid(str) : super(str == null ? [] : [str]);
}

class Json extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.JSON;

  Json(String jsonString, [Map options]) : super([jsonString], options);
}

class Args extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.ARGS;

  Args(List array) : super([array]);
}

class ToISO8601 extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TO_ISO8601;

  ToISO8601(obj) : super([obj]);
}

class During extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DURING;

  During(obj, start, end, [Map options]) : super([obj, start, end], options);
}

class Date extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DATE;

  Date(obj) : super([obj]);
}

class TimeOfDay extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TIME_OF_DAY;

  TimeOfDay(obj) : super([obj]);
}

class Timezone extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TIMEZONE;

  Timezone(zone) : super([zone]);
}

class Year extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.YEAR;

  Year(year) : super([year]);
}

class Month extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.MONTH;

  Month(month) : super([month]);
}

class Day extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DAY;

  Day(day) : super([day]);
}

class DayOfWeek extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DAY_OF_WEEK;

  DayOfWeek(dow) : super([dow]);
}

class DayOfYear extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DAY_OF_YEAR;

  DayOfYear(doy) : super([doy]);
}

class Hours extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.HOURS;

  Hours(hours) : super([hours]);
}

class Minutes extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.MINUTES;

  Minutes(minutes) : super([minutes]);
}

class Seconds extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.SECONDS;

  Seconds(seconds) : super([seconds]);
}

class Binary extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.BINARY;
  Binary(data) : super([data]);
}

class Time extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.TIME;

  Time(Args args) : super([args]);

  Time.withHour(int year, int month, int day, String timezone, int hour)
      : super([year, month, day, hour, timezone]);

  Time.withMinute(
      int year, int month, int day, String timezone, int hour, int minute)
      : super([year, month, day, hour, minute, timezone]);

  Time.withSecond(int year, int month, int day, String timezone, int hour,
      int minute, int second)
      : super([year, month, day, hour, minute, second, timezone]);
}

class RqlISO8601 extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.ISO8601;

  RqlISO8601(strTime, [defaultTimeZone = "Z"])
      : super([strTime], {"default_timezone": defaultTimeZone});
}

class EpochTime extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.EPOCH_TIME;

  EpochTime(eptime) : super([eptime]);
}

class Now extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.NOW;

  Now() : super();
}

class InTimezone extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.IN_TIMEZONE;

  InTimezone(zoneable, tz) : super([zoneable, tz]);
}

class ToEpochTime extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TO_EPOCH_TIME;

  ToEpochTime(obj) : super([obj]);
}

class Func extends RqlQuery {
  p.Term_TermType tt = p.Term_TermType.FUNC;
  Function fun;
  static int nextId = 0;
  Func(this.fun) : super([], null) {
    ClosureMirror closure = reflect(fun);
    int x = closure.function.parameters.length;
    List vrs = [];
    List vrids = [];

    for (int i = 0; i < x; i++) {
      vrs.add(new Var(Func.nextId));
      vrids.add(Func.nextId);
      Func.nextId++;
    }

    this.args = [new MakeArray(vrids), _expr(Function.apply(fun, vrs))];
  }
}

class Asc extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.ASC;

  Asc(obj) : super([obj]);
}

class Desc extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.DESC;

  Desc(attr) : super([attr]);
}

class Literal extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.LITERAL;

  Literal(attr) : super([attr]);
}

class Circle extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.CIRCLE;

  Circle(point, radius, [Map options]) : super([point, radius], options);
}

class Distance extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.DISTANCE;

  Distance(obj, geo, [Map options]) : super([obj, geo], options);
}

class Fill extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.FILL;

  Fill(obj) : super([obj]);
}

class GeoJson extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.GEOJSON;

  GeoJson(Map geoJson) : super([geoJson]);
}

class ToGeoJson extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.TO_GEOJSON;

  ToGeoJson(obj) : super([obj]);
}

class GetIntersecting extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.GET_INTERSECTING;

  GetIntersecting(table, geo, [Map options]) : super([table, geo], options);
}

class GetNearest extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.GET_NEAREST;

  GetNearest(table, point, Map options) : super([table, point], options);
}

class Includes extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INCLUDES;

  Includes(obj, geo) : super([obj, geo]);
}

class Intersects extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.INTERSECTS;

  Intersects(obj, geo) : super([obj, geo]);
}

class Line extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.LINE;

  Line(points) : super(points);
}

class Point extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.POINT;

  Point(long, lat) : super([long, lat]);
}

class Polygon extends RqlTopLevelQuery {
  p.Term_TermType tt = p.Term_TermType.POLYGON;

  Polygon(points) : super(points);
}

class PolygonSub extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.POLYGON_SUB;

  PolygonSub(var poly1, var poly2) : super([poly1, poly2]);
}

class Config extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.CONFIG;

  Config(obj) : super([obj]);
}

class Rebalance extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.REBALANCE;

  Rebalance(obj) : super([obj]);
}

class Reconfigure extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.RECONFIGURE;

  Reconfigure(obj, Map options) : super([obj], options);
}

class Status extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.STATUS;

  Status(obj) : super([obj]);
}

class Wait extends RqlMethodQuery {
  p.Term_TermType tt = p.Term_TermType.WAIT;

  Wait(obj, [Map options]) : super([obj], options);
}

class RqlTimeName extends RqlQuery {
  p.Term_TermType tt;

  RqlTimeName(this.tt) : super();
}

class RqlConstant extends RqlQuery {
  p.Term_TermType tt;

  RqlConstant(this.tt) : super();
}

class _RqlAllOptions {
  //list of every option from any term
  List options;

  _RqlAllOptions(p.Term_TermType tt) {
    switch (tt) {
      case p.Term_TermType.TABLE_CREATE:
        options = ['primary_key', 'durability', 'datacenter'];
        break;
      case p.Term_TermType.INSERT:
        options = ['durability', 'return_changes', 'conflict'];
        break;
      case p.Term_TermType.UPDATE:
        options = ['durability', 'return_changes', 'non_atomic'];
        break;
      case p.Term_TermType.REPLACE:
        options = ['durability', 'return_changes', 'non_atomic'];
        break;
      case p.Term_TermType.DELETE:
        options = ['durability', 'return_changes'];
        break;
      case p.Term_TermType.TABLE:
        options = ['read_mode'];
        break;
      case p.Term_TermType.INDEX_CREATE:
        options = ["multi"];
        break;
      case p.Term_TermType.GET_ALL:
        options = ['index'];
        break;
      case p.Term_TermType.BETWEEN:
        options = ['index', 'left_bound', 'right_bound'];
        break;
      case p.Term_TermType.FILTER:
        options = ['default'];
        break;
      case p.Term_TermType.CHANGES:
        options = ['includeOffsets', 'includeTypes'];
        break;
      case p.Term_TermType.EQ_JOIN:
        options = ['index', 'ordered'];
        break;
      case p.Term_TermType.UNION:
        options = ['interleave'];
        break;
      case p.Term_TermType.SLICE:
        options = ['left_bound', 'right_bound'];
        break;
      case p.Term_TermType.GROUP:
        options = ['index'];
        break;
      case p.Term_TermType.RANDOM:
        options = ['float'];
        break;
      case p.Term_TermType.ISO8601:
        options = ['default_timezone'];
        break;
      case p.Term_TermType.DURING:
        options = ['left_bound', 'right_bound'];
        break;
      case p.Term_TermType.JAVASCRIPT:
        options = ['timeout'];
        break;
      case p.Term_TermType.HTTP:
        options = [
          'timeout',
          'attempts',
          'redirects',
          'verify',
          'result_format',
          'method',
          'auth',
          'params',
          'header',
          'data',
          'page',
          'page_limit'
        ];
        break;
      case p.Term_TermType.CIRCLE:
        options = ['num_vertices', 'geo_system', 'unit', 'fill'];
        break;
      case p.Term_TermType.GET_NEAREST:
        options = ['index', 'max_results', 'max_dist', 'unit', 'geo_system'];
        break;
      case p.Term_TermType.RECONFIGURE:
        options = [
          'shards',
          'replicas',
          'primary_replica_tag',
          'dry_run',
          "emergency_repair"
        ];
        break;
      case p.Term_TermType.WAIT:
        options = ['wait_for', 'timeout'];
        break;
      default:
        options = [];
    }
  }
}
