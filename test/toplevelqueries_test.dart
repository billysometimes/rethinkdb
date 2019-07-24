import 'package:test/test.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

main() {
  var r = Rethinkdb() as dynamic;
  String databaseName;
  String tableName;
  String testDbName;
  bool shouldDropTable = false;
  Connection connection;

  setUp(() async {
    connection = await r.connect();

    if (testDbName == null) {
      String useDb = await r.uuid().run(connection);
      testDbName = 'unit_test_db' + useDb.replaceAll("-", "");
      await r.dbCreate(testDbName).run(connection);
    }

    if (databaseName == null) {
      String dbName = await r.uuid().run(connection);
      databaseName = "test_database_" + dbName.replaceAll("-", "");
    }

    if (tableName == null) {
      String tblName = await r.uuid().run(connection);
      tableName = "test_table_" + tblName.replaceAll("-", "");
    }
    connection.use(testDbName);
  });

  tearDown(() async {
    if (shouldDropTable) {
      shouldDropTable = false;
      await r.tableDrop(tableName).run(connection);
    }
    connection.close();
  });

  test("r.db throws an error if a bad database name is given", () async {
    try {
      await r.db('fake2834723895').tableList().run(connection);
    } catch (err) {
      expect(err is Exception, equals(true));
      expect(err.message, equals('Database `fake2834723895` does not exist.'));
    }
  });

  group("dbCreate command -> ", () {
    test("r.dbCreate will create a new database", () async {
      Map response = await r.dbCreate(databaseName).run(connection);

      expect(response.keys.length, equals(2));
      expect(response.containsKey('config_changes'), equals(true));
      expect(response['dbs_created'], equals(1));

      Map config_changes = response['config_changes'][0];
      expect(config_changes.keys.length, equals(2));
      expect(config_changes['old_val'], equals(null));
      Map new_val = config_changes['new_val'];
      expect(new_val.containsKey('id'), equals(true));
      expect(new_val.containsKey('name'), equals(true));
      expect(new_val['name'], equals(databaseName));
    });

    test("r.dbCreate will throw an error if the database exists", () async {
      try {
        await r.dbCreate(databaseName).run(connection);
      } catch (err) {
        expect(err is Exception, equals(true));
        expect(
            err.message, equals('Database `${databaseName}` already exists.'));
      }
    });
  });

  group("dbDrop command -> ", () {
    test("r.dbDrop should drop a database", () async {
      Map response = await r.dbDrop(databaseName).run(connection);

      expect(response.keys.length, equals(3));
      expect(response.containsKey('config_changes'), equals(true));
      expect(response['dbs_dropped'], equals(1));
      expect(response['tables_dropped'], equals(0));

      Map config_changes = response['config_changes'][0];
      expect(config_changes.keys.length, equals(2));
      expect(config_changes['new_val'], equals(null));
      Map old_val = config_changes['old_val'];
      expect(old_val.containsKey('id'), equals(true));
      expect(old_val.containsKey('name'), equals(true));
      expect(old_val['name'], equals(databaseName));
    });

    test("r.dbDrop should error if the database does not exist", () async {
      try {
        await r.dbDrop(databaseName).run(connection);
      } catch (err) {
        expect(
            err.message, equals('Database `${databaseName}` does not exist.'));
      }
    });
  });

  test("r.dbList should list all databases", () async {
    List response = await r.dbList().run(connection);

    expect(response is List, equals(true));
    expect(response.indexOf('rethinkdb'), greaterThan(-1));
  });

  group("range command -> ", () {
    test("r.range() with no arguments should return a stream", () async {
      Cursor cur = await r.range().run(connection);

      expect(cur is Cursor, equals(true));
      List item = await cur.take(17).toList();
      expect(item,
          equals([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
    });

    test("r.range() should accept a single end arguement", () async {
      Cursor cur = await r.range(10).run(connection);

      List l = await cur.toList();
      expect(l, equals([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
    });

    test("r.range() should accept a start and end arguement", () async {
      Cursor cur = await r.range(7, 10).run(connection);
      List l = await cur.toList();
      expect(l, equals([7, 8, 9]));
    });
  });

  group("table command -> ", () {
    test("table should return a cursor containing all records for a table",
        () async {
      Cursor cur = await r.db('rethinkdb').table('stats').run(connection);
      await for (Map item in cur) {
        expect(item.containsKey('id'), equals(true));
        expect(item.containsKey('query_engine'), equals(true));
      }
    });

    test("table should allow for `read_mode: single` option", () async {
      Cursor cur = await r
          .db('rethinkdb')
          .table('stats', {'read_mode': 'single'}).run(connection);

      await for (Map item in cur) {
        expect(item.containsKey('id'), equals(true));
        expect(item.containsKey('query_engine'), equals(true));
      }
      ;
    });

    test("table should allow for `read_mode: majority` option", () async {
      Cursor cur = await r
          .db('rethinkdb')
          .table('stats', {'read_mode': 'majority'}).run(connection);

      await for (Map item in cur) {
        expect(item.containsKey('id'), equals(true));
        expect(item.containsKey('query_engine'), equals(true));
      }
      ;
    });

    test("table should allow for `read_mode: outdated` option", () async {
      Cursor cur = await r
          .db('rethinkdb')
          .table('stats', {'read_mode': 'outdated'}).run(connection);

      await for (Map item in cur) {
        expect(item.containsKey('id'), equals(true));
        expect(item.containsKey('query_engine'), equals(true));
      }
      ;
    });

    test("table should catch invalid read_mode option", () async {
      try {
        await r
            .db('rethinkdb')
            .table('stats', {'read_mode': 'badReadMode'}).run(connection);
      } catch (err) {
        expect(
            err.message,
            equals(
                'Read mode `badReadMode` unrecognized (options are "majority", "single", and "outdated").'));
      }
      ;
    });

    test("table should allow for `identifier_format: name` option", () async {
      Cursor cur = await r
          .db('rethinkdb')
          .table('stats', {'identifier_format': 'name'}).run(connection);

      await for (Map item in cur) {
        expect(item.containsKey('id'), equals(true));
        expect(item.containsKey('query_engine'), equals(true));
      }
      ;
    });

    test("table should allow for `identifier_format: uuid` option", () async {
      Cursor cur = await r
          .db('rethinkdb')
          .table('stats', {'identifier_format': 'uuid'}).run(connection);

      await for (Map item in cur) {
        expect(item.containsKey('id'), equals(true));
        expect(item.containsKey('query_engine'), equals(true));
      }
      ;
    });

    test("table should catch invalid identifier_format option", () async {
      try {
        await r
            .db('rethinkdb')
            .table('stats', {'identifier_format': 'badFormat'}).run(connection);
      } catch (err) {
        expect(
            err.message,
            equals(
                'Identifier format `badFormat` unrecognized (options are "name" and "uuid").'));
      }
    });

    test("table should catch bad options", () async {
      try {
        await r
            .db('rethinkdb')
            .table('stats', {'fake_option': 'bad_value'}).run(connection);
      } catch (err) {
        expect(err.message,
            equals('Unrecognized optional argument `fake_option`.'));
      }
      ;
    });
  });

  group("time command -> ", () {
    test(
        "should return a time object if given a year, month, day, and timezone",
        () async {
      DateTime obj = await r.time(2010, 12, 29, timezone: 'Z').run(connection);

      expect(obj.runtimeType, equals(DateTime));
      expect(obj.isBefore(DateTime.now()), equals(true));
      expect(obj.minute, equals(0));
      expect(obj.second, equals(0));
    });

    test(
        "should return a time object if given a year, month, day, hour, minute, second, and timezone",
        () async {
      DateTime obj = await r
          .time(2010, 12, 29, hour: 7, minute: 33, second: 45, timezone: 'Z')
          .run(connection);

      expect(obj.runtimeType, equals(DateTime));
      expect(obj.isBefore(DateTime.now()), equals(true));
      expect(obj.minute, equals(33));
      expect(obj.second, equals(45));
    });
  });

  test(
      "nativeTime command -> should turn a native dart DateTime to a reql time",
      () async {
    DateTime dt = DateTime.now();
    DateTime rqlDt = await r.nativeTime(dt).run(connection);

    expect(dt.year, equals(rqlDt.year));
    expect(dt.month, equals(rqlDt.month));
    expect(dt.day, equals(rqlDt.day));
    expect(dt.hour, equals(rqlDt.hour));
    expect(dt.minute, equals(rqlDt.minute));
    expect(dt.second, equals(rqlDt.second));
  });

  group("ISO8601 command -> ", () {
    test("should take an ISO8601 string and convert it to a DateTime object",
        () async {
      DateTime dt =
          await r.ISO8601('1986-11-03T08:30:00-07:00').run(connection);

      expect(dt.year, equals(1986));
      expect(dt.month, equals(11));
      expect(dt.day, equals(3));
      expect(dt.minute, equals(30));
    });

    test("should accept a timezone argument as well", () async {
      DateTime dt =
          await r.ISO8601('1986-11-03T08:30:00-07:00', 'MST').run(connection);

      expect(dt.year, equals(1986));
      expect(dt.month, equals(11));
      expect(dt.day, equals(3));
      expect(dt.minute, equals(30));
    });
  });

  test("epochTime command -> should take a timestamp and return a time object",
      () async {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(531360000000);

    DateTime dt = await r.epochTime(531360000).run(connection);

    expect(dt.month, equals(dateTime.month));
    expect(dt.day, equals(dateTime.day));
    expect(dt.hour, equals(dateTime.hour));
    expect(dt.minute, equals(dateTime.minute));
    expect(dt.second, equals(dateTime.second));
  });

  test("now command -> should return current DateTime object", () async {
    DateTime dt = await r.now().run(connection);

    expect(dt is DateTime, equals(true));
    expect(dt.isBefore(DateTime.now()), equals(true));
  });

  group("rqlDo command -> ", () {
    test("should accept a single argument and function", () async {
      bool i = await r.rqlDo(3, (item) => item > 4).run(connection);

      expect(i, equals(false));
    });

    test("should accept a many arguments and a function", () async {
      num i = await r
          .rqlDo(
              3,
              4,
              5,
              6,
              7,
              (item1, item2, item3, item4, item5) =>
                  item1 + item2 + item3 + item4 + item5)
          .run(connection);

      expect(i, equals(25));
    });

    test("should accept many args and an expression", () async {
      Cursor cur = await r.rqlDo(3, 7, r.range).run(connection);

      List list = await cur.toList();
      expect(list, equals([3, 4, 5, 6]));
    });
  });

  group("branch command -> ", () {
    test("should accept a true test and return the true branch value",
        () async {
      String val = await r.branch(3 < 4, 'isTrue', 'isFalse').run(connection);

      expect(val, equals('isTrue'));
    });

    test("should accept a false test and return the false branch value",
        () async {
      String val = await r.branch(3 > 4, 'isTrue', 'isFalse').run(connection);

      expect(val, equals('isFalse'));
    });

    test("should accept multiple tests and actions", () async {
      String val = await r
          .branch(1 > 4, 'isTrue', 0 < 1, 'elseTrue', 'isFalse')
          .run(connection);

      expect(val, equals('elseTrue'));
    });
  });

  test("error command -> should create a custom error", () async {
    try {
      await r.error('This is my Error').run(connection);
    } catch (err) {
      expect(err.runtimeType, equals(ReqlUserError));
      expect(err.message, equals('This is my Error'));
    }
  });

  group("js command -> ", () {
    test("should run custom javascript", () async {
      String jsString = """
        function concatStrs(){
          return 'firstHalf' + '_' + 'secondHalf';
        }
        concatStrs();
        """;

      String str = await r.js(jsString).run(connection);

      expect(str, equals('firstHalf_secondHalf'));
    });

    test("should accept a timeout option", () async {
      String jsString = """
        function concatStrs(){
          return 'firstHalf' + '_' + 'secondHalf';
        }
        while(true){
          concatStrs();
        }
        """;
      int timeout = 3;
      try {
        await r.js(jsString, {'timeout': timeout}).run(connection);
      } catch (err) {
        expect(
            err.message,
            equals(
                'JavaScript query `${jsString}` timed out after ${timeout}.000 seconds.'));
      }
    });
  });

  group("json command -> ", () {
    test("should parse a json string", () async {
      String jsonString = "[1,2,3,4]";
      List obj = await r.json(jsonString).run(connection);

      expect([1, 2, 3, 4], equals(obj));
    });

    test("should throw error if jsonString is invalid", () async {
      String jsonString = "1,2,3,4]";
      try {
        await r.json(jsonString).run(connection);
      } catch (err) {
        expect(
            err.message,
            equals(
                'Failed to parse "$jsonString" as JSON: The document root must not follow by other values.'));
      }
    });
  });

  group("object command -> ", () {
    test("should create an object from an array of values", () async {
      Map obj = await r
          .object('key', 'val', 'listKey', [1, 2, 3, 4], 'objKey', {'a': 'b'})
          .run(connection);

      expect(obj is Map, equals(true));
      expect(obj['key'], equals('val'));
      expect(obj['listKey'], equals([1, 2, 3, 4]));
      expect(obj['objKey']['a'], equals('b'));
    });

    test("should throw an error if params cannot be parsed into a map",
        () async {
      try {
        await r
            .object('key', 'val', 'listKey', [1, 2, 3, 4], 'objKey', {'a': 'b'},
                'odd')
            .run(connection);
      } catch (err) {
        expect(
            err.message,
            equals(
                'OBJECT expects an even number of arguments (but found 7).'));
      }
    });
  });

  test("args command -> should accept an array", () async {
    List l = await r.args([1, 2]).run(connection);

    expect(l, equals([1, 2]));
  });

  group("random command -> ", () {
    test("should generate a random number if no parameters are provided",
        () async {
      double number = await r.random().run(connection);

      expect(number is double, equals(true));
      expect(number, lessThanOrEqualTo(1));
      expect(number, greaterThanOrEqualTo(0));
    });

    test(
        "should generate a positive random int no greater than the single argument",
        () async {
      int number = await r.random(50).run(connection);

      expect(number is int, equals(true));
      expect(number, lessThanOrEqualTo(50));
      expect(number, greaterThanOrEqualTo(0));
    });

    test("should generate a random int between the two arguments", () async {
      int number = await r.random(50, 55).run(connection);

      expect(number is int, equals(true));
      expect(number, lessThanOrEqualTo(55));
      expect(number, greaterThanOrEqualTo(50));
    });

    test("should generate a random float between the two arguments", () async {
      double number = await r.random(50, 55, {'float': true}).run(connection);
      expect(number is double, equals(true));
      expect(number, lessThanOrEqualTo(55));
      expect(number, greaterThanOrEqualTo(50));
    });
  });

  group("not command -> ", () {
    test("should return false if given no arguements", () async {
      bool val = await r.not().run(connection);

      expect(val, equals(false));
    });

    test("should return the inverse of the argument provided", () async {
      bool val = await r.not(false).run(connection);

      expect(val, equals(true));
    });
  });

  group("map command -> ", () {
    test("should map over an array", () async {
      List arr =
          await r.map([1, 2, 3, 4, 5], (item) => item * 2).run(connection);
      expect(arr, equals([2, 4, 6, 8, 10]));
    });

    test("should map over multiple arrays", () async {
      List arr = await r.map([1, 2, 3, 4, 5], [10, 9, 8, 7],
          (item, item2) => item + item2).run(connection);

      //notice that the first array is longer but we
      //only map the length of the shortest array
      expect(arr, equals([11, 11, 11, 11]));
    });

    test("should map a sequence", () async {
      List arr = await r
          .map(
              r.expr({
                'key': [1, 2, 3, 4, 5]
              }).getField('key'),
              (item) => item + 1)
          .run(connection);

      expect(arr, equals([2, 3, 4, 5, 6]));
    });

    test("should map over multiple sequences", () async {
      List arr = await r
          .map(
              r.expr({
                'key': [1, 2, 3, 4, 5]
              }).getField('key'),
              r.expr({
                'key': [1, 2, 3, 4, 5]
              }).getField('key'),
              (item, item2) => item + item2)
          .run(connection);

      expect(arr, equals([2, 4, 6, 8, 10]));
    });
  });

  group("and command -> ", () {
    test("should and two values together", () async {
      bool val = await r.and(true, true).run(connection);

      expect(val, equals(true));
    });
    test("should and more than two values together", () async {
      bool val = await r.and(true, true, false).run(connection);

      expect(val, equals(false));
    });
  });

  group("or command -> ", () {
    test("should or two values together", () async {
      bool val = await r.or(true, false).run(connection);

      expect(val, equals(true));
    });

    test("should and more than two values together", () async {
      bool val = await r.or(false, false, false).run(connection);

      expect(val, equals(false));
    });
  });

  group("binary command -> ", () {
    test("should convert string to binary", () async {
      List data = await r.binary('billysometimes').run(connection);

      expect(data is List, equals(true));
      expect(
          data,
          equals([
            98,
            105,
            108,
            108,
            121,
            115,
            111,
            109,
            101,
            116,
            105,
            109,
            101,
            115
          ]));
    });
  });

  group("uuid command -> ", () {
    test("should create a unique uuid", () async {
      String val = await r.uuid().run(connection);

      expect(val is String, equals(true));
    });

    test("should create a uuid based on a string key", () async {
      String key = "billysometimes";
      String val = await r.uuid(key).run(connection);

      expect(val is String, equals(true));
      expect(val, equals('b3f5029e-f777-572f-a85d-5529b74fd99b'));
    });
  });

  group("expr command -> ", () {
    test("expr should convert native string to rql string", () async {
      String str = await r.expr('string').run(connection);
      expect(str, equals('string'));
    });

    test("expr should convert native int to rql int", () async {
      int str = await r.expr(3).run(connection);
      expect(str, equals(3));
    });
    test("expr should convert native double to rql float", () async {
      double str = await r.expr(3.14).run(connection);
      expect(str, equals(3.14));
    });
    test("expr should convert native bool to rql bool", () async {
      bool str = await r.expr(true).run(connection);
      expect(str, equals(true));
    });
    test("expr should convert native list to rql array", () async {
      List str = await r.expr([1, 2, 3]).run(connection);
      expect(str, equals([1, 2, 3]));
    });
    test("expr should convert native object to rql object", () async {
      Map str = await r.expr({'a': 'b'}).run(connection);
      expect(str, equals({'a': 'b'}));
    });
  });

  test("remove the test database", () async {
    Map response = await r.dbDrop(testDbName).run(connection);

    expect(response.containsKey('config_changes'), equals(true));
    expect(response['dbs_dropped'], equals(1));
    expect(response['tables_dropped'], equals(0));
  });

  /// TO TEST:
  /// test with orderby: r.asc(attr)
  /// test with orderby: r.desc(attr)
  /// r.http(url)
  ///
  /// test with filter or something: r.row;
  /// test with time: r.monday ... r.sunday;
  ///    test with time: r.january .. r.december;
}
