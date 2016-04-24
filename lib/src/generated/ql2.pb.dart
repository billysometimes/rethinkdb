///
//  Generated code. Do not modify.
///
library ql2;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class VersionDummy_Version extends ProtobufEnum {
  static const VersionDummy_Version V0_1 = const VersionDummy_Version._(1063369270, 'V0_1');
  static const VersionDummy_Version V0_2 = const VersionDummy_Version._(1915781601, 'V0_2');
  static const VersionDummy_Version V0_3 = const VersionDummy_Version._(1601562686, 'V0_3');
  static const VersionDummy_Version V0_4 = const VersionDummy_Version._(1074539808, 'V0_4');
  static const VersionDummy_Version V1_0 = const VersionDummy_Version._(885177795, 'V1_0');

  static const List<VersionDummy_Version> values = const <VersionDummy_Version> [
    V0_1,
    V0_2,
    V0_3,
    V0_4,
    V1_0,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static VersionDummy_Version valueOf(int value) => _byValue[value] as VersionDummy_Version;
  static void $checkItem(VersionDummy_Version v) {
    if (v is !VersionDummy_Version) checkItemFailed(v, 'VersionDummy_Version');
  }

  const VersionDummy_Version._(int v, String n) : super(v, n);
}

class VersionDummy_Protocol extends ProtobufEnum {
  static const VersionDummy_Protocol PROTOBUF = const VersionDummy_Protocol._(656407617, 'PROTOBUF');
  static const VersionDummy_Protocol JSON = const VersionDummy_Protocol._(2120839367, 'JSON');

  static const List<VersionDummy_Protocol> values = const <VersionDummy_Protocol> [
    PROTOBUF,
    JSON,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static VersionDummy_Protocol valueOf(int value) => _byValue[value] as VersionDummy_Protocol;
  static void $checkItem(VersionDummy_Protocol v) {
    if (v is !VersionDummy_Protocol) checkItemFailed(v, 'VersionDummy_Protocol');
  }

  const VersionDummy_Protocol._(int v, String n) : super(v, n);
}

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
    if (v is !VersionDummy) checkItemFailed(v, 'VersionDummy');
  }
}

class _ReadonlyVersionDummy extends VersionDummy with ReadonlyMessageMixin {}

class Query_QueryType extends ProtobufEnum {
  static const Query_QueryType START = const Query_QueryType._(1, 'START');
  static const Query_QueryType CONTINUE = const Query_QueryType._(2, 'CONTINUE');
  static const Query_QueryType STOP = const Query_QueryType._(3, 'STOP');
  static const Query_QueryType NOREPLY_WAIT = const Query_QueryType._(4, 'NOREPLY_WAIT');
  static const Query_QueryType SERVER_INFO = const Query_QueryType._(5, 'SERVER_INFO');

  static const List<Query_QueryType> values = const <Query_QueryType> [
    START,
    CONTINUE,
    STOP,
    NOREPLY_WAIT,
    SERVER_INFO,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Query_QueryType valueOf(int value) => _byValue[value] as Query_QueryType;
  static void $checkItem(Query_QueryType v) {
    if (v is !Query_QueryType) checkItemFailed(v, 'Query_QueryType');
  }

  const Query_QueryType._(int v, String n) : super(v, n);
}

class Query_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query_AssocPair')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<Term>*/(2, 'val', PbFieldType.OM, Term.getDefault, Term.create)
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
    if (v is !Query_AssocPair) checkItemFailed(v, 'Query_AssocPair');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Term get val => $_get(1, 2, null);
  void set val(Term v) { setField(2, v); }
  bool hasVal() => $_has(1, 2);
  void clearVal() => clearField(2);
}

class _ReadonlyQuery_AssocPair extends Query_AssocPair with ReadonlyMessageMixin {}

class Query extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query')
    ..e/*<Query_QueryType>*/(1, 'type', PbFieldType.OE, Query_QueryType.START, Query_QueryType.valueOf)
    ..a/*<Term>*/(2, 'query', PbFieldType.OM, Term.getDefault, Term.create)
    ..a/*<Int64>*/(3, 'token', PbFieldType.O6, Int64.ZERO)
    ..a/*<bool>*/(4, 'oBSOLETENoreply', PbFieldType.OB)
    ..a/*<bool>*/(5, 'acceptsRJson', PbFieldType.OB)
    ..pp/*<Query_AssocPair>*/(6, 'globalOptargs', PbFieldType.PM, Query_AssocPair.$checkItem, Query_AssocPair.create)
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
    if (v is !Query) checkItemFailed(v, 'Query');
  }

  Query_QueryType get type => $_get(0, 1, null);
  void set type(Query_QueryType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Term get query => $_get(1, 2, null);
  void set query(Term v) { setField(2, v); }
  bool hasQuery() => $_has(1, 2);
  void clearQuery() => clearField(2);

  Int64 get token => $_get(2, 3, null);
  void set token(Int64 v) { $_setInt64(2, 3, v); }
  bool hasToken() => $_has(2, 3);
  void clearToken() => clearField(3);

  bool get oBSOLETENoreply => $_get(3, 4, false);
  void set oBSOLETENoreply(bool v) { $_setBool(3, 4, v); }
  bool hasOBSOLETENoreply() => $_has(3, 4);
  void clearOBSOLETENoreply() => clearField(4);

  bool get acceptsRJson => $_get(4, 5, false);
  void set acceptsRJson(bool v) { $_setBool(4, 5, v); }
  bool hasAcceptsRJson() => $_has(4, 5);
  void clearAcceptsRJson() => clearField(5);

  List<Query_AssocPair> get globalOptargs => $_get(5, 6, null);
}

class _ReadonlyQuery extends Query with ReadonlyMessageMixin {}

class Frame_FrameType extends ProtobufEnum {
  static const Frame_FrameType POS = const Frame_FrameType._(1, 'POS');
  static const Frame_FrameType OPT = const Frame_FrameType._(2, 'OPT');

  static const List<Frame_FrameType> values = const <Frame_FrameType> [
    POS,
    OPT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Frame_FrameType valueOf(int value) => _byValue[value] as Frame_FrameType;
  static void $checkItem(Frame_FrameType v) {
    if (v is !Frame_FrameType) checkItemFailed(v, 'Frame_FrameType');
  }

  const Frame_FrameType._(int v, String n) : super(v, n);
}

class Frame extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Frame')
    ..e/*<Frame_FrameType>*/(1, 'type', PbFieldType.OE, Frame_FrameType.POS, Frame_FrameType.valueOf)
    ..a/*<Int64>*/(2, 'pos', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(3, 'opt', PbFieldType.OS)
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
    if (v is !Frame) checkItemFailed(v, 'Frame');
  }

  Frame_FrameType get type => $_get(0, 1, null);
  void set type(Frame_FrameType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Int64 get pos => $_get(1, 2, null);
  void set pos(Int64 v) { $_setInt64(1, 2, v); }
  bool hasPos() => $_has(1, 2);
  void clearPos() => clearField(2);

  String get opt => $_get(2, 3, '');
  void set opt(String v) { $_setString(2, 3, v); }
  bool hasOpt() => $_has(2, 3);
  void clearOpt() => clearField(3);
}

class _ReadonlyFrame extends Frame with ReadonlyMessageMixin {}

class Backtrace extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Backtrace')
    ..pp/*<Frame>*/(1, 'frames', PbFieldType.PM, Frame.$checkItem, Frame.create)
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
    if (v is !Backtrace) checkItemFailed(v, 'Backtrace');
  }

  List<Frame> get frames => $_get(0, 1, null);
}

class _ReadonlyBacktrace extends Backtrace with ReadonlyMessageMixin {}

class Response_ResponseType extends ProtobufEnum {
  static const Response_ResponseType SUCCESS_ATOM = const Response_ResponseType._(1, 'SUCCESS_ATOM');
  static const Response_ResponseType SUCCESS_SEQUENCE = const Response_ResponseType._(2, 'SUCCESS_SEQUENCE');
  static const Response_ResponseType SUCCESS_PARTIAL = const Response_ResponseType._(3, 'SUCCESS_PARTIAL');
  static const Response_ResponseType WAIT_COMPLETE = const Response_ResponseType._(4, 'WAIT_COMPLETE');
  static const Response_ResponseType SERVER_INFO = const Response_ResponseType._(5, 'SERVER_INFO');
  static const Response_ResponseType CLIENT_ERROR = const Response_ResponseType._(16, 'CLIENT_ERROR');
  static const Response_ResponseType COMPILE_ERROR = const Response_ResponseType._(17, 'COMPILE_ERROR');
  static const Response_ResponseType RUNTIME_ERROR = const Response_ResponseType._(18, 'RUNTIME_ERROR');

  static const List<Response_ResponseType> values = const <Response_ResponseType> [
    SUCCESS_ATOM,
    SUCCESS_SEQUENCE,
    SUCCESS_PARTIAL,
    WAIT_COMPLETE,
    SERVER_INFO,
    CLIENT_ERROR,
    COMPILE_ERROR,
    RUNTIME_ERROR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Response_ResponseType valueOf(int value) => _byValue[value] as Response_ResponseType;
  static void $checkItem(Response_ResponseType v) {
    if (v is !Response_ResponseType) checkItemFailed(v, 'Response_ResponseType');
  }

  const Response_ResponseType._(int v, String n) : super(v, n);
}

class Response_ErrorType extends ProtobufEnum {
  static const Response_ErrorType INTERNAL = const Response_ErrorType._(1000000, 'INTERNAL');
  static const Response_ErrorType RESOURCE_LIMIT = const Response_ErrorType._(2000000, 'RESOURCE_LIMIT');
  static const Response_ErrorType QUERY_LOGIC = const Response_ErrorType._(3000000, 'QUERY_LOGIC');
  static const Response_ErrorType NON_EXISTENCE = const Response_ErrorType._(3100000, 'NON_EXISTENCE');
  static const Response_ErrorType OP_FAILED = const Response_ErrorType._(4100000, 'OP_FAILED');
  static const Response_ErrorType OP_INDETERMINATE = const Response_ErrorType._(4200000, 'OP_INDETERMINATE');
  static const Response_ErrorType USER = const Response_ErrorType._(5000000, 'USER');
  static const Response_ErrorType PERMISSION_ERROR = const Response_ErrorType._(6000000, 'PERMISSION_ERROR');

  static const List<Response_ErrorType> values = const <Response_ErrorType> [
    INTERNAL,
    RESOURCE_LIMIT,
    QUERY_LOGIC,
    NON_EXISTENCE,
    OP_FAILED,
    OP_INDETERMINATE,
    USER,
    PERMISSION_ERROR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Response_ErrorType valueOf(int value) => _byValue[value] as Response_ErrorType;
  static void $checkItem(Response_ErrorType v) {
    if (v is !Response_ErrorType) checkItemFailed(v, 'Response_ErrorType');
  }

  const Response_ErrorType._(int v, String n) : super(v, n);
}

class Response_ResponseNote extends ProtobufEnum {
  static const Response_ResponseNote SEQUENCE_FEED = const Response_ResponseNote._(1, 'SEQUENCE_FEED');
  static const Response_ResponseNote ATOM_FEED = const Response_ResponseNote._(2, 'ATOM_FEED');
  static const Response_ResponseNote ORDER_BY_LIMIT_FEED = const Response_ResponseNote._(3, 'ORDER_BY_LIMIT_FEED');
  static const Response_ResponseNote UNIONED_FEED = const Response_ResponseNote._(4, 'UNIONED_FEED');
  static const Response_ResponseNote INCLUDES_STATES = const Response_ResponseNote._(5, 'INCLUDES_STATES');

  static const List<Response_ResponseNote> values = const <Response_ResponseNote> [
    SEQUENCE_FEED,
    ATOM_FEED,
    ORDER_BY_LIMIT_FEED,
    UNIONED_FEED,
    INCLUDES_STATES,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Response_ResponseNote valueOf(int value) => _byValue[value] as Response_ResponseNote;
  static void $checkItem(Response_ResponseNote v) {
    if (v is !Response_ResponseNote) checkItemFailed(v, 'Response_ResponseNote');
  }

  const Response_ResponseNote._(int v, String n) : super(v, n);
}

class Response extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Response')
    ..e/*<Response_ResponseType>*/(1, 'type', PbFieldType.OE, Response_ResponseType.SUCCESS_ATOM, Response_ResponseType.valueOf)
    ..a/*<Int64>*/(2, 'token', PbFieldType.O6, Int64.ZERO)
    ..pp/*<Datum>*/(3, 'response', PbFieldType.PM, Datum.$checkItem, Datum.create)
    ..a/*<Backtrace>*/(4, 'backtrace', PbFieldType.OM, Backtrace.getDefault, Backtrace.create)
    ..a/*<Datum>*/(5, 'profile', PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pp/*<Response_ResponseNote>*/(6, 'notes', PbFieldType.PE, Response_ResponseNote.$checkItem, null, Response_ResponseNote.valueOf)
    ..e/*<Response_ErrorType>*/(7, 'errorType', PbFieldType.OE, Response_ErrorType.INTERNAL, Response_ErrorType.valueOf)
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
    if (v is !Response) checkItemFailed(v, 'Response');
  }

  Response_ResponseType get type => $_get(0, 1, null);
  void set type(Response_ResponseType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Int64 get token => $_get(1, 2, null);
  void set token(Int64 v) { $_setInt64(1, 2, v); }
  bool hasToken() => $_has(1, 2);
  void clearToken() => clearField(2);

  List<Datum> get response => $_get(2, 3, null);

  Backtrace get backtrace => $_get(3, 4, null);
  void set backtrace(Backtrace v) { setField(4, v); }
  bool hasBacktrace() => $_has(3, 4);
  void clearBacktrace() => clearField(4);

  Datum get profile => $_get(4, 5, null);
  void set profile(Datum v) { setField(5, v); }
  bool hasProfile() => $_has(4, 5);
  void clearProfile() => clearField(5);

  List<Response_ResponseNote> get notes => $_get(5, 6, null);

  Response_ErrorType get errorType => $_get(6, 7, null);
  void set errorType(Response_ErrorType v) { setField(7, v); }
  bool hasErrorType() => $_has(6, 7);
  void clearErrorType() => clearField(7);
}

class _ReadonlyResponse extends Response with ReadonlyMessageMixin {}

class Datum_DatumType extends ProtobufEnum {
  static const Datum_DatumType R_NULL = const Datum_DatumType._(1, 'R_NULL');
  static const Datum_DatumType R_BOOL = const Datum_DatumType._(2, 'R_BOOL');
  static const Datum_DatumType R_NUM = const Datum_DatumType._(3, 'R_NUM');
  static const Datum_DatumType R_STR = const Datum_DatumType._(4, 'R_STR');
  static const Datum_DatumType R_ARRAY = const Datum_DatumType._(5, 'R_ARRAY');
  static const Datum_DatumType R_OBJECT = const Datum_DatumType._(6, 'R_OBJECT');
  static const Datum_DatumType R_JSON = const Datum_DatumType._(7, 'R_JSON');

  static const List<Datum_DatumType> values = const <Datum_DatumType> [
    R_NULL,
    R_BOOL,
    R_NUM,
    R_STR,
    R_ARRAY,
    R_OBJECT,
    R_JSON,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Datum_DatumType valueOf(int value) => _byValue[value] as Datum_DatumType;
  static void $checkItem(Datum_DatumType v) {
    if (v is !Datum_DatumType) checkItemFailed(v, 'Datum_DatumType');
  }

  const Datum_DatumType._(int v, String n) : super(v, n);
}

class Datum_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Datum_AssocPair')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<Datum>*/(2, 'val', PbFieldType.OM, Datum.getDefault, Datum.create)
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
    if (v is !Datum_AssocPair) checkItemFailed(v, 'Datum_AssocPair');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Datum get val => $_get(1, 2, null);
  void set val(Datum v) { setField(2, v); }
  bool hasVal() => $_has(1, 2);
  void clearVal() => clearField(2);
}

class _ReadonlyDatum_AssocPair extends Datum_AssocPair with ReadonlyMessageMixin {}

class Datum extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Datum')
    ..e/*<Datum_DatumType>*/(1, 'type', PbFieldType.OE, Datum_DatumType.R_NULL, Datum_DatumType.valueOf)
    ..a/*<bool>*/(2, 'rBool', PbFieldType.OB)
    ..a/*<double>*/(3, 'rNum', PbFieldType.OD)
    ..a/*<String>*/(4, 'rStr', PbFieldType.OS)
    ..pp/*<Datum>*/(5, 'rArray', PbFieldType.PM, Datum.$checkItem, Datum.create)
    ..pp/*<Datum_AssocPair>*/(6, 'rObject', PbFieldType.PM, Datum_AssocPair.$checkItem, Datum_AssocPair.create)
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
    if (v is !Datum) checkItemFailed(v, 'Datum');
  }

  Datum_DatumType get type => $_get(0, 1, null);
  void set type(Datum_DatumType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  bool get rBool => $_get(1, 2, false);
  void set rBool(bool v) { $_setBool(1, 2, v); }
  bool hasRBool() => $_has(1, 2);
  void clearRBool() => clearField(2);

  double get rNum => $_get(2, 3, null);
  void set rNum(double v) { $_setDouble(2, 3, v); }
  bool hasRNum() => $_has(2, 3);
  void clearRNum() => clearField(3);

  String get rStr => $_get(3, 4, '');
  void set rStr(String v) { $_setString(3, 4, v); }
  bool hasRStr() => $_has(3, 4);
  void clearRStr() => clearField(4);

  List<Datum> get rArray => $_get(4, 5, null);

  List<Datum_AssocPair> get rObject => $_get(5, 6, null);
}

class _ReadonlyDatum extends Datum with ReadonlyMessageMixin {}

class Term_TermType extends ProtobufEnum {
  static const Term_TermType DATUM = const Term_TermType._(1, 'DATUM');
  static const Term_TermType MAKE_ARRAY = const Term_TermType._(2, 'MAKE_ARRAY');
  static const Term_TermType MAKE_OBJ = const Term_TermType._(3, 'MAKE_OBJ');
  static const Term_TermType VAR = const Term_TermType._(10, 'VAR');
  static const Term_TermType JAVASCRIPT = const Term_TermType._(11, 'JAVASCRIPT');
  static const Term_TermType UUID = const Term_TermType._(169, 'UUID');
  static const Term_TermType HTTP = const Term_TermType._(153, 'HTTP');
  static const Term_TermType ERROR = const Term_TermType._(12, 'ERROR');
  static const Term_TermType IMPLICIT_VAR = const Term_TermType._(13, 'IMPLICIT_VAR');
  static const Term_TermType DB = const Term_TermType._(14, 'DB');
  static const Term_TermType TABLE = const Term_TermType._(15, 'TABLE');
  static const Term_TermType GET = const Term_TermType._(16, 'GET');
  static const Term_TermType GET_ALL = const Term_TermType._(78, 'GET_ALL');
  static const Term_TermType EQ = const Term_TermType._(17, 'EQ');
  static const Term_TermType NE = const Term_TermType._(18, 'NE');
  static const Term_TermType LT = const Term_TermType._(19, 'LT');
  static const Term_TermType LE = const Term_TermType._(20, 'LE');
  static const Term_TermType GT = const Term_TermType._(21, 'GT');
  static const Term_TermType GE = const Term_TermType._(22, 'GE');
  static const Term_TermType NOT = const Term_TermType._(23, 'NOT');
  static const Term_TermType ADD = const Term_TermType._(24, 'ADD');
  static const Term_TermType SUB = const Term_TermType._(25, 'SUB');
  static const Term_TermType MUL = const Term_TermType._(26, 'MUL');
  static const Term_TermType DIV = const Term_TermType._(27, 'DIV');
  static const Term_TermType MOD = const Term_TermType._(28, 'MOD');
  static const Term_TermType FLOOR = const Term_TermType._(183, 'FLOOR');
  static const Term_TermType CEIL = const Term_TermType._(184, 'CEIL');
  static const Term_TermType ROUND = const Term_TermType._(185, 'ROUND');
  static const Term_TermType APPEND = const Term_TermType._(29, 'APPEND');
  static const Term_TermType PREPEND = const Term_TermType._(80, 'PREPEND');
  static const Term_TermType DIFFERENCE = const Term_TermType._(95, 'DIFFERENCE');
  static const Term_TermType SET_INSERT = const Term_TermType._(88, 'SET_INSERT');
  static const Term_TermType SET_INTERSECTION = const Term_TermType._(89, 'SET_INTERSECTION');
  static const Term_TermType SET_UNION = const Term_TermType._(90, 'SET_UNION');
  static const Term_TermType SET_DIFFERENCE = const Term_TermType._(91, 'SET_DIFFERENCE');
  static const Term_TermType SLICE = const Term_TermType._(30, 'SLICE');
  static const Term_TermType SKIP = const Term_TermType._(70, 'SKIP');
  static const Term_TermType LIMIT = const Term_TermType._(71, 'LIMIT');
  static const Term_TermType OFFSETS_OF = const Term_TermType._(87, 'OFFSETS_OF');
  static const Term_TermType CONTAINS = const Term_TermType._(93, 'CONTAINS');
  static const Term_TermType GET_FIELD = const Term_TermType._(31, 'GET_FIELD');
  static const Term_TermType KEYS = const Term_TermType._(94, 'KEYS');
  static const Term_TermType VALUES = const Term_TermType._(186, 'VALUES');
  static const Term_TermType OBJECT = const Term_TermType._(143, 'OBJECT');
  static const Term_TermType HAS_FIELDS = const Term_TermType._(32, 'HAS_FIELDS');
  static const Term_TermType WITH_FIELDS = const Term_TermType._(96, 'WITH_FIELDS');
  static const Term_TermType PLUCK = const Term_TermType._(33, 'PLUCK');
  static const Term_TermType WITHOUT = const Term_TermType._(34, 'WITHOUT');
  static const Term_TermType MERGE = const Term_TermType._(35, 'MERGE');
  static const Term_TermType BETWEEN_DEPRECATED = const Term_TermType._(36, 'BETWEEN_DEPRECATED');
  static const Term_TermType BETWEEN = const Term_TermType._(182, 'BETWEEN');
  static const Term_TermType REDUCE = const Term_TermType._(37, 'REDUCE');
  static const Term_TermType MAP = const Term_TermType._(38, 'MAP');
  static const Term_TermType FOLD = const Term_TermType._(187, 'FOLD');
  static const Term_TermType FILTER = const Term_TermType._(39, 'FILTER');
  static const Term_TermType CONCAT_MAP = const Term_TermType._(40, 'CONCAT_MAP');
  static const Term_TermType ORDER_BY = const Term_TermType._(41, 'ORDER_BY');
  static const Term_TermType DISTINCT = const Term_TermType._(42, 'DISTINCT');
  static const Term_TermType COUNT = const Term_TermType._(43, 'COUNT');
  static const Term_TermType IS_EMPTY = const Term_TermType._(86, 'IS_EMPTY');
  static const Term_TermType UNION = const Term_TermType._(44, 'UNION');
  static const Term_TermType NTH = const Term_TermType._(45, 'NTH');
  static const Term_TermType BRACKET = const Term_TermType._(170, 'BRACKET');
  static const Term_TermType INNER_JOIN = const Term_TermType._(48, 'INNER_JOIN');
  static const Term_TermType OUTER_JOIN = const Term_TermType._(49, 'OUTER_JOIN');
  static const Term_TermType EQ_JOIN = const Term_TermType._(50, 'EQ_JOIN');
  static const Term_TermType ZIP = const Term_TermType._(72, 'ZIP');
  static const Term_TermType RANGE = const Term_TermType._(173, 'RANGE');
  static const Term_TermType INSERT_AT = const Term_TermType._(82, 'INSERT_AT');
  static const Term_TermType DELETE_AT = const Term_TermType._(83, 'DELETE_AT');
  static const Term_TermType CHANGE_AT = const Term_TermType._(84, 'CHANGE_AT');
  static const Term_TermType SPLICE_AT = const Term_TermType._(85, 'SPLICE_AT');
  static const Term_TermType COERCE_TO = const Term_TermType._(51, 'COERCE_TO');
  static const Term_TermType TYPE_OF = const Term_TermType._(52, 'TYPE_OF');
  static const Term_TermType UPDATE = const Term_TermType._(53, 'UPDATE');
  static const Term_TermType DELETE = const Term_TermType._(54, 'DELETE');
  static const Term_TermType REPLACE = const Term_TermType._(55, 'REPLACE');
  static const Term_TermType INSERT = const Term_TermType._(56, 'INSERT');
  static const Term_TermType DB_CREATE = const Term_TermType._(57, 'DB_CREATE');
  static const Term_TermType DB_DROP = const Term_TermType._(58, 'DB_DROP');
  static const Term_TermType DB_LIST = const Term_TermType._(59, 'DB_LIST');
  static const Term_TermType TABLE_CREATE = const Term_TermType._(60, 'TABLE_CREATE');
  static const Term_TermType TABLE_DROP = const Term_TermType._(61, 'TABLE_DROP');
  static const Term_TermType TABLE_LIST = const Term_TermType._(62, 'TABLE_LIST');
  static const Term_TermType CONFIG = const Term_TermType._(174, 'CONFIG');
  static const Term_TermType STATUS = const Term_TermType._(175, 'STATUS');
  static const Term_TermType WAIT = const Term_TermType._(177, 'WAIT');
  static const Term_TermType RECONFIGURE = const Term_TermType._(176, 'RECONFIGURE');
  static const Term_TermType REBALANCE = const Term_TermType._(179, 'REBALANCE');
  static const Term_TermType SYNC = const Term_TermType._(138, 'SYNC');
  static const Term_TermType GRANT = const Term_TermType._(188, 'GRANT');
  static const Term_TermType INDEX_CREATE = const Term_TermType._(75, 'INDEX_CREATE');
  static const Term_TermType INDEX_DROP = const Term_TermType._(76, 'INDEX_DROP');
  static const Term_TermType INDEX_LIST = const Term_TermType._(77, 'INDEX_LIST');
  static const Term_TermType INDEX_STATUS = const Term_TermType._(139, 'INDEX_STATUS');
  static const Term_TermType INDEX_WAIT = const Term_TermType._(140, 'INDEX_WAIT');
  static const Term_TermType INDEX_RENAME = const Term_TermType._(156, 'INDEX_RENAME');
  static const Term_TermType FUNCALL = const Term_TermType._(64, 'FUNCALL');
  static const Term_TermType BRANCH = const Term_TermType._(65, 'BRANCH');
  static const Term_TermType OR = const Term_TermType._(66, 'OR');
  static const Term_TermType AND = const Term_TermType._(67, 'AND');
  static const Term_TermType FOR_EACH = const Term_TermType._(68, 'FOR_EACH');
  static const Term_TermType FUNC = const Term_TermType._(69, 'FUNC');
  static const Term_TermType ASC = const Term_TermType._(73, 'ASC');
  static const Term_TermType DESC = const Term_TermType._(74, 'DESC');
  static const Term_TermType INFO = const Term_TermType._(79, 'INFO');
  static const Term_TermType MATCH = const Term_TermType._(97, 'MATCH');
  static const Term_TermType UPCASE = const Term_TermType._(141, 'UPCASE');
  static const Term_TermType DOWNCASE = const Term_TermType._(142, 'DOWNCASE');
  static const Term_TermType SAMPLE = const Term_TermType._(81, 'SAMPLE');
  static const Term_TermType DEFAULT = const Term_TermType._(92, 'DEFAULT');
  static const Term_TermType JSON = const Term_TermType._(98, 'JSON');
  static const Term_TermType TO_JSON_STRING = const Term_TermType._(172, 'TO_JSON_STRING');
  static const Term_TermType ISO8601 = const Term_TermType._(99, 'ISO8601');
  static const Term_TermType TO_ISO8601 = const Term_TermType._(100, 'TO_ISO8601');
  static const Term_TermType EPOCH_TIME = const Term_TermType._(101, 'EPOCH_TIME');
  static const Term_TermType TO_EPOCH_TIME = const Term_TermType._(102, 'TO_EPOCH_TIME');
  static const Term_TermType NOW = const Term_TermType._(103, 'NOW');
  static const Term_TermType IN_TIMEZONE = const Term_TermType._(104, 'IN_TIMEZONE');
  static const Term_TermType DURING = const Term_TermType._(105, 'DURING');
  static const Term_TermType DATE = const Term_TermType._(106, 'DATE');
  static const Term_TermType TIME_OF_DAY = const Term_TermType._(126, 'TIME_OF_DAY');
  static const Term_TermType TIMEZONE = const Term_TermType._(127, 'TIMEZONE');
  static const Term_TermType YEAR = const Term_TermType._(128, 'YEAR');
  static const Term_TermType MONTH = const Term_TermType._(129, 'MONTH');
  static const Term_TermType DAY = const Term_TermType._(130, 'DAY');
  static const Term_TermType DAY_OF_WEEK = const Term_TermType._(131, 'DAY_OF_WEEK');
  static const Term_TermType DAY_OF_YEAR = const Term_TermType._(132, 'DAY_OF_YEAR');
  static const Term_TermType HOURS = const Term_TermType._(133, 'HOURS');
  static const Term_TermType MINUTES = const Term_TermType._(134, 'MINUTES');
  static const Term_TermType SECONDS = const Term_TermType._(135, 'SECONDS');
  static const Term_TermType TIME = const Term_TermType._(136, 'TIME');
  static const Term_TermType MONDAY = const Term_TermType._(107, 'MONDAY');
  static const Term_TermType TUESDAY = const Term_TermType._(108, 'TUESDAY');
  static const Term_TermType WEDNESDAY = const Term_TermType._(109, 'WEDNESDAY');
  static const Term_TermType THURSDAY = const Term_TermType._(110, 'THURSDAY');
  static const Term_TermType FRIDAY = const Term_TermType._(111, 'FRIDAY');
  static const Term_TermType SATURDAY = const Term_TermType._(112, 'SATURDAY');
  static const Term_TermType SUNDAY = const Term_TermType._(113, 'SUNDAY');
  static const Term_TermType JANUARY = const Term_TermType._(114, 'JANUARY');
  static const Term_TermType FEBRUARY = const Term_TermType._(115, 'FEBRUARY');
  static const Term_TermType MARCH = const Term_TermType._(116, 'MARCH');
  static const Term_TermType APRIL = const Term_TermType._(117, 'APRIL');
  static const Term_TermType MAY = const Term_TermType._(118, 'MAY');
  static const Term_TermType JUNE = const Term_TermType._(119, 'JUNE');
  static const Term_TermType JULY = const Term_TermType._(120, 'JULY');
  static const Term_TermType AUGUST = const Term_TermType._(121, 'AUGUST');
  static const Term_TermType SEPTEMBER = const Term_TermType._(122, 'SEPTEMBER');
  static const Term_TermType OCTOBER = const Term_TermType._(123, 'OCTOBER');
  static const Term_TermType NOVEMBER = const Term_TermType._(124, 'NOVEMBER');
  static const Term_TermType DECEMBER = const Term_TermType._(125, 'DECEMBER');
  static const Term_TermType LITERAL = const Term_TermType._(137, 'LITERAL');
  static const Term_TermType GROUP = const Term_TermType._(144, 'GROUP');
  static const Term_TermType SUM = const Term_TermType._(145, 'SUM');
  static const Term_TermType AVG = const Term_TermType._(146, 'AVG');
  static const Term_TermType MIN = const Term_TermType._(147, 'MIN');
  static const Term_TermType MAX = const Term_TermType._(148, 'MAX');
  static const Term_TermType SPLIT = const Term_TermType._(149, 'SPLIT');
  static const Term_TermType UNGROUP = const Term_TermType._(150, 'UNGROUP');
  static const Term_TermType RANDOM = const Term_TermType._(151, 'RANDOM');
  static const Term_TermType CHANGES = const Term_TermType._(152, 'CHANGES');
  static const Term_TermType ARGS = const Term_TermType._(154, 'ARGS');
  static const Term_TermType BINARY = const Term_TermType._(155, 'BINARY');
  static const Term_TermType GEOJSON = const Term_TermType._(157, 'GEOJSON');
  static const Term_TermType TO_GEOJSON = const Term_TermType._(158, 'TO_GEOJSON');
  static const Term_TermType POINT = const Term_TermType._(159, 'POINT');
  static const Term_TermType LINE = const Term_TermType._(160, 'LINE');
  static const Term_TermType POLYGON = const Term_TermType._(161, 'POLYGON');
  static const Term_TermType DISTANCE = const Term_TermType._(162, 'DISTANCE');
  static const Term_TermType INTERSECTS = const Term_TermType._(163, 'INTERSECTS');
  static const Term_TermType INCLUDES = const Term_TermType._(164, 'INCLUDES');
  static const Term_TermType CIRCLE = const Term_TermType._(165, 'CIRCLE');
  static const Term_TermType GET_INTERSECTING = const Term_TermType._(166, 'GET_INTERSECTING');
  static const Term_TermType FILL = const Term_TermType._(167, 'FILL');
  static const Term_TermType GET_NEAREST = const Term_TermType._(168, 'GET_NEAREST');
  static const Term_TermType POLYGON_SUB = const Term_TermType._(171, 'POLYGON_SUB');
  static const Term_TermType MINVAL = const Term_TermType._(180, 'MINVAL');
  static const Term_TermType MAXVAL = const Term_TermType._(181, 'MAXVAL');

  static const List<Term_TermType> values = const <Term_TermType> [
    DATUM,
    MAKE_ARRAY,
    MAKE_OBJ,
    VAR,
    JAVASCRIPT,
    UUID,
    HTTP,
    ERROR,
    IMPLICIT_VAR,
    DB,
    TABLE,
    GET,
    GET_ALL,
    EQ,
    NE,
    LT,
    LE,
    GT,
    GE,
    NOT,
    ADD,
    SUB,
    MUL,
    DIV,
    MOD,
    FLOOR,
    CEIL,
    ROUND,
    APPEND,
    PREPEND,
    DIFFERENCE,
    SET_INSERT,
    SET_INTERSECTION,
    SET_UNION,
    SET_DIFFERENCE,
    SLICE,
    SKIP,
    LIMIT,
    OFFSETS_OF,
    CONTAINS,
    GET_FIELD,
    KEYS,
    VALUES,
    OBJECT,
    HAS_FIELDS,
    WITH_FIELDS,
    PLUCK,
    WITHOUT,
    MERGE,
    BETWEEN_DEPRECATED,
    BETWEEN,
    REDUCE,
    MAP,
    FOLD,
    FILTER,
    CONCAT_MAP,
    ORDER_BY,
    DISTINCT,
    COUNT,
    IS_EMPTY,
    UNION,
    NTH,
    BRACKET,
    INNER_JOIN,
    OUTER_JOIN,
    EQ_JOIN,
    ZIP,
    RANGE,
    INSERT_AT,
    DELETE_AT,
    CHANGE_AT,
    SPLICE_AT,
    COERCE_TO,
    TYPE_OF,
    UPDATE,
    DELETE,
    REPLACE,
    INSERT,
    DB_CREATE,
    DB_DROP,
    DB_LIST,
    TABLE_CREATE,
    TABLE_DROP,
    TABLE_LIST,
    CONFIG,
    STATUS,
    WAIT,
    RECONFIGURE,
    REBALANCE,
    SYNC,
    GRANT,
    INDEX_CREATE,
    INDEX_DROP,
    INDEX_LIST,
    INDEX_STATUS,
    INDEX_WAIT,
    INDEX_RENAME,
    FUNCALL,
    BRANCH,
    OR,
    AND,
    FOR_EACH,
    FUNC,
    ASC,
    DESC,
    INFO,
    MATCH,
    UPCASE,
    DOWNCASE,
    SAMPLE,
    DEFAULT,
    JSON,
    TO_JSON_STRING,
    ISO8601,
    TO_ISO8601,
    EPOCH_TIME,
    TO_EPOCH_TIME,
    NOW,
    IN_TIMEZONE,
    DURING,
    DATE,
    TIME_OF_DAY,
    TIMEZONE,
    YEAR,
    MONTH,
    DAY,
    DAY_OF_WEEK,
    DAY_OF_YEAR,
    HOURS,
    MINUTES,
    SECONDS,
    TIME,
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY,
    JANUARY,
    FEBRUARY,
    MARCH,
    APRIL,
    MAY,
    JUNE,
    JULY,
    AUGUST,
    SEPTEMBER,
    OCTOBER,
    NOVEMBER,
    DECEMBER,
    LITERAL,
    GROUP,
    SUM,
    AVG,
    MIN,
    MAX,
    SPLIT,
    UNGROUP,
    RANDOM,
    CHANGES,
    ARGS,
    BINARY,
    GEOJSON,
    TO_GEOJSON,
    POINT,
    LINE,
    POLYGON,
    DISTANCE,
    INTERSECTS,
    INCLUDES,
    CIRCLE,
    GET_INTERSECTING,
    FILL,
    GET_NEAREST,
    POLYGON_SUB,
    MINVAL,
    MAXVAL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Term_TermType valueOf(int value) => _byValue[value] as Term_TermType;
  static void $checkItem(Term_TermType v) {
    if (v is !Term_TermType) checkItemFailed(v, 'Term_TermType');
  }

  const Term_TermType._(int v, String n) : super(v, n);
}

class Term_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Term_AssocPair')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<Term>*/(2, 'val', PbFieldType.OM, Term.getDefault, Term.create)
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
    if (v is !Term_AssocPair) checkItemFailed(v, 'Term_AssocPair');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Term get val => $_get(1, 2, null);
  void set val(Term v) { setField(2, v); }
  bool hasVal() => $_has(1, 2);
  void clearVal() => clearField(2);
}

class _ReadonlyTerm_AssocPair extends Term_AssocPair with ReadonlyMessageMixin {}

class Term extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Term')
    ..e/*<Term_TermType>*/(1, 'type', PbFieldType.OE, Term_TermType.DATUM, Term_TermType.valueOf)
    ..a/*<Datum>*/(2, 'datum', PbFieldType.OM, Datum.getDefault, Datum.create)
    ..pp/*<Term>*/(3, 'args', PbFieldType.PM, Term.$checkItem, Term.create)
    ..pp/*<Term_AssocPair>*/(4, 'optargs', PbFieldType.PM, Term_AssocPair.$checkItem, Term_AssocPair.create)
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
    if (v is !Term) checkItemFailed(v, 'Term');
  }

  Term_TermType get type => $_get(0, 1, null);
  void set type(Term_TermType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  Datum get datum => $_get(1, 2, null);
  void set datum(Datum v) { setField(2, v); }
  bool hasDatum() => $_has(1, 2);
  void clearDatum() => clearField(2);

  List<Term> get args => $_get(2, 3, null);

  List<Term_AssocPair> get optargs => $_get(3, 4, null);
}

class _ReadonlyTerm extends Term with ReadonlyMessageMixin {}

const VersionDummy$json = const {
  '1': 'VersionDummy',
  '4': const [VersionDummy_Version$json, VersionDummy_Protocol$json],
};

const VersionDummy_Version$json = const {
  '1': 'Version',
  '2': const [
    const {'1': 'V0_1', '2': 1063369270},
    const {'1': 'V0_2', '2': 1915781601},
    const {'1': 'V0_3', '2': 1601562686},
    const {'1': 'V0_4', '2': 1074539808},
    const {'1': 'V1_0', '2': 885177795},
  ],
};

const VersionDummy_Protocol$json = const {
  '1': 'Protocol',
  '2': const [
    const {'1': 'PROTOBUF', '2': 656407617},
    const {'1': 'JSON', '2': 2120839367},
  ],
};

const Query$json = const {
  '1': 'Query',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Query.QueryType'},
    const {'1': 'query', '3': 2, '4': 1, '5': 11, '6': '.Term'},
    const {'1': 'token', '3': 3, '4': 1, '5': 3},
    const {'1': 'OBSOLETE_noreply', '3': 4, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'accepts_r_json', '3': 5, '4': 1, '5': 8, '7': 'false'},
    const {'1': 'global_optargs', '3': 6, '4': 3, '5': 11, '6': '.Query.AssocPair'},
  ],
  '3': const [Query_AssocPair$json],
  '4': const [Query_QueryType$json],
};

const Query_AssocPair$json = const {
  '1': 'AssocPair',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'val', '3': 2, '4': 1, '5': 11, '6': '.Term'},
  ],
};

const Query_QueryType$json = const {
  '1': 'QueryType',
  '2': const [
    const {'1': 'START', '2': 1},
    const {'1': 'CONTINUE', '2': 2},
    const {'1': 'STOP', '2': 3},
    const {'1': 'NOREPLY_WAIT', '2': 4},
    const {'1': 'SERVER_INFO', '2': 5},
  ],
};

const Frame$json = const {
  '1': 'Frame',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Frame.FrameType'},
    const {'1': 'pos', '3': 2, '4': 1, '5': 3},
    const {'1': 'opt', '3': 3, '4': 1, '5': 9},
  ],
  '4': const [Frame_FrameType$json],
};

const Frame_FrameType$json = const {
  '1': 'FrameType',
  '2': const [
    const {'1': 'POS', '2': 1},
    const {'1': 'OPT', '2': 2},
  ],
};

const Backtrace$json = const {
  '1': 'Backtrace',
  '2': const [
    const {'1': 'frames', '3': 1, '4': 3, '5': 11, '6': '.Frame'},
  ],
};

const Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Response.ResponseType'},
    const {'1': 'error_type', '3': 7, '4': 1, '5': 14, '6': '.Response.ErrorType'},
    const {'1': 'notes', '3': 6, '4': 3, '5': 14, '6': '.Response.ResponseNote'},
    const {'1': 'token', '3': 2, '4': 1, '5': 3},
    const {'1': 'response', '3': 3, '4': 3, '5': 11, '6': '.Datum'},
    const {'1': 'backtrace', '3': 4, '4': 1, '5': 11, '6': '.Backtrace'},
    const {'1': 'profile', '3': 5, '4': 1, '5': 11, '6': '.Datum'},
  ],
  '4': const [Response_ResponseType$json, Response_ErrorType$json, Response_ResponseNote$json],
};

const Response_ResponseType$json = const {
  '1': 'ResponseType',
  '2': const [
    const {'1': 'SUCCESS_ATOM', '2': 1},
    const {'1': 'SUCCESS_SEQUENCE', '2': 2},
    const {'1': 'SUCCESS_PARTIAL', '2': 3},
    const {'1': 'WAIT_COMPLETE', '2': 4},
    const {'1': 'SERVER_INFO', '2': 5},
    const {'1': 'CLIENT_ERROR', '2': 16},
    const {'1': 'COMPILE_ERROR', '2': 17},
    const {'1': 'RUNTIME_ERROR', '2': 18},
  ],
};

const Response_ErrorType$json = const {
  '1': 'ErrorType',
  '2': const [
    const {'1': 'INTERNAL', '2': 1000000},
    const {'1': 'RESOURCE_LIMIT', '2': 2000000},
    const {'1': 'QUERY_LOGIC', '2': 3000000},
    const {'1': 'NON_EXISTENCE', '2': 3100000},
    const {'1': 'OP_FAILED', '2': 4100000},
    const {'1': 'OP_INDETERMINATE', '2': 4200000},
    const {'1': 'USER', '2': 5000000},
    const {'1': 'PERMISSION_ERROR', '2': 6000000},
  ],
};

const Response_ResponseNote$json = const {
  '1': 'ResponseNote',
  '2': const [
    const {'1': 'SEQUENCE_FEED', '2': 1},
    const {'1': 'ATOM_FEED', '2': 2},
    const {'1': 'ORDER_BY_LIMIT_FEED', '2': 3},
    const {'1': 'UNIONED_FEED', '2': 4},
    const {'1': 'INCLUDES_STATES', '2': 5},
  ],
};

const Datum$json = const {
  '1': 'Datum',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Datum.DatumType'},
    const {'1': 'r_bool', '3': 2, '4': 1, '5': 8},
    const {'1': 'r_num', '3': 3, '4': 1, '5': 1},
    const {'1': 'r_str', '3': 4, '4': 1, '5': 9},
    const {'1': 'r_array', '3': 5, '4': 3, '5': 11, '6': '.Datum'},
    const {'1': 'r_object', '3': 6, '4': 3, '5': 11, '6': '.Datum.AssocPair'},
  ],
  '3': const [Datum_AssocPair$json],
  '4': const [Datum_DatumType$json],
};

const Datum_AssocPair$json = const {
  '1': 'AssocPair',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'val', '3': 2, '4': 1, '5': 11, '6': '.Datum'},
  ],
};

const Datum_DatumType$json = const {
  '1': 'DatumType',
  '2': const [
    const {'1': 'R_NULL', '2': 1},
    const {'1': 'R_BOOL', '2': 2},
    const {'1': 'R_NUM', '2': 3},
    const {'1': 'R_STR', '2': 4},
    const {'1': 'R_ARRAY', '2': 5},
    const {'1': 'R_OBJECT', '2': 6},
    const {'1': 'R_JSON', '2': 7},
  ],
};

const Term$json = const {
  '1': 'Term',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Term.TermType'},
    const {'1': 'datum', '3': 2, '4': 1, '5': 11, '6': '.Datum'},
    const {'1': 'args', '3': 3, '4': 3, '5': 11, '6': '.Term'},
    const {'1': 'optargs', '3': 4, '4': 3, '5': 11, '6': '.Term.AssocPair'},
  ],
  '3': const [Term_AssocPair$json],
  '4': const [Term_TermType$json],
};

const Term_AssocPair$json = const {
  '1': 'AssocPair',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'val', '3': 2, '4': 1, '5': 11, '6': '.Term'},
  ],
};

const Term_TermType$json = const {
  '1': 'TermType',
  '2': const [
    const {'1': 'DATUM', '2': 1},
    const {'1': 'MAKE_ARRAY', '2': 2},
    const {'1': 'MAKE_OBJ', '2': 3},
    const {'1': 'VAR', '2': 10},
    const {'1': 'JAVASCRIPT', '2': 11},
    const {'1': 'UUID', '2': 169},
    const {'1': 'HTTP', '2': 153},
    const {'1': 'ERROR', '2': 12},
    const {'1': 'IMPLICIT_VAR', '2': 13},
    const {'1': 'DB', '2': 14},
    const {'1': 'TABLE', '2': 15},
    const {'1': 'GET', '2': 16},
    const {'1': 'GET_ALL', '2': 78},
    const {'1': 'EQ', '2': 17},
    const {'1': 'NE', '2': 18},
    const {'1': 'LT', '2': 19},
    const {'1': 'LE', '2': 20},
    const {'1': 'GT', '2': 21},
    const {'1': 'GE', '2': 22},
    const {'1': 'NOT', '2': 23},
    const {'1': 'ADD', '2': 24},
    const {'1': 'SUB', '2': 25},
    const {'1': 'MUL', '2': 26},
    const {'1': 'DIV', '2': 27},
    const {'1': 'MOD', '2': 28},
    const {'1': 'FLOOR', '2': 183},
    const {'1': 'CEIL', '2': 184},
    const {'1': 'ROUND', '2': 185},
    const {'1': 'APPEND', '2': 29},
    const {'1': 'PREPEND', '2': 80},
    const {'1': 'DIFFERENCE', '2': 95},
    const {'1': 'SET_INSERT', '2': 88},
    const {'1': 'SET_INTERSECTION', '2': 89},
    const {'1': 'SET_UNION', '2': 90},
    const {'1': 'SET_DIFFERENCE', '2': 91},
    const {'1': 'SLICE', '2': 30},
    const {'1': 'SKIP', '2': 70},
    const {'1': 'LIMIT', '2': 71},
    const {'1': 'OFFSETS_OF', '2': 87},
    const {'1': 'CONTAINS', '2': 93},
    const {'1': 'GET_FIELD', '2': 31},
    const {'1': 'KEYS', '2': 94},
    const {'1': 'VALUES', '2': 186},
    const {'1': 'OBJECT', '2': 143},
    const {'1': 'HAS_FIELDS', '2': 32},
    const {'1': 'WITH_FIELDS', '2': 96},
    const {'1': 'PLUCK', '2': 33},
    const {'1': 'WITHOUT', '2': 34},
    const {'1': 'MERGE', '2': 35},
    const {'1': 'BETWEEN_DEPRECATED', '2': 36},
    const {'1': 'BETWEEN', '2': 182},
    const {'1': 'REDUCE', '2': 37},
    const {'1': 'MAP', '2': 38},
    const {'1': 'FOLD', '2': 187},
    const {'1': 'FILTER', '2': 39},
    const {'1': 'CONCAT_MAP', '2': 40},
    const {'1': 'ORDER_BY', '2': 41},
    const {'1': 'DISTINCT', '2': 42},
    const {'1': 'COUNT', '2': 43},
    const {'1': 'IS_EMPTY', '2': 86},
    const {'1': 'UNION', '2': 44},
    const {'1': 'NTH', '2': 45},
    const {'1': 'BRACKET', '2': 170},
    const {'1': 'INNER_JOIN', '2': 48},
    const {'1': 'OUTER_JOIN', '2': 49},
    const {'1': 'EQ_JOIN', '2': 50},
    const {'1': 'ZIP', '2': 72},
    const {'1': 'RANGE', '2': 173},
    const {'1': 'INSERT_AT', '2': 82},
    const {'1': 'DELETE_AT', '2': 83},
    const {'1': 'CHANGE_AT', '2': 84},
    const {'1': 'SPLICE_AT', '2': 85},
    const {'1': 'COERCE_TO', '2': 51},
    const {'1': 'TYPE_OF', '2': 52},
    const {'1': 'UPDATE', '2': 53},
    const {'1': 'DELETE', '2': 54},
    const {'1': 'REPLACE', '2': 55},
    const {'1': 'INSERT', '2': 56},
    const {'1': 'DB_CREATE', '2': 57},
    const {'1': 'DB_DROP', '2': 58},
    const {'1': 'DB_LIST', '2': 59},
    const {'1': 'TABLE_CREATE', '2': 60},
    const {'1': 'TABLE_DROP', '2': 61},
    const {'1': 'TABLE_LIST', '2': 62},
    const {'1': 'CONFIG', '2': 174},
    const {'1': 'STATUS', '2': 175},
    const {'1': 'WAIT', '2': 177},
    const {'1': 'RECONFIGURE', '2': 176},
    const {'1': 'REBALANCE', '2': 179},
    const {'1': 'SYNC', '2': 138},
    const {'1': 'GRANT', '2': 188},
    const {'1': 'INDEX_CREATE', '2': 75},
    const {'1': 'INDEX_DROP', '2': 76},
    const {'1': 'INDEX_LIST', '2': 77},
    const {'1': 'INDEX_STATUS', '2': 139},
    const {'1': 'INDEX_WAIT', '2': 140},
    const {'1': 'INDEX_RENAME', '2': 156},
    const {'1': 'FUNCALL', '2': 64},
    const {'1': 'BRANCH', '2': 65},
    const {'1': 'OR', '2': 66},
    const {'1': 'AND', '2': 67},
    const {'1': 'FOR_EACH', '2': 68},
    const {'1': 'FUNC', '2': 69},
    const {'1': 'ASC', '2': 73},
    const {'1': 'DESC', '2': 74},
    const {'1': 'INFO', '2': 79},
    const {'1': 'MATCH', '2': 97},
    const {'1': 'UPCASE', '2': 141},
    const {'1': 'DOWNCASE', '2': 142},
    const {'1': 'SAMPLE', '2': 81},
    const {'1': 'DEFAULT', '2': 92},
    const {'1': 'JSON', '2': 98},
    const {'1': 'TO_JSON_STRING', '2': 172},
    const {'1': 'ISO8601', '2': 99},
    const {'1': 'TO_ISO8601', '2': 100},
    const {'1': 'EPOCH_TIME', '2': 101},
    const {'1': 'TO_EPOCH_TIME', '2': 102},
    const {'1': 'NOW', '2': 103},
    const {'1': 'IN_TIMEZONE', '2': 104},
    const {'1': 'DURING', '2': 105},
    const {'1': 'DATE', '2': 106},
    const {'1': 'TIME_OF_DAY', '2': 126},
    const {'1': 'TIMEZONE', '2': 127},
    const {'1': 'YEAR', '2': 128},
    const {'1': 'MONTH', '2': 129},
    const {'1': 'DAY', '2': 130},
    const {'1': 'DAY_OF_WEEK', '2': 131},
    const {'1': 'DAY_OF_YEAR', '2': 132},
    const {'1': 'HOURS', '2': 133},
    const {'1': 'MINUTES', '2': 134},
    const {'1': 'SECONDS', '2': 135},
    const {'1': 'TIME', '2': 136},
    const {'1': 'MONDAY', '2': 107},
    const {'1': 'TUESDAY', '2': 108},
    const {'1': 'WEDNESDAY', '2': 109},
    const {'1': 'THURSDAY', '2': 110},
    const {'1': 'FRIDAY', '2': 111},
    const {'1': 'SATURDAY', '2': 112},
    const {'1': 'SUNDAY', '2': 113},
    const {'1': 'JANUARY', '2': 114},
    const {'1': 'FEBRUARY', '2': 115},
    const {'1': 'MARCH', '2': 116},
    const {'1': 'APRIL', '2': 117},
    const {'1': 'MAY', '2': 118},
    const {'1': 'JUNE', '2': 119},
    const {'1': 'JULY', '2': 120},
    const {'1': 'AUGUST', '2': 121},
    const {'1': 'SEPTEMBER', '2': 122},
    const {'1': 'OCTOBER', '2': 123},
    const {'1': 'NOVEMBER', '2': 124},
    const {'1': 'DECEMBER', '2': 125},
    const {'1': 'LITERAL', '2': 137},
    const {'1': 'GROUP', '2': 144},
    const {'1': 'SUM', '2': 145},
    const {'1': 'AVG', '2': 146},
    const {'1': 'MIN', '2': 147},
    const {'1': 'MAX', '2': 148},
    const {'1': 'SPLIT', '2': 149},
    const {'1': 'UNGROUP', '2': 150},
    const {'1': 'RANDOM', '2': 151},
    const {'1': 'CHANGES', '2': 152},
    const {'1': 'ARGS', '2': 154},
    const {'1': 'BINARY', '2': 155},
    const {'1': 'GEOJSON', '2': 157},
    const {'1': 'TO_GEOJSON', '2': 158},
    const {'1': 'POINT', '2': 159},
    const {'1': 'LINE', '2': 160},
    const {'1': 'POLYGON', '2': 161},
    const {'1': 'DISTANCE', '2': 162},
    const {'1': 'INTERSECTS', '2': 163},
    const {'1': 'INCLUDES', '2': 164},
    const {'1': 'CIRCLE', '2': 165},
    const {'1': 'GET_INTERSECTING', '2': 166},
    const {'1': 'FILL', '2': 167},
    const {'1': 'GET_NEAREST', '2': 168},
    const {'1': 'POLYGON_SUB', '2': 171},
    const {'1': 'MINVAL', '2': 180},
    const {'1': 'MAXVAL', '2': 181},
  ],
};

