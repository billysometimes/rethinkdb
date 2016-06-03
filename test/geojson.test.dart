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
  test("geojson command -> ", () {
    r
        .geojson({
          'type': 'Point',
          'coordinates': [-122.423246, 37.779388]
        })
        .run(connection)
        .then(expectAsync((rqlGeo) {
          expect(rqlGeo.containsKey('coordinates'), equals(true));
          expect(rqlGeo['type'], equals('Point'));
        }));
  });
}
