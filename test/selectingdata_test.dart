import 'package:test/test.dart';
import '../lib/rethinkdb_driver.dart';

main() {
  var r = new Rethinkdb() as dynamic;

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
    connection.use(testDbName);

    if (tableName == null) {
      String tblName = await r.uuid().run(connection);
      tableName = "test_table_" + tblName.replaceAll("-", "");
      await r.tableCreate(tableName).run(connection);
    }
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

  _setUpTable() async {
    return await r.table(tableName).insert([
      {'id': 1, 'name': 'Jane Doe'},
      {'id': 2, 'name': 'Jon Doe'},
      {'id': 3, 'name': 'Firstname Last'}
    ]).run(connection);
  }

  group("get command -> ", () {
    test("should get a record by primary key", () async {
      await _setUpTable();
      var usr = await r.table(tableName).get(1).run(connection);

      expect(usr['id'], equals(1));
      expect(usr['name'], equals('Jane Doe'));
    });
  });

  group("getAll command -> ", () {
    test("should get records by primary keys", () async {
      Cursor usrs = await r.table(tableName).getAll(1, 3).run(connection);

      expect(usrs is Cursor, equals(true));
      List userList = await usrs.toList();

      expect(userList[1]['id'], equals(1));
      expect(userList[0]['id'], equals(3));

      expect(userList[1]['name'], equals('Jane Doe'));
      expect(userList[0]['name'], equals('Firstname Last'));
    });
  });

  group("between command -> ", () {
    test("should get records between keys defaulting to closed left bound",
        () async {
      Cursor usrs = await r.table(tableName).between(1, 3).run(connection);

      expect(usrs is Cursor, equals(true));
      List userList = await usrs.toList();

      expect(userList.length, equals(2));
      expect(userList[1]['id'], equals(1));
      expect(userList[0]['id'], equals(2));

      expect(userList[1]['name'], equals('Jane Doe'));
      expect(userList[0]['name'], equals('Jon Doe'));
    });

    test("should get records between keys with closed right bound", () async {
      Cursor usrs = await r
          .table(tableName)
          .between(1, 3, {'right_bound': 'closed'}).run(connection);

      expect(usrs is Cursor, equals(true));
      List userList = await usrs.toList();

      expect(userList.length, equals(3));
      expect(userList[2]['id'], equals(1));
      expect(userList[0]['id'], equals(3));

      expect(userList[2]['name'], equals('Jane Doe'));
      expect(userList[0]['name'], equals('Firstname Last'));
    });

    test("should get records between keys with open left bound", () async {
      Cursor usrs = await r
          .table(tableName)
          .between(1, 3, {'left_bound': 'open'}).run(connection);
      expect(usrs is Cursor, equals(true));
      List userList = await usrs.toList();

      expect(userList.length, equals(1));
      expect(userList[0]['id'], equals(2));

      expect(userList[0]['name'], equals('Jon Doe'));
    });

    test("should get records with a value less than minval", () async {
      Cursor usrs =
          await r.table(tableName).between(r.minval, 2).run(connection);

      expect(usrs is Cursor, equals(true));
      List userList = await usrs.toList();

      expect(userList.length, equals(1));
      expect(userList[0]['id'], equals(1));

      expect(userList[0]['name'], equals('Jane Doe'));
    });

    test("should get records with a value greater than maxval", () async {
      Cursor usrs =
          await r.table(tableName).between(2, r.maxval).run(connection);

      expect(usrs is Cursor, equals(true));
      List userList = await usrs.toList();

      expect(userList.length, equals(2));
      expect(userList[0]['id'], equals(3));

      expect(userList[0]['name'], equals('Firstname Last'));
    });
  });

  group("filter command -> ", () {
    test("should filter by field", () async {
      Cursor users =
          await r.table(tableName).filter({'name': 'Jane Doe'}).run(connection);

      expect(users is Cursor, equals(true));
      List userList = await users.toList();

      expect(userList.length, equals(1));
      expect(userList[0]['id'], equals(1));
      expect(userList[0]['name'], equals('Jane Doe'));
    });

    test("should filter with r.row", () async {
      Cursor users = await r
          .table(tableName)
          .filter(r.row('name').match("Doe"))
          .run(connection);

      expect(users is Cursor, equals(true));
      List userList = await users.toList();

      expect(userList.length, equals(2));
      expect(userList[0]['id'], equals(2));
      expect(userList[0]['name'], equals('Jon Doe'));
    });

    test("should filter with a function", () async {
      Cursor users = await r.table(tableName).filter((user) {
        return user('name').eq("Jon Doe").or(user('name').eq("Firstname Last"));
      }).run(connection);

      expect(users is Cursor, equals(true));
      List userList = await users.toList();

      expect(userList.length, equals(2));
      expect(userList[0]['id'], equals(3));
      expect(userList[0]['name'], equals('Firstname Last'));
    });
  });

  test("remove the test database", () async {
    Map response = await r.dbDrop(testDbName).run(connection);

    expect(response.containsKey('config_changes'), equals(true));
    expect(response['dbs_dropped'], equals(1));
  });
}
