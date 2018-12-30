///
//  Generated code. Do not modify.
//  source: ql2.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

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
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Query.QueryType', '10': 'type'},
    const {'1': 'query', '3': 2, '4': 1, '5': 11, '6': '.Term', '10': 'query'},
    const {'1': 'token', '3': 3, '4': 1, '5': 3, '10': 'token'},
    const {'1': 'OBSOLETE_noreply', '3': 4, '4': 1, '5': 8, '7': 'false', '10': 'OBSOLETENoreply'},
    const {'1': 'accepts_r_json', '3': 5, '4': 1, '5': 8, '7': 'false', '10': 'acceptsRJson'},
    const {'1': 'global_optargs', '3': 6, '4': 3, '5': 11, '6': '.Query.AssocPair', '10': 'globalOptargs'},
  ],
  '3': const [Query_AssocPair$json],
  '4': const [Query_QueryType$json],
};

const Query_AssocPair$json = const {
  '1': 'AssocPair',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'val', '3': 2, '4': 1, '5': 11, '6': '.Term', '10': 'val'},
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
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Frame.FrameType', '10': 'type'},
    const {'1': 'pos', '3': 2, '4': 1, '5': 3, '10': 'pos'},
    const {'1': 'opt', '3': 3, '4': 1, '5': 9, '10': 'opt'},
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
    const {'1': 'frames', '3': 1, '4': 3, '5': 11, '6': '.Frame', '10': 'frames'},
  ],
};

const Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Response.ResponseType', '10': 'type'},
    const {'1': 'error_type', '3': 7, '4': 1, '5': 14, '6': '.Response.ErrorType', '10': 'errorType'},
    const {'1': 'notes', '3': 6, '4': 3, '5': 14, '6': '.Response.ResponseNote', '10': 'notes'},
    const {'1': 'token', '3': 2, '4': 1, '5': 3, '10': 'token'},
    const {'1': 'response', '3': 3, '4': 3, '5': 11, '6': '.Datum', '10': 'response'},
    const {'1': 'backtrace', '3': 4, '4': 1, '5': 11, '6': '.Backtrace', '10': 'backtrace'},
    const {'1': 'profile', '3': 5, '4': 1, '5': 11, '6': '.Datum', '10': 'profile'},
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
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Datum.DatumType', '10': 'type'},
    const {'1': 'r_bool', '3': 2, '4': 1, '5': 8, '10': 'rBool'},
    const {'1': 'r_num', '3': 3, '4': 1, '5': 1, '10': 'rNum'},
    const {'1': 'r_str', '3': 4, '4': 1, '5': 9, '10': 'rStr'},
    const {'1': 'r_array', '3': 5, '4': 3, '5': 11, '6': '.Datum', '10': 'rArray'},
    const {'1': 'r_object', '3': 6, '4': 3, '5': 11, '6': '.Datum.AssocPair', '10': 'rObject'},
  ],
  '3': const [Datum_AssocPair$json],
  '4': const [Datum_DatumType$json],
};

const Datum_AssocPair$json = const {
  '1': 'AssocPair',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'val', '3': 2, '4': 1, '5': 11, '6': '.Datum', '10': 'val'},
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
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Term.TermType', '10': 'type'},
    const {'1': 'datum', '3': 2, '4': 1, '5': 11, '6': '.Datum', '10': 'datum'},
    const {'1': 'args', '3': 3, '4': 3, '5': 11, '6': '.Term', '10': 'args'},
    const {'1': 'optargs', '3': 4, '4': 3, '5': 11, '6': '.Term.AssocPair', '10': 'optargs'},
  ],
  '3': const [Term_AssocPair$json],
  '4': const [Term_TermType$json],
};

const Term_AssocPair$json = const {
  '1': 'AssocPair',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'val', '3': 2, '4': 1, '5': 11, '6': '.Term', '10': 'val'},
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
    const {'1': 'SET_WRITE_HOOK', '2': 189},
    const {'1': 'GET_WRITE_HOOK', '2': 190},
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
    const {'1': 'TO_JSON_STRING', '2': 172},
    const {'1': 'MINVAL', '2': 180},
    const {'1': 'MAXVAL', '2': 181},
    const {'1': 'BIT_AND', '2': 191},
    const {'1': 'BIT_OR', '2': 192},
    const {'1': 'BIT_XOR', '2': 193},
    const {'1': 'BIT_NOT', '2': 194},
    const {'1': 'BIT_SAL', '2': 195},
    const {'1': 'BIT_SAR', '2': 196},
  ],
};

