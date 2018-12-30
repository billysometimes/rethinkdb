import 'package:test/test.dart';
import '../lib/rethinkdb_dart.dart';
import 'dart:async';

main() {
  Rethinkdb r = Rethinkdb();
  String tableName = null;
  String testDbName = null;
  bool shouldDropTable = false;
  Connection connection;

  _setUpTable() async {
    return await r.table(tableName).insert([
      {
        'id': 1,
        'name': 'Jane Doe',
        'children': [
          {'id': 1, 'name': 'Robert'},
          {'id': 2, 'name': 'Mariah'}
        ]
      },
      {
        'id': 2,
        'name': 'Jon Doe',
        'children': [
          {'id': 1, 'name': 'Louis'}
        ],
        'nickname': 'Jo'
      },
      {'id': 3, 'name': 'Firstname Last'}
    ]).run(connection);
  }

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
    await _setUpTable();
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

  group("contains command -> ", () {
    test("should check if the table contains an existing child", () async {
      var result = await r.table(tableName).get(1)('children')
          .contains({'id': 1, 'name': 'Robert'}).run(connection);
      expect(result, equals(true));
    });
    test("should check if the table contains an non existing child", () async {
      var result = await r.table(tableName).get(1)('children')
          .contains({'id': 1, 'name': 'Robert 1'}).run(connection);
      expect(result, equals(false));
    });
    // TODO: add more tests.
  });

  group("hasFields command -> ", () {
    test("should use hasFields and return the people who have children",
        () async {
      Cursor parents =
          await r.table(tableName).hasFields('children').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(2));

      expect(parentsList[1]['id'], equals(1));
      expect(parentsList[0]['id'], equals(2));

      expect(parentsList[1]['name'], equals('Jane Doe'));
      expect(parentsList[0]['name'], equals('Jon Doe'));
    });
    test(
        "should use hasFields and return the people who have children and a nickname",
        () async {
      Cursor parentsWithNickname = await r
          .table(tableName)
          .hasFields('children', 'nickname')
          .run(connection);
      expect(parentsWithNickname is Cursor, equals(true));
      List parentsWithNicknameList = await parentsWithNickname.toList();

      expect(parentsWithNicknameList.length, equals(1));

      expect(parentsWithNicknameList[0]['id'], equals(2));

      expect(parentsWithNicknameList[0]['name'], equals('Jon Doe'));
    });
    // TODO: add more tests.
  });

  group("withFields command -> ", () {
    test(
        "should use withFields and return the children of the people who have them",
        () async {
      Cursor parents =
          await r.table(tableName).withFields('children').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(2));

      expect(
          parentsList[1]['children'],
          equals([
            {'id': 1, 'name': 'Robert'},
            {'id': 2, 'name': 'Mariah'}
          ]));
      expect(
          parentsList[0]['children'],
          equals([
            {'id': 1, 'name': 'Louis'}
          ]));
    });
    test(
        "should use withFields and return the children and the nickname of the people who have them",
        () async {
      Cursor parentsWithNickname = await r
          .table(tableName)
          .withFields('children', 'nickname')
          .run(connection);
      expect(parentsWithNickname is Cursor, equals(true));
      List parentsWithNicknameList = await parentsWithNickname.toList();

      expect(parentsWithNicknameList.length, equals(1));

      expect(
          parentsWithNicknameList[0]['children'],
          equals([
            {'id': 1, 'name': 'Louis'}
          ]));

      expect(parentsWithNicknameList[0]['nickname'], equals('Jo'));
    });
  });

  group("keys command -> ", () {
    test("should return the keys from the person with id equal to 1", () async {
      var personKeys = await r.table(tableName).get(1).keys().run(connection);
      expect(personKeys is List, equals(true));

      expect(personKeys.length, equals(3));

      expect(personKeys[0], equals("children"));
      expect(personKeys[1], equals("id"));
      expect(personKeys[2], equals("name"));
    });
  });

  group("values command -> ", () {
    test("should return the values from the person with id equal to 1",
        () async {
      var personValues =
          await r.table(tableName).get(1).values().run(connection);
      expect(personValues is List, equals(true));

      expect(personValues.length, equals(3));

      expect(
          personValues[0],
          equals([
            {'id': 1, 'name': 'Robert'},
            {'id': 2, 'name': 'Mariah'}
          ]));
      expect(personValues[1], equals(1));
      expect(personValues[2], equals('Jane Doe'));
    });
  });

  group("changes command -> ", () {
    test("should return the changes from the person that is updated", () async {
      Feed feed =
          await r.table(tableName).changes().run(connection).asStream().first;
      Timer(Duration(seconds: 1), () async {
        var result = await r
            .table(tableName)
            .get(1)
            .update({'name': "Marcelo Neppel"}).run(connection);
        print("result: $result");
      });
      dynamic feedData = await feed.first;
      expect(
          feedData,
          equals({
            'new_val': {
              'children': [
                {'id': 1, 'name': 'Robert'},
                {'id': 2, 'name': 'Mariah'}
              ],
              'id': 1,
              'name': 'Marcelo Neppel'
            },
            'old_val': {
              'children': [
                {'id': 1, 'name': 'Robert'},
                {'id': 2, 'name': 'Mariah'}
              ],
              'id': 1,
              'name': 'Jane Doe'
            }
          }));
    });
  });
}
