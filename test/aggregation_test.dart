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
      await connection.close();
    } else {
      await connection.close();
    }
  });

  group("count command -> ", () {
    test("should count an array", () async {
      int count = await r.expr([1,2,3]).count().run(connection);
      expect(count, equals(3));
    });
    
    test("should count an array with a filter", () async {
      int count = await r.expr([2,1,2,3,2,2]).count(2).run(connection);
      expect(count, equals(4));
    });

    test("should count items in a table", () async {
      await r.tableCreate(tableName).run(connection);
      List testData = [
        {"id":1},
        {"id":2},
        {"id":3},
        {"id":4},
        {"id":5}
      ];
      await r.table(tableName).insert(testData).run(connection);
      int count = await r.table(tableName).count().run(connection);
      expect(count, equals(5));
    });

    test("should count items in a table with a filter", () async {
      List testData = [
        {"id":6, "age":21},
        {"id":7, "age":22},
        {"id":8, "age":21},
        {"id":9, "age":33},
        {"id":10, "age":34}
      ];
      await r.table(tableName).insert(testData).run(connection);
      int count = await r.table(tableName)('age').count(21).run(connection);
      expect(count, equals(2));

      count = await r.table(tableName).count((user){
        return user('id').lt(8);
      }).run(connection);
      
      expect(count, equals(7));
    });

    test("remove the test database", () async {
      Map response = await r.dbDrop(testDbName).run(connection);

      expect(response.containsKey('config_changes'), equals(true));
      expect(response['dbs_dropped'], equals(1));
      expect(response['tables_dropped'], equals(1));
    });
  });
}
