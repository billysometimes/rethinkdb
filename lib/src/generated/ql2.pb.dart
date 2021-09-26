///
//  Generated code. Do not modify.
//  source: ql2.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import 'ql2.pbenum.dart';

export 'ql2.pbenum.dart';

class VersionDummy extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('VersionDummy')
    ..hasRequiredFields = false;

  VersionDummy._() : super();
  factory VersionDummy() => create();
  factory VersionDummy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory VersionDummy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  VersionDummy clone() => VersionDummy()..mergeFromMessage(this);
  VersionDummy copyWith(void Function(VersionDummy) updates) =>
      super.copyWith((message) => updates(message as VersionDummy));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VersionDummy create() => VersionDummy._();
  VersionDummy createEmptyInstance() => create();
  static $pb.PbList<VersionDummy> createRepeated() =>
      $pb.PbList<VersionDummy>();
  static VersionDummy getDefault() => _defaultInstance ??= create()..freeze();
  static VersionDummy _defaultInstance;
}

class Query_AssocPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Query.AssocPair')
    ..aOS(1, 'key')
    ..a<Term>(2, 'val', $pb.PbFieldType.OM, Term.getDefault, Term.create)
    ..hasRequiredFields = false;

  Query_AssocPair._() : super();
  factory Query_AssocPair() => create();
  factory Query_AssocPair.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Query_AssocPair.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Query_AssocPair clone() => Query_AssocPair()..mergeFromMessage(this);
  Query_AssocPair copyWith(void Function(Query_AssocPair) updates) =>
      super.copyWith((message) => updates(message as Query_AssocPair));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Query_AssocPair create() => Query_AssocPair._();
  Query_AssocPair createEmptyInstance() => create();
  static $pb.PbList<Query_AssocPair> createRepeated() =>
      $pb.PbList<Query_AssocPair>();
  static Query_AssocPair getDefault() =>
      _defaultInstance ??= create()..freeze();
  static Query_AssocPair _defaultInstance;

  $core.String get key => $_getS(0, '');
  set key($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  Term get val => $_getN(1);
  set val(Term v) {
    setField(2, v);
  }

  $core.bool hasVal() => $_has(1);
  void clearVal() => clearField(2);
}

class Query extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Query')
    ..e<Query_QueryType>(1, 'type', $pb.PbFieldType.OE, Query_QueryType.START,
        Query_QueryType.valueOf, Query_QueryType.values)
    ..a<Term>(2, 'query', $pb.PbFieldType.OM, Term.getDefault, Term.create)
    ..aInt64(3, 'token')
    ..aOB(4, 'oBSOLETENoreply')
    ..aOB(5, 'acceptsRJson')
    ..pc<Query_AssocPair>(
        6, 'globalOptargs', $pb.PbFieldType.PM, Query_AssocPair.create)
    ..hasRequiredFields = false;

  Query._() : super();
  factory Query() => create();
  factory Query.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Query.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Query clone() => Query()..mergeFromMessage(this);
  Query copyWith(void Function(Query) updates) =>
      super.copyWith((message) => updates(message as Query));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Query create() => Query._();
  Query createEmptyInstance() => create();
  static $pb.PbList<Query> createRepeated() => $pb.PbList<Query>();
  static Query getDefault() => _defaultInstance ??= create()..freeze();
  static Query _defaultInstance;

  Query_QueryType get type => $_getN(0);
  set type(Query_QueryType v) {
    setField(1, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Term get query => $_getN(1);
  set query(Term v) {
    setField(2, v);
  }

  $core.bool hasQuery() => $_has(1);
  void clearQuery() => clearField(2);

  Int64 get token => $_getI64(2);
  set token(Int64 v) {
    $_setInt64(2, v);
  }

  $core.bool hasToken() => $_has(2);
  void clearToken() => clearField(3);

  $core.bool get oBSOLETENoreply => $_get(3, false);
  set oBSOLETENoreply($core.bool v) {
    $_setBool(3, v);
  }

  $core.bool hasOBSOLETENoreply() => $_has(3);
  void clearOBSOLETENoreply() => clearField(4);

  $core.bool get acceptsRJson => $_get(4, false);
  set acceptsRJson($core.bool v) {
    $_setBool(4, v);
  }

  $core.bool hasAcceptsRJson() => $_has(4);
  void clearAcceptsRJson() => clearField(5);

  $core.List<Query_AssocPair> get globalOptargs => $_getList(5);
}

class Frame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Frame')
    ..e<Frame_FrameType>(1, 'type', $pb.PbFieldType.OE, Frame_FrameType.POS,
        Frame_FrameType.valueOf, Frame_FrameType.values)
    ..aInt64(2, 'pos')
    ..aOS(3, 'opt')
    ..hasRequiredFields = false;

  Frame._() : super();
  factory Frame() => create();
  factory Frame.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Frame.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Frame clone() => Frame()..mergeFromMessage(this);
  Frame copyWith(void Function(Frame) updates) =>
      super.copyWith((message) => updates(message as Frame));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Frame create() => Frame._();
  Frame createEmptyInstance() => create();
  static $pb.PbList<Frame> createRepeated() => $pb.PbList<Frame>();
  static Frame getDefault() => _defaultInstance ??= create()..freeze();
  static Frame _defaultInstance;

  Frame_FrameType get type => $_getN(0);
  set type(Frame_FrameType v) {
    setField(1, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Int64 get pos => $_getI64(1);
  set pos(Int64 v) {
    $_setInt64(1, v);
  }

  $core.bool hasPos() => $_has(1);
  void clearPos() => clearField(2);

  $core.String get opt => $_getS(2, '');
  set opt($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasOpt() => $_has(2);
  void clearOpt() => clearField(3);
}

class Backtrace extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Backtrace')
    ..pc<Frame>(1, 'frames', $pb.PbFieldType.PM, Frame.create)
    ..hasRequiredFields = false;

  Backtrace._() : super();
  factory Backtrace() => create();
  factory Backtrace.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Backtrace.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Backtrace clone() => Backtrace()..mergeFromMessage(this);
  Backtrace copyWith(void Function(Backtrace) updates) =>
      super.copyWith((message) => updates(message as Backtrace));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Backtrace create() => Backtrace._();
  Backtrace createEmptyInstance() => create();
  static $pb.PbList<Backtrace> createRepeated() => $pb.PbList<Backtrace>();
  static Backtrace getDefault() => _defaultInstance ??= create()..freeze();
  static Backtrace _defaultInstance;

  $core.List<Frame> get frames => $_getList(0);
}

class Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Response')
    ..e<Response_ResponseType>(
        1,
        'type',
        $pb.PbFieldType.OE,
        Response_ResponseType.SUCCESS_ATOM,
        Response_ResponseType.valueOf,
        Response_ResponseType.values)
    ..aInt64(2, 'token')
    ..pc<Datum>(3, 'response', $pb.PbFieldType.PM, Datum.create)
    ..a<Backtrace>(4, 'backtrace', $pb.PbFieldType.OM, Backtrace.getDefault,
        Backtrace.create)
    ..a<Datum>(5, 'profile', $pb.PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pc<Response_ResponseNote>(6, 'notes', $pb.PbFieldType.PE, null,
        Response_ResponseNote.valueOf, Response_ResponseNote.values)
    ..e<Response_ErrorType>(
        7,
        'errorType',
        $pb.PbFieldType.OE,
        Response_ErrorType.INTERNAL,
        Response_ErrorType.valueOf,
        Response_ErrorType.values)
    ..hasRequiredFields = false;

  Response._() : super();
  factory Response() => create();
  factory Response.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Response.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Response clone() => Response()..mergeFromMessage(this);
  Response copyWith(void Function(Response) updates) =>
      super.copyWith((message) => updates(message as Response));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  Response createEmptyInstance() => create();
  static $pb.PbList<Response> createRepeated() => $pb.PbList<Response>();
  static Response getDefault() => _defaultInstance ??= create()..freeze();
  static Response _defaultInstance;

  Response_ResponseType get type => $_getN(0);
  set type(Response_ResponseType v) {
    setField(1, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Int64 get token => $_getI64(1);
  set token(Int64 v) {
    $_setInt64(1, v);
  }

  $core.bool hasToken() => $_has(1);
  void clearToken() => clearField(2);

  $core.List<Datum> get response => $_getList(2);

  Backtrace get backtrace => $_getN(3);
  set backtrace(Backtrace v) {
    setField(4, v);
  }

  $core.bool hasBacktrace() => $_has(3);
  void clearBacktrace() => clearField(4);

  Datum get profile => $_getN(4);
  set profile(Datum v) {
    setField(5, v);
  }

  $core.bool hasProfile() => $_has(4);
  void clearProfile() => clearField(5);

  $core.List<Response_ResponseNote> get notes => $_getList(5);

  Response_ErrorType get errorType => $_getN(6);
  set errorType(Response_ErrorType v) {
    setField(7, v);
  }

  $core.bool hasErrorType() => $_has(6);
  void clearErrorType() => clearField(7);
}

class Datum_AssocPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Datum.AssocPair')
    ..aOS(1, 'key')
    ..a<Datum>(2, 'val', $pb.PbFieldType.OM, Datum.getDefault, Datum.create)
    ..hasRequiredFields = false;

  Datum_AssocPair._() : super();
  factory Datum_AssocPair() => create();
  factory Datum_AssocPair.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Datum_AssocPair.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Datum_AssocPair clone() => Datum_AssocPair()..mergeFromMessage(this);
  Datum_AssocPair copyWith(void Function(Datum_AssocPair) updates) =>
      super.copyWith((message) => updates(message as Datum_AssocPair));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Datum_AssocPair create() => Datum_AssocPair._();
  Datum_AssocPair createEmptyInstance() => create();
  static $pb.PbList<Datum_AssocPair> createRepeated() =>
      $pb.PbList<Datum_AssocPair>();
  static Datum_AssocPair getDefault() =>
      _defaultInstance ??= create()..freeze();
  static Datum_AssocPair _defaultInstance;

  $core.String get key => $_getS(0, '');
  set key($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  Datum get val => $_getN(1);
  set val(Datum v) {
    setField(2, v);
  }

  $core.bool hasVal() => $_has(1);
  void clearVal() => clearField(2);
}

class Datum extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Datum')
    ..e<Datum_DatumType>(1, 'type', $pb.PbFieldType.OE, Datum_DatumType.R_NULL,
        Datum_DatumType.valueOf, Datum_DatumType.values)
    ..aOB(2, 'rBool')
    ..a<$core.double>(3, 'rNum', $pb.PbFieldType.OD)
    ..aOS(4, 'rStr')
    ..pc<Datum>(5, 'rArray', $pb.PbFieldType.PM, Datum.create)
    ..pc<Datum_AssocPair>(
        6, 'rObject', $pb.PbFieldType.PM, Datum_AssocPair.create)
    ..hasRequiredFields = false;

  Datum._() : super();
  factory Datum() => create();
  factory Datum.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Datum.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Datum clone() => Datum()..mergeFromMessage(this);
  Datum copyWith(void Function(Datum) updates) =>
      super.copyWith((message) => updates(message as Datum));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Datum create() => Datum._();
  Datum createEmptyInstance() => create();
  static $pb.PbList<Datum> createRepeated() => $pb.PbList<Datum>();
  static Datum getDefault() => _defaultInstance ??= create()..freeze();
  static Datum _defaultInstance;

  Datum_DatumType get type => $_getN(0);
  set type(Datum_DatumType v) {
    setField(1, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  $core.bool get rBool => $_get(1, false);
  set rBool($core.bool v) {
    $_setBool(1, v);
  }

  $core.bool hasRBool() => $_has(1);
  void clearRBool() => clearField(2);

  $core.double get rNum => $_getN(2);
  set rNum($core.double v) {
    $_setDouble(2, v);
  }

  $core.bool hasRNum() => $_has(2);
  void clearRNum() => clearField(3);

  $core.String get rStr => $_getS(3, '');
  set rStr($core.String v) {
    $_setString(3, v);
  }

  $core.bool hasRStr() => $_has(3);
  void clearRStr() => clearField(4);

  $core.List<Datum> get rArray => $_getList(4);

  $core.List<Datum_AssocPair> get rObject => $_getList(5);
}

class Term_AssocPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Term.AssocPair')
    ..aOS(1, 'key')
    ..a<Term>(2, 'val', $pb.PbFieldType.OM, Term.getDefault, Term.create)
    ..hasRequiredFields = false;

  Term_AssocPair._() : super();
  factory Term_AssocPair() => create();
  factory Term_AssocPair.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Term_AssocPair.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Term_AssocPair clone() => Term_AssocPair()..mergeFromMessage(this);
  Term_AssocPair copyWith(void Function(Term_AssocPair) updates) =>
      super.copyWith((message) => updates(message as Term_AssocPair));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Term_AssocPair create() => Term_AssocPair._();
  Term_AssocPair createEmptyInstance() => create();
  static $pb.PbList<Term_AssocPair> createRepeated() =>
      $pb.PbList<Term_AssocPair>();
  static Term_AssocPair getDefault() => _defaultInstance ??= create()..freeze();
  static Term_AssocPair _defaultInstance;

  $core.String get key => $_getS(0, '');
  set key($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  Term get val => $_getN(1);
  set val(Term v) {
    setField(2, v);
  }

  $core.bool hasVal() => $_has(1);
  void clearVal() => clearField(2);
}

class Term extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Term')
    ..e<Term_TermType>(1, 'type', $pb.PbFieldType.OE, Term_TermType.DATUM,
        Term_TermType.valueOf, Term_TermType.values)
    ..a<Datum>(2, 'datum', $pb.PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pc<Term>(3, 'args', $pb.PbFieldType.PM, Term.create)
    ..pc<Term_AssocPair>(
        4, 'optargs', $pb.PbFieldType.PM, Term_AssocPair.create)
    ..hasRequiredFields = false;

  Term._() : super();
  factory Term() => create();
  factory Term.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Term.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Term clone() => Term()..mergeFromMessage(this);
  Term copyWith(void Function(Term) updates) =>
      super.copyWith((message) => updates(message as Term));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Term create() => Term._();
  Term createEmptyInstance() => create();
  static $pb.PbList<Term> createRepeated() => $pb.PbList<Term>();
  static Term getDefault() => _defaultInstance ??= create()..freeze();
  static Term _defaultInstance;

  Term_TermType get type => $_getN(0);
  set type(Term_TermType v) {
    setField(1, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  Datum get datum => $_getN(1);
  set datum(Datum v) {
    setField(2, v);
  }

  $core.bool hasDatum() => $_has(1);
  void clearDatum() => clearField(2);

  $core.List<Term> get args => $_getList(2);

  $core.List<Term_AssocPair> get optargs => $_getList(3);
}
