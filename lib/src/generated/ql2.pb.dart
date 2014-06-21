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

  static const List<VersionDummy_Version> values = const <VersionDummy_Version> [
    V0_1,
    V0_2,
    V0_3,
  ];

  static final Map<int, VersionDummy_Version> _byValue = ProtobufEnum.initByValue(values);
  static VersionDummy_Version valueOf(int value) => _byValue[value];

  const VersionDummy_Version._(int v, String n) : super(v, n);
}

class VersionDummy_Protocol extends ProtobufEnum {
  static const VersionDummy_Protocol PROTOBUF = const VersionDummy_Protocol._(656407617, 'PROTOBUF');
  static const VersionDummy_Protocol JSON = const VersionDummy_Protocol._(2120839367, 'JSON');

  static const List<VersionDummy_Protocol> values = const <VersionDummy_Protocol> [
    PROTOBUF,
    JSON,
  ];

  static final Map<int, VersionDummy_Protocol> _byValue = ProtobufEnum.initByValue(values);
  static VersionDummy_Protocol valueOf(int value) => _byValue[value];

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
}

class Query_QueryType extends ProtobufEnum {
  static const Query_QueryType START = const Query_QueryType._(1, 'START');
  static const Query_QueryType CONTINUE = const Query_QueryType._(2, 'CONTINUE');
  static const Query_QueryType STOP = const Query_QueryType._(3, 'STOP');
  static const Query_QueryType NOREPLY_WAIT = const Query_QueryType._(4, 'NOREPLY_WAIT');

  static const List<Query_QueryType> values = const <Query_QueryType> [
    START,
    CONTINUE,
    STOP,
    NOREPLY_WAIT,
  ];

  static final Map<int, Query_QueryType> _byValue = ProtobufEnum.initByValue(values);
  static Query_QueryType valueOf(int value) => _byValue[value];

  const Query_QueryType._(int v, String n) : super(v, n);
}

class Query_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query_AssocPair')
    ..a(1, 'key', GeneratedMessage.OS)
    ..a(2, 'val', GeneratedMessage.OM, () => new Term(), () => new Term())
  ;

  Query_AssocPair() : super();
  Query_AssocPair.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query_AssocPair.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query_AssocPair clone() => new Query_AssocPair()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get key => getField(1);
  void set key(String v) { setField(1, v); }
  bool hasKey() => hasField(1);
  void clearKey() => clearField(1);

  Term get val => getField(2);
  void set val(Term v) { setField(2, v); }
  bool hasVal() => hasField(2);
  void clearVal() => clearField(2);
}

class Query extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Query')
    ..e(1, 'type', GeneratedMessage.OE, () => Query_QueryType.START, (var v) => Query_QueryType.valueOf(v))
    ..a(2, 'query', GeneratedMessage.OM, () => new Term(), () => new Term())
    ..a(3, 'token', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(4, 'oBSOLETENoreply', GeneratedMessage.OB)
    ..a(5, 'acceptsRJson', GeneratedMessage.OB)
    ..m(6, 'globalOptargs', () => new Query_AssocPair(), () => new PbList<Query_AssocPair>())
  ;

  Query() : super();
  Query.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Query.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Query clone() => new Query()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Query_QueryType get type => getField(1);
  void set type(Query_QueryType v) { setField(1, v); }
  bool hasType() => hasField(1);
  void clearType() => clearField(1);

  Term get query => getField(2);
  void set query(Term v) { setField(2, v); }
  bool hasQuery() => hasField(2);
  void clearQuery() => clearField(2);

  Int64 get token => getField(3);
  void set token(Int64 v) { setField(3, v); }
  bool hasToken() => hasField(3);
  void clearToken() => clearField(3);

  bool get oBSOLETENoreply => getField(4);
  void set oBSOLETENoreply(bool v) { setField(4, v); }
  bool hasOBSOLETENoreply() => hasField(4);
  void clearOBSOLETENoreply() => clearField(4);

  bool get acceptsRJson => getField(5);
  void set acceptsRJson(bool v) { setField(5, v); }
  bool hasAcceptsRJson() => hasField(5);
  void clearAcceptsRJson() => clearField(5);

  List<Query_AssocPair> get globalOptargs => getField(6);
}

class Frame_FrameType extends ProtobufEnum {
  static const Frame_FrameType POS = const Frame_FrameType._(1, 'POS');
  static const Frame_FrameType OPT = const Frame_FrameType._(2, 'OPT');

  static const List<Frame_FrameType> values = const <Frame_FrameType> [
    POS,
    OPT,
  ];

  static final Map<int, Frame_FrameType> _byValue = ProtobufEnum.initByValue(values);
  static Frame_FrameType valueOf(int value) => _byValue[value];

  const Frame_FrameType._(int v, String n) : super(v, n);
}

class Frame extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Frame')
    ..e(1, 'type', GeneratedMessage.OE, () => Frame_FrameType.POS, (var v) => Frame_FrameType.valueOf(v))
    ..a(2, 'pos', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(3, 'opt', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  Frame() : super();
  Frame.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Frame.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Frame clone() => new Frame()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Frame_FrameType get type => getField(1);
  void set type(Frame_FrameType v) { setField(1, v); }
  bool hasType() => hasField(1);
  void clearType() => clearField(1);

  Int64 get pos => getField(2);
  void set pos(Int64 v) { setField(2, v); }
  bool hasPos() => hasField(2);
  void clearPos() => clearField(2);

  String get opt => getField(3);
  void set opt(String v) { setField(3, v); }
  bool hasOpt() => hasField(3);
  void clearOpt() => clearField(3);
}

class Backtrace extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Backtrace')
    ..m(1, 'frames', () => new Frame(), () => new PbList<Frame>())
    ..hasRequiredFields = false
  ;

  Backtrace() : super();
  Backtrace.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Backtrace.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Backtrace clone() => new Backtrace()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<Frame> get frames => getField(1);
}

class Response_ResponseType extends ProtobufEnum {
  static const Response_ResponseType SUCCESS_ATOM = const Response_ResponseType._(1, 'SUCCESS_ATOM');
  static const Response_ResponseType SUCCESS_SEQUENCE = const Response_ResponseType._(2, 'SUCCESS_SEQUENCE');
  static const Response_ResponseType SUCCESS_PARTIAL = const Response_ResponseType._(3, 'SUCCESS_PARTIAL');
  static const Response_ResponseType SUCCESS_FEED = const Response_ResponseType._(5, 'SUCCESS_FEED');
  static const Response_ResponseType WAIT_COMPLETE = const Response_ResponseType._(4, 'WAIT_COMPLETE');
  static const Response_ResponseType CLIENT_ERROR = const Response_ResponseType._(16, 'CLIENT_ERROR');
  static const Response_ResponseType COMPILE_ERROR = const Response_ResponseType._(17, 'COMPILE_ERROR');
  static const Response_ResponseType RUNTIME_ERROR = const Response_ResponseType._(18, 'RUNTIME_ERROR');

  static const List<Response_ResponseType> values = const <Response_ResponseType> [
    SUCCESS_ATOM,
    SUCCESS_SEQUENCE,
    SUCCESS_PARTIAL,
    SUCCESS_FEED,
    WAIT_COMPLETE,
    CLIENT_ERROR,
    COMPILE_ERROR,
    RUNTIME_ERROR,
  ];

  static final Map<int, Response_ResponseType> _byValue = ProtobufEnum.initByValue(values);
  static Response_ResponseType valueOf(int value) => _byValue[value];

  const Response_ResponseType._(int v, String n) : super(v, n);
}

class Response extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Response')
    ..e(1, 'type', GeneratedMessage.OE, () => Response_ResponseType.SUCCESS_ATOM, (var v) => Response_ResponseType.valueOf(v))
    ..a(2, 'token', GeneratedMessage.O6, () => makeLongInt(0))
    ..m(3, 'response', () => new Datum(), () => new PbList<Datum>())
    ..a(4, 'backtrace', GeneratedMessage.OM, () => new Backtrace(), () => new Backtrace())
    ..a(5, 'profile', GeneratedMessage.OM, () => new Datum(), () => new Datum())
  ;

  Response() : super();
  Response.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Response.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Response clone() => new Response()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Response_ResponseType get type => getField(1);
  void set type(Response_ResponseType v) { setField(1, v); }
  bool hasType() => hasField(1);
  void clearType() => clearField(1);

  Int64 get token => getField(2);
  void set token(Int64 v) { setField(2, v); }
  bool hasToken() => hasField(2);
  void clearToken() => clearField(2);

  List<Datum> get response => getField(3);

  Backtrace get backtrace => getField(4);
  void set backtrace(Backtrace v) { setField(4, v); }
  bool hasBacktrace() => hasField(4);
  void clearBacktrace() => clearField(4);

  Datum get profile => getField(5);
  void set profile(Datum v) { setField(5, v); }
  bool hasProfile() => hasField(5);
  void clearProfile() => clearField(5);
}

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

  static final Map<int, Datum_DatumType> _byValue = ProtobufEnum.initByValue(values);
  static Datum_DatumType valueOf(int value) => _byValue[value];

  const Datum_DatumType._(int v, String n) : super(v, n);
}

class Datum_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Datum_AssocPair')
    ..a(1, 'key', GeneratedMessage.OS)
    ..a(2, 'val', GeneratedMessage.OM, () => new Datum(), () => new Datum())
  ;

  Datum_AssocPair() : super();
  Datum_AssocPair.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Datum_AssocPair.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Datum_AssocPair clone() => new Datum_AssocPair()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get key => getField(1);
  void set key(String v) { setField(1, v); }
  bool hasKey() => hasField(1);
  void clearKey() => clearField(1);

  Datum get val => getField(2);
  void set val(Datum v) { setField(2, v); }
  bool hasVal() => hasField(2);
  void clearVal() => clearField(2);
}

class Datum extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Datum')
    ..e(1, 'type', GeneratedMessage.OE, () => Datum_DatumType.R_NULL, (var v) => Datum_DatumType.valueOf(v))
    ..a(2, 'rBool', GeneratedMessage.OB)
    ..a(3, 'rNum', GeneratedMessage.OD)
    ..a(4, 'rStr', GeneratedMessage.OS)
    ..m(5, 'rArray', () => new Datum(), () => new PbList<Datum>())
    ..m(6, 'rObject', () => new Datum_AssocPair(), () => new PbList<Datum_AssocPair>())
    ..hasExtensions = true
  ;

  Datum() : super();
  Datum.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Datum.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Datum clone() => new Datum()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Datum_DatumType get type => getField(1);
  void set type(Datum_DatumType v) { setField(1, v); }
  bool hasType() => hasField(1);
  void clearType() => clearField(1);

  bool get rBool => getField(2);
  void set rBool(bool v) { setField(2, v); }
  bool hasRBool() => hasField(2);
  void clearRBool() => clearField(2);

  double get rNum => getField(3);
  void set rNum(double v) { setField(3, v); }
  bool hasRNum() => hasField(3);
  void clearRNum() => clearField(3);

  String get rStr => getField(4);
  void set rStr(String v) { setField(4, v); }
  bool hasRStr() => hasField(4);
  void clearRStr() => clearField(4);

  List<Datum> get rArray => getField(5);

  List<Datum_AssocPair> get rObject => getField(6);
}

class Term_TermType extends ProtobufEnum {
  static const Term_TermType DATUM = const Term_TermType._(1, 'DATUM');
  static const Term_TermType MAKE_ARRAY = const Term_TermType._(2, 'MAKE_ARRAY');
  static const Term_TermType MAKE_OBJ = const Term_TermType._(3, 'MAKE_OBJ');
  static const Term_TermType VAR = const Term_TermType._(10, 'VAR');
  static const Term_TermType JAVASCRIPT = const Term_TermType._(11, 'JAVASCRIPT');
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
  static const Term_TermType INDEXES_OF = const Term_TermType._(87, 'INDEXES_OF');
  static const Term_TermType CONTAINS = const Term_TermType._(93, 'CONTAINS');
  static const Term_TermType GET_FIELD = const Term_TermType._(31, 'GET_FIELD');
  static const Term_TermType KEYS = const Term_TermType._(94, 'KEYS');
  static const Term_TermType OBJECT = const Term_TermType._(143, 'OBJECT');
  static const Term_TermType HAS_FIELDS = const Term_TermType._(32, 'HAS_FIELDS');
  static const Term_TermType WITH_FIELDS = const Term_TermType._(96, 'WITH_FIELDS');
  static const Term_TermType PLUCK = const Term_TermType._(33, 'PLUCK');
  static const Term_TermType WITHOUT = const Term_TermType._(34, 'WITHOUT');
  static const Term_TermType MERGE = const Term_TermType._(35, 'MERGE');
  static const Term_TermType BETWEEN = const Term_TermType._(36, 'BETWEEN');
  static const Term_TermType REDUCE = const Term_TermType._(37, 'REDUCE');
  static const Term_TermType MAP = const Term_TermType._(38, 'MAP');
  static const Term_TermType FILTER = const Term_TermType._(39, 'FILTER');
  static const Term_TermType CONCATMAP = const Term_TermType._(40, 'CONCATMAP');
  static const Term_TermType ORDERBY = const Term_TermType._(41, 'ORDERBY');
  static const Term_TermType DISTINCT = const Term_TermType._(42, 'DISTINCT');
  static const Term_TermType COUNT = const Term_TermType._(43, 'COUNT');
  static const Term_TermType IS_EMPTY = const Term_TermType._(86, 'IS_EMPTY');
  static const Term_TermType UNION = const Term_TermType._(44, 'UNION');
  static const Term_TermType NTH = const Term_TermType._(45, 'NTH');
  static const Term_TermType INNER_JOIN = const Term_TermType._(48, 'INNER_JOIN');
  static const Term_TermType OUTER_JOIN = const Term_TermType._(49, 'OUTER_JOIN');
  static const Term_TermType EQ_JOIN = const Term_TermType._(50, 'EQ_JOIN');
  static const Term_TermType ZIP = const Term_TermType._(72, 'ZIP');
  static const Term_TermType INSERT_AT = const Term_TermType._(82, 'INSERT_AT');
  static const Term_TermType DELETE_AT = const Term_TermType._(83, 'DELETE_AT');
  static const Term_TermType CHANGE_AT = const Term_TermType._(84, 'CHANGE_AT');
  static const Term_TermType SPLICE_AT = const Term_TermType._(85, 'SPLICE_AT');
  static const Term_TermType COERCE_TO = const Term_TermType._(51, 'COERCE_TO');
  static const Term_TermType TYPEOF = const Term_TermType._(52, 'TYPEOF');
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
  static const Term_TermType SYNC = const Term_TermType._(138, 'SYNC');
  static const Term_TermType INDEX_CREATE = const Term_TermType._(75, 'INDEX_CREATE');
  static const Term_TermType INDEX_DROP = const Term_TermType._(76, 'INDEX_DROP');
  static const Term_TermType INDEX_LIST = const Term_TermType._(77, 'INDEX_LIST');
  static const Term_TermType INDEX_STATUS = const Term_TermType._(139, 'INDEX_STATUS');
  static const Term_TermType INDEX_WAIT = const Term_TermType._(140, 'INDEX_WAIT');
  static const Term_TermType FUNCALL = const Term_TermType._(64, 'FUNCALL');
  static const Term_TermType BRANCH = const Term_TermType._(65, 'BRANCH');
  static const Term_TermType ANY = const Term_TermType._(66, 'ANY');
  static const Term_TermType ALL = const Term_TermType._(67, 'ALL');
  static const Term_TermType FOREACH = const Term_TermType._(68, 'FOREACH');
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

  static const List<Term_TermType> values = const <Term_TermType> [
    DATUM,
    MAKE_ARRAY,
    MAKE_OBJ,
    VAR,
    JAVASCRIPT,
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
    INDEXES_OF,
    CONTAINS,
    GET_FIELD,
    KEYS,
    OBJECT,
    HAS_FIELDS,
    WITH_FIELDS,
    PLUCK,
    WITHOUT,
    MERGE,
    BETWEEN,
    REDUCE,
    MAP,
    FILTER,
    CONCATMAP,
    ORDERBY,
    DISTINCT,
    COUNT,
    IS_EMPTY,
    UNION,
    NTH,
    INNER_JOIN,
    OUTER_JOIN,
    EQ_JOIN,
    ZIP,
    INSERT_AT,
    DELETE_AT,
    CHANGE_AT,
    SPLICE_AT,
    COERCE_TO,
    TYPEOF,
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
    SYNC,
    INDEX_CREATE,
    INDEX_DROP,
    INDEX_LIST,
    INDEX_STATUS,
    INDEX_WAIT,
    FUNCALL,
    BRANCH,
    ANY,
    ALL,
    FOREACH,
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
  ];

  static final Map<int, Term_TermType> _byValue = ProtobufEnum.initByValue(values);
  static Term_TermType valueOf(int value) => _byValue[value];

  const Term_TermType._(int v, String n) : super(v, n);
}

class Term_AssocPair extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Term_AssocPair')
    ..a(1, 'key', GeneratedMessage.OS)
    ..a(2, 'val', GeneratedMessage.OM, () => new Term(), () => new Term())
  ;

  Term_AssocPair() : super();
  Term_AssocPair.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Term_AssocPair.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Term_AssocPair clone() => new Term_AssocPair()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get key => getField(1);
  void set key(String v) { setField(1, v); }
  bool hasKey() => hasField(1);
  void clearKey() => clearField(1);

  Term get val => getField(2);
  void set val(Term v) { setField(2, v); }
  bool hasVal() => hasField(2);
  void clearVal() => clearField(2);
}

class Term extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Term')
    ..e(1, 'type', GeneratedMessage.OE, () => Term_TermType.DATUM, (var v) => Term_TermType.valueOf(v))
    ..a(2, 'datum', GeneratedMessage.OM, () => new Datum(), () => new Datum())
    ..m(3, 'args', () => new Term(), () => new PbList<Term>())
    ..m(4, 'optargs', () => new Term_AssocPair(), () => new PbList<Term_AssocPair>())
    ..hasExtensions = true
  ;

  Term() : super();
  Term.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Term.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Term clone() => new Term()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Term_TermType get type => getField(1);
  void set type(Term_TermType v) { setField(1, v); }
  bool hasType() => hasField(1);
  void clearType() => clearField(1);

  Datum get datum => getField(2);
  void set datum(Datum v) { setField(2, v); }
  bool hasDatum() => hasField(2);
  void clearDatum() => clearField(2);

  List<Term> get args => getField(3);

  List<Term_AssocPair> get optargs => getField(4);
}

