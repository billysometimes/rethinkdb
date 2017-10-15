import 'package:test/test.dart';
import '../lib/rethinkdb_driver.dart';

main() {
  Rethinkdb r = new Rethinkdb();
  String databaseName = null;
  String tableName = null;
  String testDbName = null;
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
      connection.close();
    } else {
      connection.close();
    }
  });

  group("tableCreate command -> ", () {
    test("should create a table given a name", () async {
      Map createdTable = await r.tableCreate('unitTestTable').run(connection);

      expect(createdTable['config_changes'] is List, equals(true));
      expect(createdTable['tables_created'], equals(1));
      Map newTable = createdTable['config_changes'][0]['new_val'];
      expect(newTable['name'], equals('unitTestTable'));
      expect(createdTable['config_changes'][0]['old_val'], equals(null));
    });
    test(
        "should throw an `ReqlOpFailedError` if a table with the same name exists",
        () async {
      try {
        await r.tableCreate('unitTestTable').run(connection);
      } catch (err) {
        expect(err.runtimeType, equals(ReqlOpFailedError));
      }
    });
    test("should allow user to specify primary_key", () async {
      Map createdTable = await r.tableCreate(
          'unitTestTable1', {'primary_key': 'userID'}).run(connection);

      expect(createdTable['config_changes'] is List, equals(true));
      expect(createdTable['tables_created'], equals(1));
      Map newTable = createdTable['config_changes'][0]['new_val'];
      expect(newTable['name'], equals('unitTestTable1'));
      expect(createdTable['config_changes'][0]['old_val'], equals(null));
      expect(newTable['primary_key'], equals('userID'));
    });

    test("should allow user to specify durability", () async {
      Map createdTable = await r.tableCreate(
          'unitTestTable2', {'durability': 'soft'}).run(connection);

      expect(createdTable['config_changes'] is List, equals(true));
      expect(createdTable['tables_created'], equals(1));
      Map newTable = createdTable['config_changes'][0]['new_val'];
      expect(newTable['name'], equals('unitTestTable2'));
      expect(createdTable['config_changes'][0]['old_val'], equals(null));
      expect(newTable['durability'], equals('soft'));
    });
    test("should allow user to specify number of shards", () async {
      Map createdTable =
          await r.tableCreate('unitTestTable3', {'shards': 64}).run(connection);

      expect(createdTable['config_changes'] is List, equals(true));
      expect(createdTable['tables_created'], equals(1));
      Map newTable = createdTable['config_changes'][0]['new_val'];
      expect(newTable['name'], equals('unitTestTable3'));
      expect(createdTable['config_changes'][0]['old_val'], equals(null));
      expect(newTable['shards'].length, equals(64));
    });

    test("should allow user to specify replicas", () async {
      Map createdTable =
          await r.tableCreate('unitTestTable4', {'shards': 3}).run(connection);

      expect(createdTable['config_changes'] is List, equals(true));
      expect(createdTable['tables_created'], equals(1));
      Map newTable = createdTable['config_changes'][0]['new_val'];
      expect(newTable['name'], equals('unitTestTable4'));
      expect(createdTable['config_changes'][0]['old_val'], equals(null));
      expect(newTable['shards'].length, equals(3));
    });
  });

  group("tableDrop command -> ", () {
    test("should drop an existing table", () async {
      Map droppedTable = await r.tableDrop('unitTestTable4').run(connection);

      expect(droppedTable['tables_dropped'], equals(1));
      Map oldTable = droppedTable['config_changes'][0]['old_val'];
      expect(oldTable['name'], equals('unitTestTable4'));
    });

    test("should throw an `ReqlOpFailedError` if the table doesn't exist",
        () async {
      try {
        await r.tableDrop('unitTestTable4').run(connection);
      } catch (err) {
        expect(err is ReqlOpFailedError, equals(true));
      }
    });
  });

  test("tableList command -> should list all tables for the database",
      () async {
    List tables = await r.tableList().run(connection);

    expect(tables is List, equals(true));
    expect(tables.length, equals(4));
  });

  group("indexCreate command -> ", () {
    test("should create a new secondary index", () async {
      Map ind =
          await r.table('unitTestTable3').indexCreate('index1').run(connection);
      expect(ind['created'], equals(1));
    });

    test("should create a new geo index", () async {
      Map ind = await r
          .table('unitTestTable3')
          .indexCreate('location', {'geo': true}).run(connection);

      expect(ind['created'], equals(1));
    });

    test("should create a new index with an index function", () async {
      Map ind = await r
          .table('unitTestTable3')
          .indexCreate('surname', (name) => name('last'))
          .run(connection);

      expect(ind['created'], equals(1));
    });

    test("should create a new index with an index function as `r.row`",
        () async {
      Map ind = await r
          .table('unitTestTable3')
          .indexCreate('surname1', r.row('name')('last'))
          .run(connection);

      expect(ind['created'], equals(1));
    });

    test("should create a new compound index with an index", () async {
      Map ind = await r.table('unitTestTable3').indexCreate(
          'surnameAndBirthYear',
          [r.row('name')('last'), r.row('birthday')('year')]).run(connection);

      expect(ind['created'], equals(1));
    });

    test("should create multi index", () async {
      Map ind = await r
          .table('unitTestTable3')
          .indexCreate('author', {'multi': true}).run(connection);

      expect(ind['created'], equals(1));
    });
  });

  test("indexDrop command -> remove an index", () async {
    Map ind =
        await r.table('unitTestTable3').indexDrop('author').run(connection);
    expect(ind['dropped'], equals(1));
  });

  test("indexList command -> should list all indexes for a table", () async {
    List indexes = await r.table('unitTestTable3').indexList().run(connection);

    expect(indexes is List, equals(true));
    expect(indexes.length, equals(5));
  });

  group("indexRename command -> ", () {
    test("should rename an index", () async {
      Map renamedIndex = await r
          .table('unitTestTable3')
          .indexRename('surname', 'lastName')
          .run(connection);
      expect(renamedIndex['renamed'], equals(1));
    });

    test("should overwrite existing index if overwrite = true", () async {
      Map renamedIndex = await r.table('unitTestTable3').indexRename(
          'lastName', 'location', {'overwrite': true}).run(connection);

      expect(renamedIndex['renamed'], equals(1));
    });
  });

  group("indexStatus command -> ", () {
    test("should return status of all indexes", () async {
      List indexes =
          await r.table('unitTestTable3').indexStatus().run(connection);

      expect(indexes is List, equals(true));
      expect(indexes.length, equals(4));
    });

    test("should return status of a single index", () async {
      List indexes =
          await r.table('unitTestTable3').indexStatus('index1').run(connection);

      expect(indexes is List, equals(true));
      expect(indexes.length, equals(1));
      expect(indexes[0]['index'], equals('index1'));
    });

    test("should return any number of indexes", () async {
      List indexes = await r
          .table('unitTestTable3')
          .indexStatus('index1', 'location')
          .run(connection);

      expect(indexes is List, equals(true));
      expect(indexes.length, equals(2));
      expect(indexes[0]['index'], equals('index1'));
    });
  });

  group("indexWait command -> ", () {
    test("should wait for all indexes if none are specified", () async {
      List response =
          await r.table('unitTestTable3').indexWait().run(connection);

      expect(response is List, equals(true));
      expect(response.length, equals(4));
    });

    test("should wait for a specified index", () async {
      List response =
          await r.table('unitTestTable3').indexWait('index1').run(connection);

      expect(response is List, equals(true));
      expect(response.length, equals(1));
      expect(response[0]['index'], equals('index1'));
    });

    test("should wait for any number of indexes", () async {
      List indexes = await r
          .table('unitTestTable3')
          .indexWait('index1', 'location')
          .run(connection);

      expect(indexes is List, equals(true));
      expect(indexes.length, equals(2));
      expect(indexes[0]['index'], equals('index1'));
    });
  });

  test("remove the test database", () async {
    Map response = await r.dbDrop(testDbName).run(connection);
    expect(response.containsKey('config_changes'), equals(true));
    expect(response['dbs_dropped'], equals(1));
  });
}
