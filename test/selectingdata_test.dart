import 'package:test/test.dart';
import '../lib/rethinkdb_driver.dart';

main() {
  Rethinkdb r = new Rethinkdb();

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
    connection.use(testDbName);

    if (tableName == null) {
      String tblName = await r.uuid().run(connection);
      tableName = "test_table_" + tblName.replaceAll("-", "");
      await r.tableCreate(tableName).run(connection);
    }
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

  _setUpTable(){
    return r.table(tableName)
     .insert([{'id':1, 'name':'Jane Doe'},
             {'id':2, 'name':'Jon Doe'}, {'id':3, 'name':'Firstname Last'}])
     .run(connection);
  }

  group("get command -> ", () {
    test("should get a record by primary key", () async{
      await _setUpTable();
      r.table(tableName).get(1).run(connection).then(expectAsync((usr){
        expect(usr['id'], equals(1));
        expect(usr['name'], equals('Jane Doe'));
      }));
    });
  });

  group("getAll command -> ", () {
    test("should get records by primary keys", () async{

      r.table(tableName).getAll(1, 3).run(connection)
      .then((usrs){
        expect(usrs is Cursor, equals(true));
        return usrs.toList();
      })
      .then(expectAsync((userList){
        expect(userList[1]['id'], equals(1));
        expect(userList[0]['id'], equals(3));

        expect(userList[1]['name'], equals('Jane Doe'));
        expect(userList[0]['name'], equals('Firstname Last'));
      }));
    });
  });

  group("between command -> ", () {
    test("should get records between keys defaulting to closed left bound",
      (){

      r.table(tableName).between(1, 3).run(connection)
      .then((usrs){
        expect(usrs is Cursor, equals(true));
        return usrs.toList();
      })
      .then(expectAsync((userList){

        expect(userList.length, equals(2));

        expect(userList[1]['id'], equals(1));
        expect(userList[0]['id'], equals(2));

        expect(userList[1]['name'], equals('Jane Doe'));
        expect(userList[0]['name'], equals('Jon Doe'));
      }));
    });

    test("should get records between keys with closed right bound", () async{

      r.table(tableName).between(1, 3, {'right_bound':'closed'}).run(connection)
      .then((usrs){
        expect(usrs is Cursor, equals(true));
        return usrs.toList();
      })
      .then(expectAsync((userList){
        expect(userList.length, equals(3));
        expect(userList[2]['id'], equals(1));
        expect(userList[0]['id'], equals(3));

        expect(userList[2]['name'], equals('Jane Doe'));
        expect(userList[0]['name'], equals('Firstname Last'));
      }));
    });

    test("should get records between keys with open left bound", () async{

      r.table(tableName).between(1, 3, {'left_bound':'open'}).run(connection)
      .then((usrs){
        expect(usrs is Cursor, equals(true));
        return usrs.toList();
      })
      .then(expectAsync((userList){
        expect(userList.length, equals(1));
        expect(userList[0]['id'], equals(2));

        expect(userList[0]['name'], equals('Jon Doe'));

      }));
    });

    test("should get records with a value less than minval", () async{

      r.table(tableName).between(r.minval, 2).run(connection)
      .then((usrs){
        expect(usrs is Cursor, equals(true));
        return usrs.toList();
      })
      .then(expectAsync((userList){

        expect(userList.length, equals(1));
        expect(userList[0]['id'], equals(1));

        expect(userList[0]['name'], equals('Jane Doe'));

      }));
    });

    test("should get records with a value greater than maxval", () async{

      r.table(tableName).between(2, r.maxval).run(connection)
      .then((usrs){
        expect(usrs is Cursor, equals(true));
        return usrs.toList();
      })
      .then(expectAsync((userList){

        expect(userList.length, equals(2));
        expect(userList[0]['id'], equals(3));

        expect(userList[0]['name'], equals('Firstname Last'));
      }));
    });
  });

  group("filter command -> ", () {
    test("should filter by field", (){
      r.table(tableName).filter({'name':'Jane Doe'})
      .run(connection)
      .then((users){
        expect(users is Cursor, equals(true));
        return users.toList();
      })
      .then(expectAsync((userList){
        expect(userList.length, equals(1));
        expect(userList[0]['id'], equals(1));
        expect(userList[0]['name'], equals('Jane Doe'));
      }));
    });

    test("should filter with r.row", (){
      r.table(tableName).filter(r.row('name').match("Doe"))
      .run(connection)
      .then((users){
        expect(users is Cursor, equals(true));
        return users.toList();
      })
      .then(expectAsync((userList){
        expect(userList.length, equals(2));
        expect(userList[0]['id'], equals(2));
        expect(userList[0]['name'], equals('Jon Doe'));
      }));
    });

    test("should filter with a function", (){
      r.table(tableName).filter((user){
        return user('name').eq("Jon Doe")
                 .or(user('name').eq("Firstname Last"));
      })
      .run(connection)
      .then((users){
        expect(users is Cursor, equals(true));
        return users.toList();
      })
      .then(expectAsync((userList){
        expect(userList.length, equals(2));
        expect(userList[0]['id'], equals(3));
        expect(userList[0]['name'], equals('Firstname Last'));
      }));
    });
  });
  test("remove the test database", () {
    r.dbDrop(testDbName).run(connection).then(expectAsync((Map response) {
      expect(response.containsKey('config_changes'), equals(true));
      expect(response['dbs_dropped'], equals(1));
    }));
  });
}
