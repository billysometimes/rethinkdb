import 'package:test/test.dart';
import '../lib/rethinkdb_driver.dart';

main() {
  Rethinkdb r = new Rethinkdb();
  String databaseName = null;
  String tableName = null;
  String testDbName = null;
  bool shouldDropTable = false;
  var connection;

  setUp(() {
    return r.connect().then((conn) {
      connection = conn;
      if (testDbName == null) {
        return r.uuid().run(connection).then((String useDb) {
          testDbName = 'unit_test_db' + useDb.replaceAll("-", "");
          return r.dbCreate(testDbName).run(connection).then((createdDb) {
            if (databaseName == null) {
              return r.uuid().run(connection).then((String dbName) {
                databaseName = "test_database_" + dbName.replaceAll("-", "");
                if (tableName == null) {
                  return r.uuid().run(connection).then((String tblName) {
                    tableName = "test_table_" + tblName.replaceAll("-", "");
                  });
                }
              });
            }
          });
        });
      }
      connection.use(testDbName);
    });
  });

  tearDown(() {
    if (shouldDropTable) {
      shouldDropTable = false;
      return r.tableDrop(tableName).run(connection).then((d) {
        connection.close();
      });
    } else {
      connection.close();
    }
  });

  test("r.db throws an error if a bad database name is given", () {
    r
        .db('fake2834723895')
        .tableList()
        .run(connection)
        .then((d) {})
        .catchError((err) {
      expect(err is Exception, equals(true));
      expect(err.message, equals('Database `fake2834723895` does not exist.'));
    });
  });

  group("dbCreate command -> ", () {
    test("r.dbCreate will create a new database", () {
      r.dbCreate(databaseName).run(connection).then(expectAsync((Map response) {
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
      }));
    });

    test("r.dbCreate will throw an error if the database exists", () {
      r
          .dbCreate(databaseName)
          .run(connection)
          .then((Map response) {})
          .catchError((err) {
        expect(err is Exception, equals(true));
        expect(
            err.message, equals('Database `${databaseName}` already exists.'));
      });
    });
  });

  group("dbDrop command -> ", () {
    test("r.dbDrop should drop a database", () {
      r.dbDrop(databaseName).run(connection).then((Map response) {
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
    });

    test("r.dbDrop should error if the database does not exist", () {
      r
          .dbDrop(databaseName)
          .run(connection)
          .then((Map response) {})
          .catchError((err) {
        expect(
            err.message, equals('Database `${databaseName}` does not exist.'));
      });
    });
  });

  test("r.dbList should list all databases", () {
    r.dbList().run(connection).then((List response) {
      expect(response is List, equals(true));
      expect(response.indexOf('rethinkdb'), greaterThan(-1));
    });
  });

  group("range command -> ", () {
    test("r.range() with no arguments should return a stream", () {
      r.range().run(connection).then(expectAsync((Cursor cur) {
        expect(cur is Cursor, equals(true));
        cur.take(17).toList().then(expectAsync((item) {
          expect(
              item,
              equals(
                  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        }));
      }));
    });

    test("r.range() should accept a single end arguement", () {
      r.range(10).run(connection).then(expectAsync((Cursor cur) {
        cur.toList().then(expectAsync((List l) {
          expect(l, equals([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
        }));
      }));
    });

    test("r.range() should accept a start and end arguement", () {
      r.range(7, 10).run(connection).then(expectAsync((Cursor cur) {
        cur.toList().then(expectAsync((List l) {
          expect(l, equals([7, 8, 9]));
        }));
      }));
    });
  });

  group("table command -> ", () {
    test("table should return a cursor containing all records for a table", () {
      r.db('rethinkdb').table('stats').run(connection).then((Cursor cur) {
        cur.listen((Map item) {
          expect(item.containsKey('id'), equals(true));
          expect(item.containsKey('query_engine'), equals(true));
        });
      });
    });

    test("table should allow for `read_mode: single` option", () {
      r
          .db('rethinkdb')
          .table('stats', {'read_mode': 'single'})
          .run(connection)
          .then((Cursor cur) {
            cur.listen((Map item) {
              expect(item.containsKey('id'), equals(true));
              expect(item.containsKey('query_engine'), equals(true));
            });
          });
    });

    test("table should allow for `read_mode: majority` option", () {
      r
          .db('rethinkdb')
          .table('stats', {'read_mode': 'majority'})
          .run(connection)
          .then((Cursor cur) {
            cur.listen((Map item) {
              expect(item.containsKey('id'), equals(true));
              expect(item.containsKey('query_engine'), equals(true));
            });
          });
    });

    test("table should allow for `read_mode: outdated` option", () {
      r
          .db('rethinkdb')
          .table('stats', {'read_mode': 'outdated'})
          .run(connection)
          .then((Cursor cur) {
            cur.listen((Map item) {
              expect(item.containsKey('id'), equals(true));
              expect(item.containsKey('query_engine'), equals(true));
            });
          });
    });

    test("table should catch invalid read_mode option", () {
      r
          .db('rethinkdb')
          .table('stats', {'read_mode': 'badReadMode'})
          .run(connection)
          .then((Cursor cur) {})
          .catchError((err) {
            expect(
                err.message,
                equals(
                    'Read mode `badReadMode` unrecognized (options are "majority", "single", and "outdated").'));
          });
    });

    test("table should allow for `identifier_format: name` option", () {
      r
          .db('rethinkdb')
          .table('stats', {'identifier_format': 'name'})
          .run(connection)
          .then((Cursor cur) {
            cur.listen((Map item) {
              expect(item.containsKey('id'), equals(true));
              expect(item.containsKey('query_engine'), equals(true));
            });
          });
    });

    test("table should allow for `identifier_format: uuid` option", () {
      r
          .db('rethinkdb')
          .table('stats', {'identifier_format': 'uuid'})
          .run(connection)
          .then((Cursor cur) {
            cur.listen((Map item) {
              expect(item.containsKey('id'), equals(true));
              expect(item.containsKey('query_engine'), equals(true));
            });
          });
    });

    test("table should catch invalid identifier_format option", () {
      r
          .db('rethinkdb')
          .table('stats', {'identifier_format': 'badFormat'})
          .run(connection)
          .then((Cursor cur) {})
          .catchError((err) {
            expect(
                err.message,
                equals(
                    'Identifier format `badFormat` unrecognized (options are "name" and "uuid").'));
          });
    });

    test("table should catch bad options", () {
      r
          .db('rethinkdb')
          .table('stats', {'fake_option': 'bad_value'})
          .run(connection)
          .then((Cursor cur) {})
          .catchError((err) {
            expect(err.message,
                equals('Unrecognized optional argument `fake_option`.'));
          });
    });
  });

  group("tableCreate command -> ", () {
    test("should create a table", () {
      r.tableCreate(tableName).run(connection).then(expectAsync((Map response) {
        expect(response is Map, equals(true));
        expect(response.keys.length, equals(2));
        expect(response.containsKey('config_changes'), equals(true));
        expect(response['config_changes'][0]['new_val']['name'],
            equals(tableName));
        expect(response['tables_created'], equals(1));
      })).catchError((err) => print(err.message));
    });

    test("should error if table exists", () {
      shouldDropTable = true;

      r
          .tableCreate(tableName)
          .run(connection)
          .then((Map response) {})
          .catchError(expectAsync((err) {
        expect(err.message,
            equals('Table `${testDbName}.${tableName}` already exists.'));
      }));
    });

    test("should accept primary_key option", () {
      shouldDropTable = true;

      r
          .tableCreate(tableName, {'primary_key': 'pk1'})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response is Map, equals(true));
            expect(response.keys.length, equals(2));
            expect(response.containsKey('config_changes'), equals(true));
            expect(response['config_changes'][0]['new_val']['name'],
                equals(tableName));
            expect(response['config_changes'][0]['new_val']['primary_key'],
                equals('pk1'));
            expect(response['tables_created'], equals(1));
          }))
          .catchError((err) => print(err.message));
    });

    test("should accept durability option", () {
      shouldDropTable = true;

      r
          .tableCreate(tableName, {'durability': 'soft'})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response is Map, equals(true));
            expect(response.keys.length, equals(2));
            expect(response.containsKey('config_changes'), equals(true));
            expect(response['config_changes'][0]['new_val']['name'],
                equals(tableName));
            expect(response['config_changes'][0]['new_val']['durability'],
                equals('soft'));
            expect(response['tables_created'], equals(1));
          }));
    });

    test("should accept shards option", () {
      shouldDropTable = true;

      r
          .tableCreate(tableName, {'shards': 44})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response is Map, equals(true));
            expect(response.keys.length, equals(2));
            expect(response.containsKey('config_changes'), equals(true));
            expect(response['config_changes'][0]['new_val']['name'],
                equals(tableName));
            expect(response['config_changes'][0]['new_val']['shards'].length,
                equals(44));
            expect(response['tables_created'], equals(1));
          }));
    });

    test("should accept replicas with an integer option", () {
      r
          .tableCreate(tableName, {'replicas': 1})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response is Map, equals(true));
            expect(response.keys.length, equals(2));
            expect(response.containsKey('config_changes'), equals(true));
            expect(response['config_changes'][0]['new_val']['name'],
                equals(tableName));
            expect(
                response['config_changes'][0]['new_val']['shards'][0]
                        ['replicas']
                    .length,
                equals(1));
            expect(response['tables_created'], equals(1));
          }))
          .catchError((err) => print(err.message));
    });

    test("should accept replicas with an object option", () {
      r
          .tableCreate(tableName, {
            'replicas': {'tag1': 1},
            'primary_replica_tag': 'tag1'
          })
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response is Map, equals(true));
            expect(response.keys.length, equals(2));
            expect(response.containsKey('config_changes'), equals(true));
            expect(response['config_changes'][0]['new_val']['name'],
                equals(tableName));
            expect(
                response['config_changes'][0]['new_val']['shards'][0]
                        ['replicas']
                    .length,
                equals(1));
            expect(response['tables_created'], equals(1));
          }));
    }, skip: "I don't quite understand replica tags");
  });

  test("tableList command -> should List tables on the database", () {
    r.tableList().run(connection).then(expectAsync((List l) {
      expect(l is List, equals(true));
    }));
  });

  group("dropTable command -> ", () {
    test("should throw error if table doesn't exist", () {
      r
          .tableDrop('TableDoesntExist')
          .run(connection)
          .then((d) {})
          .catchError(expectAsync((err) {
        expect(err is Exception, equals(true));
        expect(err.message,
            equals('Table `${testDbName}.TableDoesntExist` does not exist.'));
      }));
    });
    test("should drop a table if it exists", () {
      r.tableDrop(tableName).run(connection).then(expectAsync((Map response) {
        expect(response is Map, equals(true));
        expect(response.keys.length, equals(2));
        expect(response.containsKey('config_changes'), equals(true));
        expect(response['config_changes'][0]['new_val'], equals(null));
        expect(response['config_changes'][0]['old_val']['name'],
            equals(tableName));
        expect(response['tables_dropped'], equals(1));
      }));
    });
  });

  group("time command -> ", () {
    test(
        "should return a time object if given a year, month, day, and timezone",
        () {
      r
          .time(2010, 12, 29, timezone: 'Z')
          .run(connection)
          .then(expectAsync((DateTime obj) {
        expect(obj.runtimeType, equals(DateTime));
        expect(obj.isBefore(new DateTime.now()), equals(true));
        expect(obj.minute, equals(0));
        expect(obj.second, equals(0));
      }));
    });

    test(
        "should return a time object if given a year, month, day, hour, minute, second, and timezone",
        () {
      r
          .time(2010, 12, 29, hour: 7, minute: 33, second: 45, timezone: 'Z')
          .run(connection)
          .then(expectAsync((DateTime obj) {
        expect(obj.runtimeType, equals(DateTime));
        expect(obj.isBefore(new DateTime.now()), equals(true));
        expect(obj.minute, equals(33));
        expect(obj.second, equals(45));
      })).catchError((err) => print(err.message));
    });
  });

  test(
      "nativeTime command -> should turn a native dart DateTime to a reql time",
      () {
    DateTime dt = new DateTime.now();
    r.nativeTime(dt).run(connection).then(expectAsync((DateTime rqlDt) {
      expect(dt.year, equals(rqlDt.year));
      expect(dt.month, equals(rqlDt.month));
      expect(dt.day, equals(rqlDt.day));
      expect(dt.hour, equals(rqlDt.hour));
      expect(dt.minute, equals(rqlDt.minute));
      expect(dt.second, equals(rqlDt.second));
    }));
  });

  group("ISO8601 command -> ", () {
    test("should take an ISO8601 string and convert it to a DateTime object",
        () {
      r
          .ISO8601('1986-11-03T08:30:00-07:00')
          .run(connection)
          .then(expectAsync((DateTime dt) {
        expect(dt.year, equals(1986));
        expect(dt.month, equals(11));
        expect(dt.day, equals(3));
        expect(dt.hour, equals(8));
        expect(dt.minute, equals(30));
      }));
    });

    test("should accept a timezone argument as well", () {
      r
          .ISO8601('1986-11-03T08:30:00-07:00', 'MST')
          .run(connection)
          .then(expectAsync((DateTime dt) {
        expect(dt.year, equals(1986));
        expect(dt.month, equals(11));
        expect(dt.day, equals(3));
        expect(dt.hour, equals(8));
        expect(dt.minute, equals(30));
      }));
    });
  });

  test("epochTime command -> should take a timestamp and return a time object",
      () {
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(531360000000);

    r.epochTime(531360000).run(connection).then(expectAsync((DateTime dt) {
      print(dt);
      expect(dt.year, equals(dateTime.year));
      expect(dt.month, equals(dateTime.month));
      expect(dt.day, equals(dateTime.day));
      expect(dt.hour, equals(dateTime.hour));
      expect(dt.minute, equals(dateTime.minute));
      expect(dt.second, equals(dateTime.second));
    }));
  });

  test("now command -> should return current DateTime object", () {
    r.now().run(connection).then(expectAsync((DateTime dt) {
      expect(dt is DateTime, equals(true));
      expect(dt.isBefore(new DateTime.now()), equals(true));
    }));
  });

  group("rqlDo command -> ", () {
    test("should accept a single argument and function", () {
      r.rqlDo(3, (item) => item > 4).run(connection).then(expectAsync((i) {
        expect(i, equals(false));
      }));
    });

    test("should accept a many arguments and a function", () {
      r
          .rqlDo(
              3,
              4,
              5,
              6,
              7,
              (item1, item2, item3, item4, item5) =>
                  item1 + item2 + item3 + item4 + item5)
          .run(connection)
          .then(expectAsync((i) {
        expect(i, equals(25));
      }));
    });

    test("should accept many args and an expression", () {
      r.rqlDo(3, 7, r.range).run(connection).then(expectAsync((Cursor cur) {
        cur.toList().then(expectAsync((list) {
          expect(list, equals([3, 4, 5, 6]));
        }));
      }));
    });
  });

  group("branch command -> ", () {
    test("should accept a true test and return the true branch value", () {
      r
          .branch(3 < 4, 'isTrue', 'isFalse')
          .run(connection)
          .then(expectAsync((String val) {
        expect(val, equals('isTrue'));
      }));
    });

    test("should accept a false test and return the false branch value", () {
      r
          .branch(3 > 4, 'isTrue', 'isFalse')
          .run(connection)
          .then(expectAsync((String val) {
        expect(val, equals('isFalse'));
      }));
    });

    test("should accept multiple tests and actions", () {
      r
          .branch(1 > 4, 'isTrue', 0 < 1, 'elseTrue', 'isFalse')
          .run(connection)
          .then(expectAsync((String val) {
        expect(val, equals('elseTrue'));
      }));
    });
  });

  test("error command -> should create a custom error", () {
    r
        .error('This is my Error')
        .run(connection)
        .then((_) {})
        .catchError(expectAsync((err) {
      expect(err.runtimeType, equals(RqlRuntimeError));
      expect(err.message, equals('This is my Error'));
    }));
  });

  group("js command -> ", () {
    test("should run custom javascript", () {
      String jsString = """
        function concatStrs(){
          return 'firstHalf' + '_' + 'secondHalf';
        }
        concatStrs();
        """;

      r.js(jsString).run(connection).then(expectAsync((String str) {
        expect(str, equals('firstHalf_secondHalf'));
      }));
    });

    test("should accept a timeout option", () {
      String jsString = """
        function concatStrs(){
          return 'firstHalf' + '_' + 'secondHalf';
        }
        while(true){
          concatStrs();
        }
        """;
      int timeout = 3;
      r
          .js(jsString, {'timeout': timeout})
          .run(connection)
          .then((String str) {})
          .catchError(expectAsync((err) {
            expect(
                err.message,
                equals(
                    'JavaScript query `${jsString}` timed out after ${timeout}.000 seconds.'));
          }));
    });
  });

  group("json command -> ", () {
    test("should parse a json string", () {
      String jsonString = "[1,2,3,4]";
      r.json(jsonString).run(connection).then(expectAsync((List obj) {
        expect([1, 2, 3, 4], equals(obj));
      }));
    });

    test("should throw error if jsonString is invalid", () {
      String jsonString = "1,2,3,4]";
      r
          .json(jsonString)
          .run(connection)
          .then((List obj) {})
          .catchError(expectAsync((err) {
        expect(
            err.message,
            equals(
                'Failed to parse "$jsonString" as JSON: The document root must not follow by other values.'));
      }));
    });
  });

  group("object command -> ", () {
    test("should create an object from an array of values", () {
      r
          .object('key', 'val', 'listKey', [1, 2, 3, 4], 'objKey', {'a': 'b'})
          .run(connection)
          .then(expectAsync((Map obj) {
        expect(obj is Map, equals(true));
        expect(obj['key'], equals('val'));
        expect(obj['listKey'], equals([1, 2, 3, 4]));
        expect(obj['objKey']['a'], equals('b'));
      }));
    });

    test("should throw an error if params cannot be parsed into a map", () {
      r
          .object('key', 'val', 'listKey', [1, 2, 3, 4], 'objKey', {'a': 'b'},
              'odd')
          .run(connection)
          .then((_) {})
          .catchError(expectAsync((err) {
        expect(
            err.message,
            equals(
                'OBJECT expects an even number of arguments (but found 7).'));
      }));
    });
  });

  test("args command -> should accept an array", () {
    r.args([1, 2]).run(connection).then(expectAsync((List l) {
          expect(l, equals([1, 2]));
        }));
  });

  group("random command -> ", () {
    test("should generate a random number if no parameters are provided", () {
      r.random().run(connection).then(expectAsync((number) {
        expect(number is double, equals(true));
        expect(number, lessThan(1));
        expect(number, greaterThan(0));
      }));
    });

    test("should generate a random int no greater than the single argument",
        () {
      r.random(50).run(connection).then(expectAsync((number) {
        expect(number is int, equals(true));
        expect(number, lessThanOrEqualTo(50));
        expect(number, greaterThan(0));
      }));
    });

    test("should generate a random int between the two arguments", () {
      r.random(50, 55).run(connection).then(expectAsync((number) {
        expect(number is int, equals(true));
        expect(number, lessThanOrEqualTo(55));
        expect(number, greaterThan(50));
      }));
    });

    test("should generate a random float between the two arguments", () {
      r
          .random(50, 55, {'float': true})
          .run(connection)
          .then(expectAsync((number) {
            expect(number is double, equals(true));
            expect(number, lessThan(55));
            expect(number, greaterThan(50));
          }));
    });
  });

  group("not command -> ", () {
    test("should return false if given no arguements", () {
      r.not().run(connection).then(expectAsync((bool val) {
        expect(val, equals(false));
      }));
    });

    test("should return the inverse of the argument provided", () {
      r.not(false).run(connection).then(expectAsync((bool val) {
        expect(val, equals(true));
      })).catchError((err) => print(err.message));
    });
  });

  group("map command -> ", () {
    test("should map over an array", () {
      r
          .map([1, 2, 3, 4, 5], (item) => item * 2)
          .run(connection)
          .then(expectAsync((List arr) {
            expect(arr, equals([2, 4, 6, 8, 10]));
          }));
    });

    test("should map over multiple arrays", () {
      r
          .map([1, 2, 3, 4, 5], [10, 9, 8, 7], (item, item2) => item + item2)
          .run(connection)
          .then(expectAsync((List arr) {
            //notice that the first array is longer but we
            //only map the length of the shortest array
            expect(arr, equals([11, 11, 11, 11]));
          }))
          .catchError((err) {
            print(err.message);
          });
    });

    test("should map a sequence", () {
      r
          .map(
              r.expr({
                'key': [1, 2, 3, 4, 5]
              }).getField('key'),
              (item) => item + 1)
          .run(connection)
          .then(expectAsync((List arr) {
        expect(arr, equals([2, 3, 4, 5, 6]));
      })).catchError((err) {
        print(err.message);
      });
    });

    test("should map over multiple sequences", () {
      r
          .map(
              r.expr({
                'key': [1, 2, 3, 4, 5]
              }).getField('key'),
              r.expr({
                'key': [1, 2, 3, 4, 5]
              }).getField('key'),
              (item, item2) => item + item2)
          .run(connection)
          .then(expectAsync((List arr) {
        expect(arr, equals([2, 4, 6, 8, 10]));
      })).catchError((err) {
        print(err.message);
      });
    });
  });

  group("and command -> ", () {
    test("should and two values together", () {
      r.and(true, true).run(connection).then(expectAsync((bool val) {
        expect(val, equals(true));
      }));
    });
    test("should and more than two values together", () {
      r.and(true, true, false).run(connection).then(expectAsync((bool val) {
        expect(val, equals(false));
      }));
    });
  });

  group("or command -> ", () {
    test("should or two values together", () {
      r.or(true, false).run(connection).then(expectAsync((bool val) {
        expect(val, equals(true));
      }));
    });
    test("should and more than two values together", () {
      r.or(false, false, false).run(connection).then(expectAsync((bool val) {
        expect(val, equals(false));
      }));
    });
  });

  group("binary command -> ", () {
    test("should convert string to binary", () {
      r.binary('billysometimes').run(connection).then(expectAsync((data) {
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
      }));
    });
  });

  group("uuid command -> ", () {
    test("should create a unique uuid", () {
      r.uuid().run(connection).then(expectAsync((String val) {
        expect(val is String, equals(true));
      }));
    });

    test("should create a uuid based on a string key", () {
      String key = "billysometimes";
      r.uuid(key).run(connection).then(expectAsync((String val) {
        expect(val is String, equals(true));
        expect(val, equals('b3f5029e-f777-572f-a85d-5529b74fd99b'));
      }));
    });
  });

  group("expr command -> ", () {
    test("expr should convert native string to rql string", () {
      r.expr('string').run(connection).then(expectAsync((String str) {
        expect(str, equals('string'));
      }));
    });
    test("expr should convert native int to rql int", () {
      r.expr(3).run(connection).then(expectAsync((int str) {
        expect(str, equals(3));
      }));
    });
    test("expr should convert native double to rql float", () {
      r.expr(3.14).run(connection).then(expectAsync((double str) {
        expect(str, equals(3.14));
      }));
    });
    test("expr should convert native bool to rql bool", () {
      r.expr(true).run(connection).then(expectAsync((bool str) {
        expect(str, equals(true));
      }));
    });
    test("expr should convert native list to rql array", () {
      r.expr([1, 2, 3]).run(connection).then(expectAsync((List str) {
            expect(str, equals([1, 2, 3]));
          }));
    });
    test("expr should convert native object to rql object", () {
      r.expr({'a': 'b'}).run(connection).then(expectAsync((Map str) {
            expect(str, equals({'a': 'b'}));
          }));
    });
  });
  /**TO TEST:
    test with orderby r.asc(attr)
    test with orderby r.desc(attr)
    r.http(url)
    r.circle(point, radius)
    r.line(point1, point2)
    r.point
    r.polygon(point1, point2)
    test with update and merge r.literal(args)

    test with filter or something r.row;
    test with time r.monday ... r.sunday;
    test with time r.january .. r.december;
    test with between r.minval;
    test with between r.maxval
    r.expr(val);**/
}
