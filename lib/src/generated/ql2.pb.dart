///
//  Generated code. Do not modify.
//  source: ql2.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import 'ql2.pbenum.dart';

export 'ql2.pbenum.dart';

class VersionDummy extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('VersionDummy')
    ..hasRequiredFields = false
  ;

  VersionDummy() : super();
  VersionDummy.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  VersionDummy.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  VersionDummy clone() => new VersionDummy()..mergeFromMessage(this);
  VersionDummy copyWith(void Function(VersionDummy) updates) => super.copyWith((message) => updates(message as VersionDummy));
  $pb.BuilderInfo get info_ => _i;
  static VersionDummy create() => new VersionDummy();
  static $pb.PbList<VersionDummy> createRepeated() => new $pb.PbList<VersionDummy>();
  static VersionDummy getDefault() => _defaultInstance ??= create()..freeze();
  static VersionDummy _defaultInstance;
  static void $checkItem(VersionDummy v) {
    if (v is! VersionDummy) $pb.checkItemFailed(v, _i.messageName);
  }
}

class Query_AssocPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Query.AssocPair')
    ..aOS(1, 'key')
    ..a<Term>(2, 'val', $pb.PbFieldType.OM, Term.getDefault, Term.create)
    ..hasRequiredFields = false
  ;

  Query_AssocPair() : super();
  Query_AssocPair.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query_AssocPair.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query_AssocPair clone() => new Query_AssocPair()..mergeFromMessage(this);
  Query_AssocPair copyWith(void Function(Query_AssocPair) updates) => super.copyWith((message) => updates(message as Query_AssocPair));
  $pb.BuilderInfo get info_ => _i;
  static Query_AssocPair create() => new Query_AssocPair();
  static $pb.PbList<Query_AssocPair> createRepeated() => new $pb.PbList<Query_AssocPair>();
  static Query_AssocPair getDefault() => _defaultInstance ??= create()..freeze();
  static Query_AssocPair _defaultInstance;
  static void $checkItem(Query_AssocPair v) {
    if (v is! Query_AssocPair) $pb.checkItemFailed(v, _i.messageName);
  }

  String get key => $_getS(0, '');
  set key(String v) { $_setString(0, v); }
  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  Term get val => $_getN(1);
  set val(Term v) { setField(2, v); }
  bool hasVal() => $_has(1);
  void clearVal() => clearField(2);
}

class Query extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Query')
    ..e<Query_QueryType>(1, 'type', $pb.PbFieldType.OE, Query_QueryType.START, Query_QueryType.valueOf, Query_QueryType.values)
    ..a<Term>(2, 'query', $pb.PbFieldType.OM, Term.getDefault, Term.create)
    ..aInt64(3, 'token')
    ..aOB(4, 'oBSOLETENoreply')
    ..aOB(5, 'acceptsRJson')
    ..pp<Query_AssocPair>(6, 'globalOptargs', $pb.PbFieldType.PM, Query_AssocPair.$checkItem, Query_AssocPair.create)
    ..hasRequiredFields = false
  ;

  Query() : super();
  Query.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query clone() => new Query()..mergeFromMessage(this);
  Query copyWith(void Function(Query) updates) => super.copyWith((message) => updates(message as Query));
  $pb.BuilderInfo get info_ => _i;
  static Query create() => new Query();
  static $pb.PbList<Query> createRepeated() => new $pb.PbList<Query>();
  static Query getDefault() => _defaultInstance ??= create()..freeze();
  static Query _defaultInstance;
  static void $checkItem(Query v) {
    if (v is! Query) $pb.checkItemFailed(v, _i.messageName);
  }

  Query_QueryType get type => $_getN(0);
  set type(Query_QueryType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Term get query => $_getN(1);
  set query(Term v) { setField(2, v); }
  bool hasQuery() => $_has(1);
  void clearQuery() => clearField(2);

  Int64 get token => $_getI64(2);
  set token(Int64 v) { $_setInt64(2, v); }
  bool hasToken() => $_has(2);
  void clearToken() => clearField(3);

  bool get oBSOLETENoreply => $_get(3, false);
  set oBSOLETENoreply(bool v) { $_setBool(3, v); }
  bool hasOBSOLETENoreply() => $_has(3);
  void clearOBSOLETENoreply() => clearField(4);

  bool get acceptsRJson => $_get(4, false);
  set acceptsRJson(bool v) { $_setBool(4, v); }
  bool hasAcceptsRJson() => $_has(4);
  void clearAcceptsRJson() => clearField(5);

  List<Query_AssocPair> get globalOptargs => $_getList(5);
}

class Frame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Frame')
    ..e<Frame_FrameType>(1, 'type', $pb.PbFieldType.OE, Frame_FrameType.POS, Frame_FrameType.valueOf, Frame_FrameType.values)
    ..aInt64(2, 'pos')
    ..aOS(3, 'opt')
    ..hasRequiredFields = false
  ;

  Frame() : super();
  Frame.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Frame.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Frame clone() => new Frame()..mergeFromMessage(this);
  Frame copyWith(void Function(Frame) updates) => super.copyWith((message) => updates(message as Frame));
  $pb.BuilderInfo get info_ => _i;
  static Frame create() => new Frame();
  static $pb.PbList<Frame> createRepeated() => new $pb.PbList<Frame>();
  static Frame getDefault() => _defaultInstance ??= create()..freeze();
  static Frame _defaultInstance;
  static void $checkItem(Frame v) {
    if (v is! Frame) $pb.checkItemFailed(v, _i.messageName);
  }

  Frame_FrameType get type => $_getN(0);
  set type(Frame_FrameType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Int64 get pos => $_getI64(1);
  set pos(Int64 v) { $_setInt64(1, v); }
  bool hasPos() => $_has(1);
  void clearPos() => clearField(2);

  String get opt => $_getS(2, '');
  set opt(String v) { $_setString(2, v); }
  bool hasOpt() => $_has(2);
  void clearOpt() => clearField(3);
}

class Backtrace extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Backtrace')
    ..pp<Frame>(1, 'frames', $pb.PbFieldType.PM, Frame.$checkItem, Frame.create)
    ..hasRequiredFields = false
  ;

  Backtrace() : super();
  Backtrace.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Backtrace.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Backtrace clone() => new Backtrace()..mergeFromMessage(this);
  Backtrace copyWith(void Function(Backtrace) updates) => super.copyWith((message) => updates(message as Backtrace));
  $pb.BuilderInfo get info_ => _i;
  static Backtrace create() => new Backtrace();
  static $pb.PbList<Backtrace> createRepeated() => new $pb.PbList<Backtrace>();
  static Backtrace getDefault() => _defaultInstance ??= create()..freeze();
  static Backtrace _defaultInstance;
  static void $checkItem(Backtrace v) {
    if (v is! Backtrace) $pb.checkItemFailed(v, _i.messageName);
  }

  List<Frame> get frames => $_getList(0);
}

class Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Response')
    ..e<Response_ResponseType>(1, 'type', $pb.PbFieldType.OE, Response_ResponseType.SUCCESS_ATOM, Response_ResponseType.valueOf, Response_ResponseType.values)
    ..aInt64(2, 'token')
    ..pp<Datum>(3, 'response', $pb.PbFieldType.PM, Datum.$checkItem, Datum.create)
    ..a<Backtrace>(4, 'backtrace', $pb.PbFieldType.OM, Backtrace.getDefault, Backtrace.create)
    ..a<Datum>(5, 'profile', $pb.PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pp<Response_ResponseNote>(6, 'notes', $pb.PbFieldType.PE, Response_ResponseNote.$checkItem, null, Response_ResponseNote.valueOf, Response_ResponseNote.values)
    ..e<Response_ErrorType>(7, 'errorType', $pb.PbFieldType.OE, Response_ErrorType.INTERNAL, Response_ErrorType.valueOf, Response_ErrorType.values)
    ..hasRequiredFields = false
  ;

  Response() : super();
  Response.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Response.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Response clone() => new Response()..mergeFromMessage(this);
  Response copyWith(void Function(Response) updates) => super.copyWith((message) => updates(message as Response));
  $pb.BuilderInfo get info_ => _i;
  static Response create() => new Response();
  static $pb.PbList<Response> createRepeated() => new $pb.PbList<Response>();
  static Response getDefault() => _defaultInstance ??= create()..freeze();
  static Response _defaultInstance;
  static void $checkItem(Response v) {
    if (v is! Response) $pb.checkItemFailed(v, _i.messageName);
  }

  Response_ResponseType get type => $_getN(0);
  set type(Response_ResponseType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Int64 get token => $_getI64(1);
  set token(Int64 v) { $_setInt64(1, v); }
  bool hasToken() => $_has(1);
  void clearToken() => clearField(2);

  List<Datum> get response => $_getList(2);

  Backtrace get backtrace => $_getN(3);
  set backtrace(Backtrace v) { setField(4, v); }
  bool hasBacktrace() => $_has(3);
  void clearBacktrace() => clearField(4);

  Datum get profile => $_getN(4);
  set profile(Datum v) { setField(5, v); }
  bool hasProfile() => $_has(4);
  void clearProfile() => clearField(5);

  List<Response_ResponseNote> get notes => $_getList(5);

  Response_ErrorType get errorType => $_getN(6);
  set errorType(Response_ErrorType v) { setField(7, v); }
  bool hasErrorType() => $_has(6);
  void clearErrorType() => clearField(7);
}

class Datum_AssocPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Datum.AssocPair')
    ..aOS(1, 'key')
    ..a<Datum>(2, 'val', $pb.PbFieldType.OM, Datum.getDefault, Datum.create)
    ..hasRequiredFields = false
  ;

  Datum_AssocPair() : super();
  Datum_AssocPair.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Datum_AssocPair.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Datum_AssocPair clone() => new Datum_AssocPair()..mergeFromMessage(this);
  Datum_AssocPair copyWith(void Function(Datum_AssocPair) updates) => super.copyWith((message) => updates(message as Datum_AssocPair));
  $pb.BuilderInfo get info_ => _i;
  static Datum_AssocPair create() => new Datum_AssocPair();
  static $pb.PbList<Datum_AssocPair> createRepeated() => new $pb.PbList<Datum_AssocPair>();
  static Datum_AssocPair getDefault() => _defaultInstance ??= create()..freeze();
  static Datum_AssocPair _defaultInstance;
  static void $checkItem(Datum_AssocPair v) {
    if (v is! Datum_AssocPair) $pb.checkItemFailed(v, _i.messageName);
  }

  String get key => $_getS(0, '');
  set key(String v) { $_setString(0, v); }
  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  Datum get val => $_getN(1);
  set val(Datum v) { setField(2, v); }
  bool hasVal() => $_has(1);
  void clearVal() => clearField(2);
}

class Datum extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Datum')
    ..e<Datum_DatumType>(1, 'type', $pb.PbFieldType.OE, Datum_DatumType.R_NULL, Datum_DatumType.valueOf, Datum_DatumType.values)
    ..aOB(2, 'rBool')
    ..a<double>(3, 'rNum', $pb.PbFieldType.OD)
    ..aOS(4, 'rStr')
    ..pp<Datum>(5, 'rArray', $pb.PbFieldType.PM, Datum.$checkItem, Datum.create)
    ..pp<Datum_AssocPair>(6, 'rObject', $pb.PbFieldType.PM, Datum_AssocPair.$checkItem, Datum_AssocPair.create)
    ..hasRequiredFields = false
  ;

  Datum() : super();
  Datum.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Datum.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Datum clone() => new Datum()..mergeFromMessage(this);
  Datum copyWith(void Function(Datum) updates) => super.copyWith((message) => updates(message as Datum));
  $pb.BuilderInfo get info_ => _i;
  static Datum create() => new Datum();
  static $pb.PbList<Datum> createRepeated() => new $pb.PbList<Datum>();
  static Datum getDefault() => _defaultInstance ??= create()..freeze();
  static Datum _defaultInstance;
  static void $checkItem(Datum v) {
    if (v is! Datum) $pb.checkItemFailed(v, _i.messageName);
  }

  Datum_DatumType get type => $_getN(0);
  set type(Datum_DatumType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  bool get rBool => $_get(1, false);
  set rBool(bool v) { $_setBool(1, v); }
  bool hasRBool() => $_has(1);
  void clearRBool() => clearField(2);

  double get rNum => $_getN(2);
  set rNum(double v) { $_setDouble(2, v); }
  bool hasRNum() => $_has(2);
  void clearRNum() => clearField(3);

  String get rStr => $_getS(3, '');
  set rStr(String v) { $_setString(3, v); }
  bool hasRStr() => $_has(3);
  void clearRStr() => clearField(4);

  List<Datum> get rArray => $_getList(4);

  List<Datum_AssocPair> get rObject => $_getList(5);
}

class Term_AssocPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Term.AssocPair')
    ..aOS(1, 'key')
    ..a<Term>(2, 'val', $pb.PbFieldType.OM, Term.getDefault, Term.create)
    ..hasRequiredFields = false
  ;

  Term_AssocPair() : super();
  Term_AssocPair.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Term_AssocPair.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Term_AssocPair clone() => new Term_AssocPair()..mergeFromMessage(this);
  Term_AssocPair copyWith(void Function(Term_AssocPair) updates) => super.copyWith((message) => updates(message as Term_AssocPair));
  $pb.BuilderInfo get info_ => _i;
  static Term_AssocPair create() => new Term_AssocPair();
  static $pb.PbList<Term_AssocPair> createRepeated() => new $pb.PbList<Term_AssocPair>();
  static Term_AssocPair getDefault() => _defaultInstance ??= create()..freeze();
  static Term_AssocPair _defaultInstance;
  static void $checkItem(Term_AssocPair v) {
    if (v is! Term_AssocPair) $pb.checkItemFailed(v, _i.messageName);
  }

  String get key => $_getS(0, '');
  set key(String v) { $_setString(0, v); }
  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  Term get val => $_getN(1);
  set val(Term v) { setField(2, v); }
  bool hasVal() => $_has(1);
  void clearVal() => clearField(2);
}

class Term extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Term')
    ..e<Term_TermType>(1, 'type', $pb.PbFieldType.OE, Term_TermType.DATUM, Term_TermType.valueOf, Term_TermType.values)
    ..a<Datum>(2, 'datum', $pb.PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pp<Term>(3, 'args', $pb.PbFieldType.PM, Term.$checkItem, Term.create)
    ..pp<Term_AssocPair>(4, 'optargs', $pb.PbFieldType.PM, Term_AssocPair.$checkItem, Term_AssocPair.create)
    ..hasRequiredFields = false
  ;

  Term() : super();
  Term.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Term.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Term clone() => new Term()..mergeFromMessage(this);
  Term copyWith(void Function(Term) updates) => super.copyWith((message) => updates(message as Term));
  $pb.BuilderInfo get info_ => _i;
  static Term create() => new Term();
  static $pb.PbList<Term> createRepeated() => new $pb.PbList<Term>();
  static Term getDefault() => _defaultInstance ??= create()..freeze();
  static Term _defaultInstance;
  static void $checkItem(Term v) {
    if (v is! Term) $pb.checkItemFailed(v, _i.messageName);
  }

  Term_TermType get type => $_getN(0);
  set type(Term_TermType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Datum get datum => $_getN(1);
  set datum(Datum v) { setField(2, v); }
  bool hasDatum() => $_has(1);
  void clearDatum() => clearField(2);

  List<Term> get args => $_getList(2);

  List<Term_AssocPair> get optargs => $_getList(3);
}

