import 'package:test/test.dart';
import '../lib/rethinkdb_dart.dart';

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

  group("pluck command -> ", () {
    test(
        "should use pluck and return the children of the person with the id equal to 1",
        () async {
      var parent =
          await r.table(tableName).get(1).pluck('children').run(connection);
      expect(parent is Map, equals(true));

      expect(
          parent['children'],
          equals([
            {'id': 1, 'name': 'Robert'},
            {'id': 2, 'name': 'Mariah'}
          ]));
    });
    test(
        "should use pluck and return the children and the name of the person with the id equal to 1",
        () async {
      var parent = await r
          .table(tableName)
          .get(1)
          .pluck('children', 'name')
          .run(connection);
      expect(parent is Map, equals(true));

      expect(
          parent,
          equals({
            'children': [
              {'id': 1, 'name': 'Robert'},
              {'id': 2, 'name': 'Mariah'}
            ],
            'name': 'Jane Doe'
          }));
    });
    test("should use pluck and return the children of the people", () async {
      Cursor parents =
          await r.table(tableName).pluck('children').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(
          parentsList[2]['children'],
          equals([
            {'id': 1, 'name': 'Robert'},
            {'id': 2, 'name': 'Mariah'}
          ]));
      expect(
          parentsList[1]['children'],
          equals([
            {'id': 1, 'name': 'Louis'}
          ]));
      expect(parentsList[0]['children'], equals(null));
    });
    test("should use pluck and return the children and the name of the people",
        () async {
      Cursor parents =
          await r.table(tableName).pluck('children', 'name').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(
          parentsList[2],
          equals({
            'children': [
              {'id': 1, 'name': 'Robert'},
              {'id': 2, 'name': 'Mariah'}
            ],
            'name': 'Jane Doe'
          }));
      expect(
          parentsList[1],
          equals({
            'children': [
              {'id': 1, 'name': 'Louis'}
            ],
            'name': 'Jon Doe'
          }));
      expect(parentsList[0], equals({'name': 'Firstname Last'}));
    });
    // TODO: add the nested objects test (without the shorthand).
    test(
        "should use pluck with the shorthand and return the children of the people who has child/children with id and name",
        () async {
      Cursor parents = await r.table(tableName).pluck({
        'children': ['id', 'name']
      }).run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(
          parentsList[2]['children'],
          equals([
            {'id': 1, 'name': 'Robert'},
            {'id': 2, 'name': 'Mariah'}
          ]));
      expect(
          parentsList[1]['children'],
          equals([
            {'id': 1, 'name': 'Louis'}
          ]));
      expect(parentsList[0]['children'], equals(null));
    });
    test(
        "should use pluck with the shorthand and return the children and the name of the people who has child/children with id and name",
        () async {
      Cursor parents = await r.table(tableName).pluck({
        'children': ['id', 'name']
      }, 'name').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(
          parentsList[2],
          equals({
            'children': [
              {'id': 1, 'name': 'Robert'},
              {'id': 2, 'name': 'Mariah'}
            ],
            'name': 'Jane Doe'
          }));
      expect(
          parentsList[1],
          equals({
            'children': [
              {'id': 1, 'name': 'Louis'}
            ],
            'name': 'Jon Doe'
          }));
      expect(parentsList[0], equals({'name': 'Firstname Last'}));
    });
    // TODO: add tests with r.args.
  });

  group("without command -> ", () {
    test(
        "should use without and return the person with the id equal to 1 without the children data",
        () async {
      var parent =
          await r.table(tableName).get(1).without('children').run(connection);
      expect(parent is Map, equals(true));

      expect(parent, equals({'id': 1, 'name': 'Jane Doe'}));
    });
    test(
        "should use without and return the person with the id equal to 1 without the children data and the name",
        () async {
      var parent = await r
          .table(tableName)
          .get(1)
          .without('children', 'name')
          .run(connection);
      expect(parent is Map, equals(true));

      expect(parent, equals({'id': 1}));
    });
    test("should use without and return the people without the children data",
        () async {
      Cursor parents =
          await r.table(tableName).without('children').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(parentsList[2], equals({'id': 1, 'name': 'Jane Doe'}));
      expect(parentsList[1],
          equals({'id': 2, 'name': 'Jon Doe', 'nickname': 'Jo'}));
      expect(parentsList[0], equals({'id': 3, 'name': 'Firstname Last'}));
    });
    test(
        "should use without and return the people without the children data and the name",
        () async {
      Cursor parents =
          await r.table(tableName).without('children', 'name').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(parentsList[2], equals({'id': 1}));
      expect(parentsList[1], equals({'id': 2, 'nickname': 'Jo'}));
      expect(parentsList[0], equals({'id': 3}));
    });
    // TODO: add the nested objects test (without the shorthand).
    test(
        "should use without with the shorthand and return the people who has child/children with id and name, but without them",
        () async {
      Cursor parents = await r.table(tableName).without({
        'children': ['id', 'name']
      }).run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(
          parentsList[2],
          equals({
            'children': [{}, {}],
            'id': 1,
            'name': 'Jane Doe'
          }));
      expect(
          parentsList[1],
          equals({
            'children': [{}],
            'id': 2,
            'name': 'Jon Doe',
            'nickname': 'Jo'
          }));
      expect(parentsList[0], equals({'id': 3, 'name': 'Firstname Last'}));
    });
    test(
        "should use without with the shorthand and return the people who has child/children with id and name, but without them and the person name",
        () async {
      Cursor parents = await r.table(tableName).without({
        'children': ['id', 'name']
      }, 'name').run(connection);
      expect(parents is Cursor, equals(true));
      List parentsList = await parents.toList();

      expect(parentsList.length, equals(3));

      expect(
          parentsList[2],
          equals({
            'children': [{}, {}],
            'id': 1
          }));
      expect(
          parentsList[1],
          equals({
            'children': [{}],
            'id': 2,
            'nickname': 'Jo'
          }));
      expect(parentsList[0], equals({'id': 3}));
    });
    // TODO: add tests with r.args.
  });

  // TODO: add rqlDo tests.
  // TODO: add rqlDefault tests.
  // TODO: add replace tests.
  // TODO: add delete tests.
}
