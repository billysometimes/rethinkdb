///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library ql2_pbenum;

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' show int, dynamic, String, List, Map;
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
    if (v is! VersionDummy_Version) checkItemFailed(v, 'VersionDummy_Version');
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
    if (v is! VersionDummy_Protocol) checkItemFailed(v, 'VersionDummy_Protocol');
  }

  const VersionDummy_Protocol._(int v, String n) : super(v, n);
}

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
    if (v is! Query_QueryType) checkItemFailed(v, 'Query_QueryType');
  }

  const Query_QueryType._(int v, String n) : super(v, n);
}

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
    if (v is! Frame_FrameType) checkItemFailed(v, 'Frame_FrameType');
  }

  const Frame_FrameType._(int v, String n) : super(v, n);
}

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
    if (v is! Response_ResponseType) checkItemFailed(v, 'Response_ResponseType');
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
    if (v is! Response_ErrorType) checkItemFailed(v, 'Response_ErrorType');
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
    if (v is! Response_ResponseNote) checkItemFailed(v, 'Response_ResponseNote');
  }

  const Response_ResponseNote._(int v, String n) : super(v, n);
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

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Datum_DatumType valueOf(int value) => _byValue[value] as Datum_DatumType;
  static void $checkItem(Datum_DatumType v) {
    if (v is! Datum_DatumType) checkItemFailed(v, 'Datum_DatumType');
  }

  const Datum_DatumType._(int v, String n) : super(v, n);
}

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
  static const Term_TermType SET_WRITE_HOOK = const Term_TermType._(189, 'SET_WRITE_HOOK');
  static const Term_TermType GET_WRITE_HOOK = const Term_TermType._(190, 'GET_WRITE_HOOK');
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
  static const Term_TermType TO_JSON_STRING = const Term_TermType._(172, 'TO_JSON_STRING');
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
    SET_WRITE_HOOK,
    GET_WRITE_HOOK,
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
    TO_JSON_STRING,
    MINVAL,
    MAXVAL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Term_TermType valueOf(int value) => _byValue[value] as Term_TermType;
  static void $checkItem(Term_TermType v) {
    if (v is! Term_TermType) checkItemFailed(v, 'Term_TermType');
  }

  const Term_TermType._(int v, String n) : super(v, n);
}

