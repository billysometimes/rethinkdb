///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library ql2;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import 'ql2.pbenum.dart';

export 'ql2.pbenum.dart';

class VersionDummy extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('VersionDummy')
    ..hasRequiredFields = false
  ;

  VersionDummy() : super();
  VersionDummy.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  VersionDummy.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  VersionDummy clone() => new VersionDummy()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static VersionDummy create() => new VersionDummy();
  static PbList<VersionDummy> createRepeated() => new PbList<VersionDummy>();
  static VersionDummy getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVersionDummy();
    return _defaultInstance;
  }
  static VersionDummy _defaultInstance;
  static void $checkItem(VersionDummy v) {
    if (v is! VersionDummy) checkItemFailed(v, 'VersionDummy');
  }
}

class _ReadonlyVersionDummy extends VersionDummy with ReadonlyMessageMixin {}

class Query_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query_AssocPair')
    ..a<String>(1, 'key', PbFieldType.OS)
    ..a<Term>(2, 'val', PbFieldType.OM, Term.getDefault, Term.create)
    ..hasRequiredFields = false
  ;

  Query_AssocPair() : super();
  Query_AssocPair.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query_AssocPair.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query_AssocPair clone() => new Query_AssocPair()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Query_AssocPair create() => new Query_AssocPair();
  static PbList<Query_AssocPair> createRepeated() => new PbList<Query_AssocPair>();
  static Query_AssocPair getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQuery_AssocPair();
    return _defaultInstance;
  }
  static Query_AssocPair _defaultInstance;
  static void $checkItem(Query_AssocPair v) {
    if (v is! Query_AssocPair) checkItemFailed(v, 'Query_AssocPair');
  }

  String get key => $_get(0, 1, '');
  set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Term get val => $_get(1, 2, null);
  set val(Term v) { setField(2, v); }
  bool hasVal() => $_has(1, 2);
  void clearVal() => clearField(2);
}

class _ReadonlyQuery_AssocPair extends Query_AssocPair with ReadonlyMessageMixin {}

class Query extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query')
    ..e<Query_QueryType>(1, 'type', PbFieldType.OE, Query_QueryType.START, Query_QueryType.valueOf)
    ..a<Term>(2, 'query', PbFieldType.OM, Term.getDefault, Term.create)
    ..a<Int64>(3, 'token', PbFieldType.O6, Int64.ZERO)
    ..a<bool>(4, 'oBSOLETENoreply', PbFieldType.OB)
    ..a<bool>(5, 'acceptsRJson', PbFieldType.OB)
    ..pp<Query_AssocPair>(6, 'globalOptargs', PbFieldType.PM, Query_AssocPair.$checkItem, Query_AssocPair.create)
    ..hasRequiredFields = false
  ;

  Query() : super();
  Query.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query clone() => new Query()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Query create() => new Query();
  static PbList<Query> createRepeated() => new PbList<Query>();
  static Query getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQuery();
    return _defaultInstance;
  }
  static Query _defaultInstance;
  static void $checkItem(Query v) {
    if (v is! Query) checkItemFailed(v, 'Query');
  }

  Query_QueryType get type => $_get(0, 1, null);
  set type(Query_QueryType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Term get query => $_get(1, 2, null);
  set query(Term v) { setField(2, v); }
  bool hasQuery() => $_has(1, 2);
  void clearQuery() => clearField(2);

  Int64 get token => $_get(2, 3, null);
  set token(Int64 v) { $_setInt64(2, 3, v); }
  bool hasToken() => $_has(2, 3);
  void clearToken() => clearField(3);

  bool get oBSOLETENoreply => $_get(3, 4, false);
  set oBSOLETENoreply(bool v) { $_setBool(3, 4, v); }
  bool hasOBSOLETENoreply() => $_has(3, 4);
  void clearOBSOLETENoreply() => clearField(4);

  bool get acceptsRJson => $_get(4, 5, false);
  set acceptsRJson(bool v) { $_setBool(4, 5, v); }
  bool hasAcceptsRJson() => $_has(4, 5);
  void clearAcceptsRJson() => clearField(5);

  List<Query_AssocPair> get globalOptargs => $_get(5, 6, null);
}

class _ReadonlyQuery extends Query with ReadonlyMessageMixin {}

class Frame extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Frame')
    ..e<Frame_FrameType>(1, 'type', PbFieldType.OE, Frame_FrameType.POS, Frame_FrameType.valueOf)
    ..a<Int64>(2, 'pos', PbFieldType.O6, Int64.ZERO)
    ..a<String>(3, 'opt', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Frame() : super();
  Frame.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Frame.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Frame clone() => new Frame()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Frame create() => new Frame();
  static PbList<Frame> createRepeated() => new PbList<Frame>();
  static Frame getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyFrame();
    return _defaultInstance;
  }
  static Frame _defaultInstance;
  static void $checkItem(Frame v) {
    if (v is! Frame) checkItemFailed(v, 'Frame');
  }

  Frame_FrameType get type => $_get(0, 1, null);
  set type(Frame_FrameType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Int64 get pos => $_get(1, 2, null);
  set pos(Int64 v) { $_setInt64(1, 2, v); }
  bool hasPos() => $_has(1, 2);
  void clearPos() => clearField(2);

  String get opt => $_get(2, 3, '');
  set opt(String v) { $_setString(2, 3, v); }
  bool hasOpt() => $_has(2, 3);
  void clearOpt() => clearField(3);
}

class _ReadonlyFrame extends Frame with ReadonlyMessageMixin {}

class Backtrace extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Backtrace')
    ..pp<Frame>(1, 'frames', PbFieldType.PM, Frame.$checkItem, Frame.create)
    ..hasRequiredFields = false
  ;

  Backtrace() : super();
  Backtrace.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Backtrace.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Backtrace clone() => new Backtrace()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Backtrace create() => new Backtrace();
  static PbList<Backtrace> createRepeated() => new PbList<Backtrace>();
  static Backtrace getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBacktrace();
    return _defaultInstance;
  }
  static Backtrace _defaultInstance;
  static void $checkItem(Backtrace v) {
    if (v is! Backtrace) checkItemFailed(v, 'Backtrace');
  }

  List<Frame> get frames => $_get(0, 1, null);
}

class _ReadonlyBacktrace extends Backtrace with ReadonlyMessageMixin {}

class Response extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Response')
    ..e<Response_ResponseType>(1, 'type', PbFieldType.OE, Response_ResponseType.SUCCESS_ATOM, Response_ResponseType.valueOf)
    ..a<Int64>(2, 'token', PbFieldType.O6, Int64.ZERO)
    ..pp<Datum>(3, 'response', PbFieldType.PM, Datum.$checkItem, Datum.create)
    ..a<Backtrace>(4, 'backtrace', PbFieldType.OM, Backtrace.getDefault, Backtrace.create)
    ..a<Datum>(5, 'profile', PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pp<Response_ResponseNote>(6, 'notes', PbFieldType.PE, Response_ResponseNote.$checkItem, null, Response_ResponseNote.valueOf)
    ..e<Response_ErrorType>(7, 'errorType', PbFieldType.OE, Response_ErrorType.INTERNAL, Response_ErrorType.valueOf)
    ..hasRequiredFields = false
  ;

  Response() : super();
  Response.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Response.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Response clone() => new Response()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Response create() => new Response();
  static PbList<Response> createRepeated() => new PbList<Response>();
  static Response getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResponse();
    return _defaultInstance;
  }
  static Response _defaultInstance;
  static void $checkItem(Response v) {
    if (v is! Response) checkItemFailed(v, 'Response');
  }

  Response_ResponseType get type => $_get(0, 1, null);
  set type(Response_ResponseType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Int64 get token => $_get(1, 2, null);
  set token(Int64 v) { $_setInt64(1, 2, v); }
  bool hasToken() => $_has(1, 2);
  void clearToken() => clearField(2);

  List<Datum> get response => $_get(2, 3, null);

  Backtrace get backtrace => $_get(3, 4, null);
  set backtrace(Backtrace v) { setField(4, v); }
  bool hasBacktrace() => $_has(3, 4);
  void clearBacktrace() => clearField(4);

  Datum get profile => $_get(4, 5, null);
  set profile(Datum v) { setField(5, v); }
  bool hasProfile() => $_has(4, 5);
  void clearProfile() => clearField(5);

  List<Response_ResponseNote> get notes => $_get(5, 6, null);

  Response_ErrorType get errorType => $_get(6, 7, null);
  set errorType(Response_ErrorType v) { setField(7, v); }
  bool hasErrorType() => $_has(6, 7);
  void clearErrorType() => clearField(7);
}

class _ReadonlyResponse extends Response with ReadonlyMessageMixin {}

class Datum_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Datum_AssocPair')
    ..a<String>(1, 'key', PbFieldType.OS)
    ..a<Datum>(2, 'val', PbFieldType.OM, Datum.getDefault, Datum.create)
    ..hasRequiredFields = false
  ;

  Datum_AssocPair() : super();
  Datum_AssocPair.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Datum_AssocPair.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Datum_AssocPair clone() => new Datum_AssocPair()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Datum_AssocPair create() => new Datum_AssocPair();
  static PbList<Datum_AssocPair> createRepeated() => new PbList<Datum_AssocPair>();
  static Datum_AssocPair getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDatum_AssocPair();
    return _defaultInstance;
  }
  static Datum_AssocPair _defaultInstance;
  static void $checkItem(Datum_AssocPair v) {
    if (v is! Datum_AssocPair) checkItemFailed(v, 'Datum_AssocPair');
  }

  String get key => $_get(0, 1, '');
  set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Datum get val => $_get(1, 2, null);
  set val(Datum v) { setField(2, v); }
  bool hasVal() => $_has(1, 2);
  void clearVal() => clearField(2);
}

class _ReadonlyDatum_AssocPair extends Datum_AssocPair with ReadonlyMessageMixin {}

class Datum extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Datum')
    ..e<Datum_DatumType>(1, 'type', PbFieldType.OE, Datum_DatumType.R_NULL, Datum_DatumType.valueOf)
    ..a<bool>(2, 'rBool', PbFieldType.OB)
    ..a<double>(3, 'rNum', PbFieldType.OD)
    ..a<String>(4, 'rStr', PbFieldType.OS)
    ..pp<Datum>(5, 'rArray', PbFieldType.PM, Datum.$checkItem, Datum.create)
    ..pp<Datum_AssocPair>(6, 'rObject', PbFieldType.PM, Datum_AssocPair.$checkItem, Datum_AssocPair.create)
    ..hasRequiredFields = false
  ;

  Datum() : super();
  Datum.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Datum.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Datum clone() => new Datum()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Datum create() => new Datum();
  static PbList<Datum> createRepeated() => new PbList<Datum>();
  static Datum getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDatum();
    return _defaultInstance;
  }
  static Datum _defaultInstance;
  static void $checkItem(Datum v) {
    if (v is! Datum) checkItemFailed(v, 'Datum');
  }

  Datum_DatumType get type => $_get(0, 1, null);
  set type(Datum_DatumType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  bool get rBool => $_get(1, 2, false);
  set rBool(bool v) { $_setBool(1, 2, v); }
  bool hasRBool() => $_has(1, 2);
  void clearRBool() => clearField(2);

  double get rNum => $_get(2, 3, null);
  set rNum(double v) { $_setDouble(2, 3, v); }
  bool hasRNum() => $_has(2, 3);
  void clearRNum() => clearField(3);

  String get rStr => $_get(3, 4, '');
  set rStr(String v) { $_setString(3, 4, v); }
  bool hasRStr() => $_has(3, 4);
  void clearRStr() => clearField(4);

  List<Datum> get rArray => $_get(4, 5, null);

  List<Datum_AssocPair> get rObject => $_get(5, 6, null);
}

class _ReadonlyDatum extends Datum with ReadonlyMessageMixin {}

class Term_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Term_AssocPair')
    ..a<String>(1, 'key', PbFieldType.OS)
    ..a<Term>(2, 'val', PbFieldType.OM, Term.getDefault, Term.create)
    ..hasRequiredFields = false
  ;

  Term_AssocPair() : super();
  Term_AssocPair.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Term_AssocPair.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Term_AssocPair clone() => new Term_AssocPair()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Term_AssocPair create() => new Term_AssocPair();
  static PbList<Term_AssocPair> createRepeated() => new PbList<Term_AssocPair>();
  static Term_AssocPair getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTerm_AssocPair();
    return _defaultInstance;
  }
  static Term_AssocPair _defaultInstance;
  static void $checkItem(Term_AssocPair v) {
    if (v is! Term_AssocPair) checkItemFailed(v, 'Term_AssocPair');
  }

  String get key => $_get(0, 1, '');
  set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Term get val => $_get(1, 2, null);
  set val(Term v) { setField(2, v); }
  bool hasVal() => $_has(1, 2);
  void clearVal() => clearField(2);
}

class _ReadonlyTerm_AssocPair extends Term_AssocPair with ReadonlyMessageMixin {}

class Term extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Term')
    ..e<Term_TermType>(1, 'type', PbFieldType.OE, Term_TermType.DATUM, Term_TermType.valueOf)
    ..a<Datum>(2, 'datum', PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pp<Term>(3, 'args', PbFieldType.PM, Term.$checkItem, Term.create)
    ..pp<Term_AssocPair>(4, 'optargs', PbFieldType.PM, Term_AssocPair.$checkItem, Term_AssocPair.create)
    ..hasRequiredFields = false
  ;

  Term() : super();
  Term.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Term.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Term clone() => new Term()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Term create() => new Term();
  static PbList<Term> createRepeated() => new PbList<Term>();
  static Term getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTerm();
    return _defaultInstance;
  }
  static Term _defaultInstance;
  static void $checkItem(Term v) {
    if (v is! Term) checkItemFailed(v, 'Term');
  }

  Term_TermType get type => $_get(0, 1, null);
  set type(Term_TermType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Datum get datum => $_get(1, 2, null);
  set datum(Datum v) { setField(2, v); }
  bool hasDatum() => $_has(1, 2);
  void clearDatum() => clearField(2);

  List<Term> get args => $_get(2, 3, null);

  List<Term_AssocPair> get optargs => $_get(3, 4, null);
}

class _ReadonlyTerm extends Term with ReadonlyMessageMixin {}
