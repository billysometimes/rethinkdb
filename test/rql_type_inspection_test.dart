import 'package:test/test.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

main() {
  Rethinkdb r = Rethinkdb();
  String tableName;
  String testDbName;
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

  // TODO: add coerceTo tests.
  // TODO: add ungroup tests.
  // TODO: add typeOf tests.

  group("merge command -> ", () {
    test("should merge person with id equal to 1 and person with id equal to 3",
        () async {
      var result = await r
          .table(tableName)
          .get(1)
          .merge(r.table(tableName).get(3))
          .run(connection);
      expect(result is Map, equals(true));

      expect(
          result,
          equals({
            'children': [
              {'id': 1, 'name': 'Robert'},
              {'id': 2, 'name': 'Mariah'}
            ],
            'id': 3,
            'name': 'Firstname Last'
          }));
    });
    test(
        "should merge person with id equal to 2 and person with id equal to 1 and person with id equal to 3",
        () async {
      var result = await r
          .table(tableName)
          .get(2)
          .merge(r.table(tableName).get(1))
          .merge(r.table(tableName).get(3))
          .run(connection);
      expect(result is Map, equals(true));

      expect(
          result,
          equals({
            'children': [
              {'id': 1, 'name': 'Robert'},
              {'id': 2, 'name': 'Mariah'}
            ],
            'id': 3,
            'name': 'Firstname Last',
            'nickname': 'Jo'
          }));
    });
    test(
        "should merge person with id equal to 2 and person with id equal to 1 and person with id equal to 3 together",
        () async {
      var result = await r
          .table(tableName)
          .get(2)
          .merge(r.table(tableName).get(1), r.table(tableName).get(3))
          .run(connection);
      expect(result is Map, equals(true));

      expect(
          result,
          equals({
            'children': [
              {'id': 1, 'name': 'Robert'},
              {'id': 2, 'name': 'Mariah'}
            ],
            'id': 3,
            'name': 'Firstname Last',
            'nickname': 'Jo'
          }));
    });
    // TODO: add tests with r.args.
  });

  // TODO: add append tests.
  // TODO: add floor tests.
  // TODO: add ceil tests.
  // TODO: add round tests.
  // TODO: add prepend tests.
  // TODO: add difference tests.
  // TODO: add setInsert tests.
  // TODO: add setUnion tests.
  // TODO: add setIntersection tests.
  // TODO: add setDifference tests.
  // TODO: add getField tests.
  // TODO: add nth tests.
  // TODO: add match tests.
  // TODO: add split tests.
  // TODO: add upcase tests.
  // TODO: add downcase tests.
  // TODO: add isEmpty tests.
  // TODO: add slice tests.
  // TODO: add fold tests.
  // TODO: add skip tests.
  // TODO: add limit tests.
  // TODO: add reduce tests.
  // TODO: add sum tests.
  // TODO: add avg tests.
  // TODO: add min tests.
  // TODO: add max tests.
  // TODO: add map tests.
  // TODO: add filter tests.
  // TODO: add concatMap tests.
  // TODO: add get tests.
  // TODO: add orderBy tests.
  // TODO: add between tests.
  // TODO: add distinct tests.
  // TODO: add count tests.

  group("union command -> ", () {
    test("should union people with one new person", () async {
      var result = await r.table(tableName).union({
        'id': 4,
        'name': 'Additional 1',
        'hobbies': ["swim"]
      }).run(connection);
      expect(result is Cursor, equals(true));
      List peopleList = await result.toList();

      expect(peopleList.length, equals(4));

      expect(
          peopleList,
          equals([
            {
              'hobbies': ['swim'],
              'id': 4,
              'name': 'Additional 1'
            },
            {'id': 3, 'name': 'Firstname Last'},
            {
              'children': [
                {'id': 1, 'name': 'Louis'}
              ],
              'id': 2,
              'name': 'Jon Doe',
              'nickname': 'Jo'
            },
            {
              'children': [
                {'id': 1, 'name': 'Robert'},
                {'id': 2, 'name': 'Mariah'}
              ],
              'id': 1,
              'name': 'Jane Doe'
            }
          ]));
    });
    test("should union people with two new people", () async {
      var result = await r.table(tableName).union({
        'id': 4,
        'name': 'Additional 1',
        'hobbies': ["swim"]
      }).union({'id': 5, 'name': 'Additional 2', 'wife': 'Judith'}).run(
          connection);
      expect(result is Cursor, equals(true));
      List peopleList = await result.toList();

      expect(peopleList.length, equals(5));

      expect(
          peopleList,
          equals([
            {'id': 5, 'name': 'Additional 2', 'wife': 'Judith'},
            {
              'hobbies': ['swim'],
              'id': 4,
              'name': 'Additional 1'
            },
            {'id': 3, 'name': 'Firstname Last'},
            {
              'children': [
                {'id': 1, 'name': 'Louis'}
              ],
              'id': 2,
              'name': 'Jon Doe',
              'nickname': 'Jo'
            },
            {
              'children': [
                {'id': 1, 'name': 'Robert'},
                {'id': 2, 'name': 'Mariah'}
              ],
              'id': 1,
              'name': 'Jane Doe'
            }
          ]));
    });
    test("should union people with two new people together", () async {
      var result = await r.table(tableName).union({
        'id': 4,
        'name': 'Additional 1',
        'hobbies': ["swim"]
      }, {
        'id': 5,
        'name': 'Additional 2',
        'wife': 'Judith'
      }).run(connection);
      expect(result is Cursor, equals(true));
      List peopleList = await result.toList();

      expect(peopleList.length, equals(5));

      expect(
          peopleList,
          equals([
            {
              'hobbies': ['swim'],
              'id': 4,
              'name': 'Additional 1'
            },
            {'id': 5, 'name': 'Additional 2', 'wife': 'Judith'},
            {'id': 3, 'name': 'Firstname Last'},
            {
              'children': [
                {'id': 1, 'name': 'Louis'}
              ],
              'id': 2,
              'name': 'Jon Doe',
              'nickname': 'Jo'
            },
            {
              'children': [
                {'id': 1, 'name': 'Robert'},
                {'id': 2, 'name': 'Mariah'}
              ],
              'id': 1,
              'name': 'Jane Doe'
            }
          ]));
    });
    // TODO: add tests with r.args.
    // TODO: add tests with interleave.
  });

  // TODO: add innerJoin tests.
  // TODO: add outerJoin tests.
  // TODO: add eqJoin tests.
  // TODO: add zip tests.

  group("group command -> ", () {
    var groupCommandData = [
      {'id': 2, 'player': "Bob", 'points': 15, 'type': "ranked"},
      {'id': 5, 'player': "Alice", 'points': 7, 'type': "free"},
      {'id': 11, 'player': "Bob", 'points': 10, 'type': "free"},
      {'id': 12, 'player': "Alice", 'points': 2, 'type': "free"}
    ];
    test("should group by player", () async {
      var result =
          await r.expr(groupCommandData).group('player').run(connection);
      expect(result is Map, equals(true));

      expect(result.length, equals(2));

      expect(
          result,
          equals({
            'Alice': [
              {'id': 5, 'player': 'Alice', 'points': 7, 'type': 'free'},
              {'id': 12, 'player': 'Alice', 'points': 2, 'type': 'free'}
            ],
            'Bob': [
              {'id': 2, 'player': 'Bob', 'points': 15, 'type': 'ranked'},
              {'id': 11, 'player': 'Bob', 'points': 10, 'type': 'free'}
            ]
          }));
    });
    test("should group by player and type together", () async {
      var result = await r
          .expr(groupCommandData)
          .group('player', 'type')
          .run(connection);
      expect(result is Map, equals(true));

      expect(result.length, equals(3));

      result.forEach((key, value) {
        expect(key is List, equals(true));
        expect(key.length, equals(2));
        switch (key[0]) {
          case 'Alice':
            expect(key[1], 'free');
            expect(
                value,
                equals([
                  {'id': 5, 'player': 'Alice', 'points': 7, 'type': 'free'},
                  {'id': 12, 'player': 'Alice', 'points': 2, 'type': 'free'}
                ]));
            break;
          case 'Bob':
            switch (key[1]) {
              case 'free':
                expect(
                    value,
                    equals([
                      {'id': 11, 'player': 'Bob', 'points': 10, 'type': 'free'}
                    ]));
                break;
              case 'ranked':
                expect(
                    value,
                    equals([
                      {'id': 2, 'player': 'Bob', 'points': 15, 'type': 'ranked'}
                    ]));
                break;
              default:
                fail('invalid key');
                break;
            }
            break;
          default:
            fail('invalid key');
            break;
        }
      });
    });
    // TODO: add tests with r.args.
    // TODO: add tests with index.
    // TODO: add tests with multi.
  });

  // TODO: add forEach tests.
  // TODO: add info tests.
}
