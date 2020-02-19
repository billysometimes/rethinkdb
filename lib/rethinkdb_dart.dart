library rethinkdb;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'src/generated/ql2.pb.dart' as p;
import 'dart:convert';
import 'dart:collection';
import 'package:crypto/crypto.dart';
import 'package:pbkdf2_dart/pbkdf2_dart.dart';
import 'dart:math' as math;

part 'src/ast.dart';
part 'src/errors.dart';
part 'src/net.dart';
part 'src/cursor.dart';

class AddFunction {
  RqlQuery _rqlQuery;

  AddFunction([this._rqlQuery]);

  Add call(obj) {
    if (_rqlQuery != null) {
      return Add([_rqlQuery, obj]);
    } else if (obj is Args) {
      return Add([obj]);
    } else {
      throw RqlDriverError("Called add with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Add(positionalArguments);
  }
}

/// computes logical 'and' of two or more values
class AndFunction {
  RqlQuery _rqlQuery;

  AndFunction([this._rqlQuery]);

  And call(obj) {
    if (_rqlQuery != null) {
      return And([_rqlQuery, obj]);
    } else {
      throw RqlDriverError("Called and with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return And(positionalArguments);
  }
}

/// If the test expression returns false or null, the [falseBranch] will be executed.
/// In the other cases, the [trueBranch] is the one that will be evaluated.
class BranchFunction {
  Branch call(test, [trueBranch, falseBranch]) {
    return Branch(test, trueBranch, falseBranch);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return Branch.fromArgs(Args(invocation.positionalArguments));
  }
}

class DivFunction {
  RqlQuery _rqlQuery;

  DivFunction([this._rqlQuery]);

  Div call(number) {
    if (_rqlQuery != null) {
      return Div([_rqlQuery, number]);
    } else if (number is Args) {
      return Div([number]);
    } else {
      throw RqlDriverError("Called div with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Div(positionalArguments);
  }
}

class EqFunction {
  RqlQuery _rqlQuery;

  EqFunction([this._rqlQuery]);

  Eq call(value) {
    if (_rqlQuery != null) {
      return Eq([_rqlQuery, value]);
    } else if (value is Args) {
      return Eq([value]);
    } else {
      throw RqlDriverError("Called eq with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Eq(positionalArguments);
  }
}

class GeFunction {
  RqlQuery _rqlQuery;

  GeFunction([this._rqlQuery]);

  Ge call(number) {
    if (_rqlQuery != null) {
      return Ge([_rqlQuery, number]);
    } else if (number is Args) {
      return Ge([number]);
    } else {
      throw RqlDriverError("Called ge with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Ge(positionalArguments);
  }
}

class GtFunction {
  RqlQuery _rqlQuery;

  GtFunction([this._rqlQuery]);

  Gt call(number) {
    if (_rqlQuery != null) {
      return Gt([_rqlQuery, number]);
    } else if (number is Args) {
      return Gt([number]);
    } else {
      throw RqlDriverError("Called gt with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Gt(positionalArguments);
  }
}

class LeFunction {
  RqlQuery _rqlQuery;

  LeFunction([this._rqlQuery]);

  Le call(number) {
    if (_rqlQuery != null) {
      return Le([_rqlQuery, number]);
    } else if (number is Args) {
      return Le([number]);
    } else {
      throw RqlDriverError("Called le with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Le(positionalArguments);
  }
}

/// Construct a geometric line
class LineFunction {
  Line call(point1, point2) {
    return Line([point1, point2]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return Line(invocation.positionalArguments);
  }
}

class LtFunction {
  RqlQuery _rqlQuery;

  LtFunction([this._rqlQuery]);

  Lt call(number) {
    if (_rqlQuery != null) {
      return Lt([_rqlQuery, number]);
    } else if (number is Args) {
      return Lt([number]);
    } else {
      throw RqlDriverError("Called lt with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Lt(positionalArguments);
  }
}

/// Executes the mappingFunction for each item in a sequence or array
/// and returns the transformed array. multiple sequences and arrays
/// may be passed
class MapFunction {
  RqlMap call(seq, mappingFunction) {
    return RqlMap([seq], mappingFunction);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List args = List.from(invocation.positionalArguments);
    return RqlMap(args.sublist(0, args.length - 1), args.last);
  }
}

class MulFunction {
  RqlQuery _rqlQuery;

  MulFunction([this._rqlQuery]);

  Mul call(number) {
    if (_rqlQuery != null) {
      return Mul([_rqlQuery, number]);
    } else if (number is Args) {
      return Mul([number]);
    } else {
      throw RqlDriverError("Called mul with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Mul(positionalArguments);
  }
}

class NeFunction {
  RqlQuery _rqlQuery;

  NeFunction([this._rqlQuery]);

  Ne call(value) {
    if (_rqlQuery != null) {
      return Ne([_rqlQuery, value]);
    } else if (value is Args) {
      return Ne([value]);
    } else {
      throw RqlDriverError("Called ne with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Ne(positionalArguments);
  }
}

/// Adds fields to an object
class ObjectFunction {
  Rethinkdb _rethinkdb;

  ObjectFunction(this._rethinkdb);

  RqlObject call(args) {
    return RqlObject(args);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return _rethinkdb.object(invocation.positionalArguments);
  }
}

/// computes logical 'or' of two or more values
class OrFunction {
  RqlQuery _rqlQuery;

  OrFunction([this._rqlQuery]);

  Or call(number) {
    if (_rqlQuery != null) {
      return Or([_rqlQuery, number]);
    } else {
      throw RqlDriverError("Called or with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Or(positionalArguments);
  }
}

/// Construct a geometric polygon
class PolygonFunction {
  Polygon call(point1, point2, point3) {
    return Polygon([point1, point2, point3]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return Polygon(invocation.positionalArguments);
  }
}

/// Evaluate the expr in the context of one or more value bindings.
/// The type of the result is the type of the value returned from expr.
class RqlDoFunction {
  Rethinkdb _rethinkdb;

  RqlDoFunction(this._rethinkdb);

  FunCall call(arg, [expr]) {
    return FunCall(arg, expr);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List args = List.from(invocation.positionalArguments);
    return _rethinkdb.rqlDo(args.sublist(0, args.length - 1), args.last);
  }
}

class SubFunction {
  RqlQuery _rqlQuery;

  SubFunction([this._rqlQuery]);

  Sub call(number) {
    if (_rqlQuery != null) {
      return Sub([_rqlQuery, number]);
    } else if (number is Args) {
      return Sub([number]);
    } else {
      throw RqlDriverError("Called sub with too few values");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    List positionalArguments = [];
    if (_rqlQuery != null) {
      positionalArguments.add(_rqlQuery);
    }
    positionalArguments.addAll(invocation.positionalArguments);
    return Sub(positionalArguments);
  }
}

class Rethinkdb {
// Connection Management
  /// Create a new connection to the database server. Accepts the following options:
  /// host: the host to connect to (default localhost).
  /// port: the port to connect on (default 28015).
  /// db: the default database (defaults to test).
  /// user: the user name for the db (defaults to admin).
  /// password: password for the user (default "").
  Future<Connection> connect(
          {String db = 'test',
          String host = "localhost",
          int port = 28015,
          String user = "admin",
          String password = "",
          Map ssl}) =>
      Connection(db, host, port, user, password, ssl).reconnect();

  /// Reference a database.This command can be chained with other commands to do further processing on the data.
  DB db(String dbName) => DB(dbName);

  /// Create a database. A RethinkDB database is a collection of tables, similar to relational databases.
  /// If successful, the operation returns an object: {created: 1}. If a database with the same name already exists the operation throws RqlRuntimeError.
  /// Note: that you can only use alphanumeric characters and underscores for the database name.
  DbCreate dbCreate(String dbName) => DbCreate(dbName);

  /// Drop a database. The database, all its tables, and corresponding data will be deleted.
  /// If successful, the operation returns the object {dropped: 1}.
  /// If the specified database doesn't exist a RqlRuntimeError is thrown.
  DbDrop dbDrop(String dbName) => DbDrop(dbName, {});

  /// List all database names in the system. The result is a list of strings.
  DbList dbList() => DbList();

  /// Returns a rang bewteen the start and end values. If no start or
  /// end are specified, an 'infinite' stream will be returned.
  Range range([start, end]) {
    if (start == null) {
      return Range.asStream();
    } else if (end == null) {
      return Range(start);
    } else {
      return Range.withStart(start, end);
    }
  }

  /// Select all documents in a table. This command can be chained with other commands to do further processing on the data.
  Table table(String tableName, [Map options]) => Table(tableName, options);

  /// Create a table. A RethinkDB table is a collection of JSON documents.
  /// If successful, the operation returns an object: {created: 1}. If a table with the same name already exists, the operation throws RqlRuntimeError.
  /// Note: that you can only use alphanumeric characters and underscores for the table name.
  TableCreate tableCreate(String tableName, [Map options]) =>
      TableCreate(tableName, options);

  /// List all table names in a database. The result is a list of strings.
  TableList tableList() => TableList();

  /// Drop a table. The table and all its data will be deleted.
  TableDrop tableDrop(String tableName, [Map options]) =>
      TableDrop(tableName, options);

  /// Specify ascending order on an attribute
  Asc asc(String attr) => Asc(attr);

  /// Specify descending order on an attribute
  Desc desc(String attr) => Desc(attr);

  /// Create a time object for a specific time.
  Time time(int year, int month, int day,
      {String timezone = 'Z', int hour, int minute, num second}) {
    if (second != null) {
      return Time(Args([year, month, day, hour, minute, second, timezone]));
    } else {
      return Time(Args([year, month, day, timezone]));
    }
  }

  /// Create a time object from a Dart DateTime object.
  ///
  Time nativeTime(DateTime val) => expr(val);

  /// Create a time object based on an iso8601 date-time string (e.g. '2013-01-01T01:01:01+00:00').
  /// We support all valid ISO 8601 formats except for week dates.
  /// If you pass an ISO 8601 date-time without a time zone, you must specify the time zone with the optarg default_timezone.
  ///
  RqlISO8601 ISO8601(String stringTime, [defaultTimeZone = "Z"]) =>
      RqlISO8601(stringTime, defaultTimeZone);

  /// Create a time object based on seconds since epoch.
  ///  The first argument is a double and will be rounded to three decimal places (millisecond-precision).
  EpochTime epochTime(int eptime) => EpochTime(eptime);

  /// Return a time object representing the current time in UTC.
  ///  The command now() is computed once when the server receives the query, so multiple instances of r.now() will always return the same time inside a query.
  Now now() => Now();

  /// Evaluate the expr in the context of one or more value bindings.
  /// The type of the result is the type of the value returned from expr.
  dynamic get rqlDo => RqlDoFunction(this);

  /// If the test expression returns false or null, the [falseBranch] will be executed.
  /// In the other cases, the [trueBranch] is the one that will be evaluated.
  dynamic get branch => BranchFunction();

  /// Throw a runtime error. If called with no arguments inside the second argument to default, re-throw the current error.
  UserError error(String message) => UserError(message, {});

  /// Create a javascript expression.
  JavaScript js(String js, [Map options]) => JavaScript(js, options);

  /// Parse a JSON string on the server.
  Json json(String json) => Json(json, {});

  /// Count the total size of the group.
  Map count = {"COUNT": true};

  /// Compute the sum of the given field in the group.
  Map sum(String attr) => {'SUM': attr};

  /// Compute the average value of the given attribute for the group.
  Map avg(String attr) => {"AVG": attr};

  /// Returns the currently visited document.
  ImplicitVar row = ImplicitVar();

  /// Adds fields to an object

  dynamic get object => ObjectFunction(this);

  /// Acts like the ruby splat operator; unpacks a list of arguments.
  Args args(args) => Args(args);

  /// Returns data from a specified http url
  Http http(url, [optargs]) => Http(url, optargs);

  /// Generates a random number between two bounds
  Random random([left, right, options]) {
    if (right != null) {
      return Random.rightBound(left, right, options);
    } else if (left != null) {
      return Random.leftBound(left, options);
    } else {
      return Random(options);
    }
  }

  /// Returns logical inverse of the arguments given
  Not not([value]) => Not(value == null ? true : value);

  /// Executes the mappingFunction for each item in a sequence or array
  /// and returns the transformed array. multiple sequences and arrays
  /// may be passed
  dynamic get map => MapFunction();

  /// computes logical 'and' of two or more values
  dynamic get and => AndFunction();

  /// computes logical 'or' of two or more values
  dynamic get or => OrFunction();

  /// Replace an object in a field instead of merging it with an existing object in a [merge] or [update] operation.
  Literal literal(args) => Literal(args);

  /// Convert native dart object into a RqlObject
  expr(val) => RqlQuery()._expr(val);

  /// Convert a GeoJSON object to a ReQL geometry object.
  GeoJson geojson(Map geoJson) => GeoJson(geoJson);

  /// Construct a circular line or polygon.
  Circle circle(point, num radius, [Map options]) =>
      Circle(point, radius, options);

  /// Compute the distance between a point and a geometry object

  Distance distance(geo1, geo2, [Map options]) => Distance(geo1, geo2, options);

  /// Construct a geometric line
  dynamic get line => LineFunction();

  /// Construct a geometric point
  Point point(num long, num lat) => Point(long, lat);

  /// Construct a geometric polygon
  dynamic get polygon => PolygonFunction();

  dynamic get eq => EqFunction();

  dynamic get ne => NeFunction();

  dynamic get lt => LtFunction();

  dynamic get le => LeFunction();

  dynamic get gt => GtFunction();

  dynamic get ge => GeFunction();

  dynamic get add => AddFunction();

  dynamic get sub => SubFunction();

  dynamic get mul => MulFunction();

  dynamic get div => DivFunction();

  /// Encapsulate binary data within a query.
  Binary binary(var data) => Binary(data);

  RqlTimeName monday = RqlTimeName(p.Term_TermType.MONDAY);
  RqlTimeName tuesday = RqlTimeName(p.Term_TermType.TUESDAY);
  RqlTimeName wednesday = RqlTimeName(p.Term_TermType.WEDNESDAY);
  RqlTimeName thursday = RqlTimeName(p.Term_TermType.THURSDAY);
  RqlTimeName friday = RqlTimeName(p.Term_TermType.FRIDAY);
  RqlTimeName saturday = RqlTimeName(p.Term_TermType.SATURDAY);
  RqlTimeName sunday = RqlTimeName(p.Term_TermType.SUNDAY);

  RqlTimeName january = RqlTimeName(p.Term_TermType.JANUARY);
  RqlTimeName february = RqlTimeName(p.Term_TermType.FEBRUARY);
  RqlTimeName march = RqlTimeName(p.Term_TermType.MARCH);
  RqlTimeName april = RqlTimeName(p.Term_TermType.APRIL);
  RqlTimeName may = RqlTimeName(p.Term_TermType.MAY);
  RqlTimeName june = RqlTimeName(p.Term_TermType.JUNE);
  RqlTimeName july = RqlTimeName(p.Term_TermType.JULY);
  RqlTimeName august = RqlTimeName(p.Term_TermType.AUGUST);
  RqlTimeName september = RqlTimeName(p.Term_TermType.SEPTEMBER);
  RqlTimeName october = RqlTimeName(p.Term_TermType.OCTOBER);
  RqlTimeName november = RqlTimeName(p.Term_TermType.NOVEMBER);
  RqlTimeName december = RqlTimeName(p.Term_TermType.DECEMBER);

  RqlConstant minval = RqlConstant(p.Term_TermType.MINVAL);
  RqlConstant maxval = RqlConstant(p.Term_TermType.MAXVAL);

  Uuid uuid([str]) => Uuid(str);
}
