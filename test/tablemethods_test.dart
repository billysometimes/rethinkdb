import 'package:test/test.dart';
import '../lib/rethinkdb_driver.dart';

main() {
  Rethinkdb r = new Rethinkdb();
  String databaseName = null;
  String tableName = null;
  String testDbName = null;
  bool shouldDropTable = false;
  var connection;

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

  tearDown(() {
    if (shouldDropTable) {
      shouldDropTable = false;
      return r.tableDrop(tableName).run(connection).then((_) {
        connection.close();
      });
    } else {
      connection.close();
    }
  });

  group("tableCreate command -> ", () {
    test("should create a table given a name", () {
      r
          .tableCreate('unitTestTable')
          .run(connection)
          .then(expectAsync((Map createdTable) {
        expect(createdTable['config_changes'] is List, equals(true));
        expect(createdTable['tables_created'], equals(1));
        Map newTable = createdTable['config_changes'][0]['new_val'];
        expect(newTable['name'], equals('unitTestTable'));
        expect(createdTable['config_changes'][0]['old_val'], equals(null));
      }));
    });
    test(
        "should throw an `ReqlOpFailedError` if a table with the same name exists",
        () {
      r
          .tableCreate('unitTestTable')
          .run(connection)
          .then((Map createdTable) {})
          .catchError(expectAsync((err) {
        expect(err.runtimeType, equals(ReqlOpFailedError));
      }));
    });
    test("should allow user to specify primary_key", () {
      r
          .tableCreate('unitTestTable1', {'primary_key': 'userID'})
          .run(connection)
          .then(expectAsync((Map createdTable) {
            expect(createdTable['config_changes'] is List, equals(true));
            expect(createdTable['tables_created'], equals(1));
            Map newTable = createdTable['config_changes'][0]['new_val'];
            expect(newTable['name'], equals('unitTestTable1'));
            expect(createdTable['config_changes'][0]['old_val'], equals(null));
            expect(newTable['primary_key'], equals('userID'));
          }));
    });
    test("should allow user to specify durability", () {
      r
          .tableCreate('unitTestTable2', {'durability': 'soft'})
          .run(connection)
          .then(expectAsync((Map createdTable) {
            expect(createdTable['config_changes'] is List, equals(true));
            expect(createdTable['tables_created'], equals(1));
            Map newTable = createdTable['config_changes'][0]['new_val'];
            expect(newTable['name'], equals('unitTestTable2'));
            expect(createdTable['config_changes'][0]['old_val'], equals(null));
            expect(newTable['durability'], equals('soft'));
          }));
    });
    test("should allow user to specify number of shards", () {
      r
          .tableCreate('unitTestTable3', {'shards': 64})
          .run(connection)
          .then(expectAsync((Map createdTable) {
            expect(createdTable['config_changes'] is List, equals(true));
            expect(createdTable['tables_created'], equals(1));
            Map newTable = createdTable['config_changes'][0]['new_val'];
            expect(newTable['name'], equals('unitTestTable3'));
            expect(createdTable['config_changes'][0]['old_val'], equals(null));
            expect(newTable['shards'].length, equals(64));
          }));
    });
    test("should allow user to specify replicas", () {
      r
          .tableCreate('unitTestTable4', {'shards': 3})
          .run(connection)
          .then(expectAsync((Map createdTable) {
            expect(createdTable['config_changes'] is List, equals(true));
            expect(createdTable['tables_created'], equals(1));
            Map newTable = createdTable['config_changes'][0]['new_val'];
            expect(newTable['name'], equals('unitTestTable4'));
            expect(createdTable['config_changes'][0]['old_val'], equals(null));
            expect(newTable['shards'].length, equals(3));
          }));
    });
  });
  group("tableDrop command -> ", () {
    test("should drop an existing table", () {
      r
          .tableDrop('unitTestTable4')
          .run(connection)
          .then(expectAsync((Map droppedTable) {
        expect(droppedTable['tables_dropped'], equals(1));
        Map oldTable = droppedTable['config_changes'][0]['old_val'];
        expect(oldTable['name'], equals('unitTestTable4'));
      }));
    });

    test("should throw an `ReqlOpFailedError` if the table doesn't exist", () {
      r
          .tableDrop('unitTestTable4')
          .run(connection)
          .then((Map droppedTable) {})
          .catchError(expectAsync((err) {
        expect(err is ReqlOpFailedError, equals(true));
      }));
    });
  });

  test("tableList command -> should list all tables for the database", () {
    r.tableList().run(connection).then(expectAsync((List tables) {
      expect(tables is List, equals(true));
      expect(tables.length, equals(4));
    }));
  });

  group("indexCreate command -> ", () {
    test("should create a new secondary index", () {
      r
          .table('unitTestTable3')
          .indexCreate('index1')
          .run(connection)
          .then(expectAsync((ind) {
        expect(ind['created'], equals(1));
      }));
    });
    test("should create a new geo index", () {
      r
          .table('unitTestTable3')
          .indexCreate('location', {'geo': true})
          .run(connection)
          .then(expectAsync((ind) {
            expect(ind['created'], equals(1));
          }));
    });
    test("should create a new index with an index function", () {
      //TODO fix r.row...
      r
          .table('unitTestTable3')
          .indexCreate('surname', (name) => name('last'))
          .run(connection)
          .then(expectAsync((ind) {
        expect(ind['created'], equals(1));
      })).catchError((err) => print(err));
    });

    test("should create a new index with an index function as `r.row`", () {
      r
          .table('unitTestTable3')
          .indexCreate('surname', r.row('name')('last'))
          .run(connection)
          .then(expectAsync((ind) {
        expect(ind['created'], equals(1));
      })).catchError((err) => print(err));
    }, skip: "r.row isn't working");

    test("should create a new compound index with an index", () {
      //TODO fix compound indexes...
      r
          .table('unitTestTable3')
          .indexCreate('surnameAndBirthYear',
              [(name) => name('last'), (birthday) => birthday('year')])
          .run(connection)
          .then(expectAsync((ind) {
            expect(ind['created'], equals(1));
          }))
          .catchError((err) => print(err));
    }, skip: "compound indexes aren't working");

    test("should create multi index", () {
      r
          .table('unitTestTable3')
          .indexCreate('author', {'multi': true})
          .run(connection)
          .then(expectAsync((ind) {
            expect(ind['created'], equals(1));
          }))
          .catchError((err) => print(err));
    });
  });

  test("indexDrop command -> remove an index", () {
    r
        .table('unitTestTable3')
        .indexDrop('author')
        .run(connection)
        .then(expectAsync((ind) {
      expect(ind['dropped'], equals(1));
    })).catchError((err) => print(err));
  });

  test("indexList command -> should list all indexes for a table", () {
    r
        .table('unitTestTable3')
        .indexList()
        .run(connection)
        .then(expectAsync((List indexes) {
      expect(indexes is List, equals(true));
      expect(indexes.length, equals(3));
    })).catchError((err) => print(err));
  });

  group("indexRename command -> ", () {
    test("should rename an index", () {
      r
          .table('unitTestTable3')
          .indexRename('surname', 'lastName')
          .run(connection)
          .then(expectAsync((renamedIndex) {
        print(renamedIndex);
        expect(renamedIndex['renamed'], equals(1));
      })).catchError((err) => print(err));
    });

    test("should overwrite existing index if overwrite = true", () {
      r
          .table('unitTestTable3')
          .indexRename('lastName', 'location', {'overwrite': true})
          .run(connection)
          .then(expectAsync((renamedIndex) {
            expect(renamedIndex['renamed'], equals(1));
          }))
          .catchError((err) => print(err));
    });
  });

  group("indexStatus command -> ", () {
    test("should return status of all indexes", () {
      r
          .table('unitTestTable3')
          .indexStatus()
          .run(connection)
          .then(expectAsync((indexes) {
        expect(indexes is List, equals(true));
        expect(indexes.length, equals(2));
      }));
    });
    test("should return status of a single index", () {
      r
          .table('unitTestTable3')
          .indexStatus('index1')
          .run(connection)
          .then(expectAsync((indexes) {
        expect(indexes is List, equals(true));
        expect(indexes.length, equals(1));
        expect(indexes[0]['index'], equals('index1'));
      }));
    });
    test("should return any number of indexes", () {
      r
          .table('unitTestTable3')
          .indexStatus('index1', 'location')
          .run(connection)
          .then(expectAsync((indexes) {
        expect(indexes is List, equals(true));
        expect(indexes.length, equals(2));
        expect(indexes[0]['index'], equals('index1'));
      }));
    });
  });

  group("indexWait command -> ", () {
    test("should wait for all indexes if none are specified", () {
      r
          .table('unitTestTable3')
          .indexWait()
          .run(connection)
          .then(expectAsync((response) {
        expect(response is List, equals(true));
        expect(response.length, equals(2));
      }));
    });

    test("should wait for a specified index", () {
      r
          .table('unitTestTable3')
          .indexWait('index1')
          .run(connection)
          .then(expectAsync((response) {
        expect(response is List, equals(true));
        expect(response.length, equals(1));
        expect(response[0]['index'], equals('index1'));
      }));
    });

    test("should wait for any number of indexes", () {
      r
          .table('unitTestTable3')
          .indexWait('index1', 'location')
          .run(connection)
          .then(expectAsync((indexes) {
        expect(indexes is List, equals(true));
        expect(indexes.length, equals(2));
        expect(indexes[0]['index'], equals('index1'));
      }));
    });
  });

  test("remove the test database", () {
    r.dbDrop(testDbName).run(connection).then(expectAsync((Map response) {
      expect(response.containsKey('config_changes'), equals(true));
      expect(response['dbs_dropped'], equals(1));
    }));
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
