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

  group("circle command -> ", () {
    int long = -90;
    int lat = 0;
    int rad = 5;
    test(
        "should create a polygon given an array containing longitude and latitude and also a radius",
        () {
      r
          .circle([long, lat], rad)
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response.containsKey('coordinates'), equals(true));
            expect(response.containsKey('type'), equals(true));
            expect(response['type'], equals('Polygon'));
          }));
    });
    test("should create a polygon given a point and also a radius", () {
      Point p = r.point(long, lat);
      r.circle(p, rad).run(connection).then(expectAsync((Map response) {
        expect(response.containsKey('coordinates'), equals(true));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('Polygon'));
      }));
    });
    test("should create a polygon with a specified number of vertices", () {
      Point p = r.point(long, lat);

      r
          .circle(p, rad, {'num_vertices': 4})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response.containsKey('coordinates'), equals(true));
            expect(response['coordinates'][0].length, equals(5));
            expect(response.containsKey('type'), equals(true));
            expect(response['type'], equals('Polygon'));
          }));
    });

    test("should create a polygon with a specified geo_system", () {
      rad = 1;
      Point p = r.point(long, lat);

      r
          .circle(p, rad, {'geo_system': 'unit_sphere'})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response.containsKey('coordinates'), equals(true));
            expect(response.containsKey('type'), equals(true));
            expect(response['type'], equals('Polygon'));
          }));
    });

    test("should create a polygon with a specified unit", () {
      rad = 1;
      Point p = r.point(long, lat);

      r
          .circle(p, rad, {'num_vertices': 3, 'unit': 'nm'})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response.containsKey('coordinates'), equals(true));
            expect(response.containsKey('type'), equals(true));
            expect(response['type'], equals('Polygon'));
          }));
    });

    test("should create an unfilled line", () {
      Point p = r.point(long, lat);

      r
          .circle(p, rad, {'num_vertices': 4, 'fill': false})
          .run(connection)
          .then(expectAsync((Map response) {
            expect(response.containsKey('coordinates'), equals(true));
            expect(response.containsKey('type'), equals(true));
            expect(response['type'], equals('LineString'));
          }));
    });
  });

  Circle c = r.circle([-90, 0], 1);
  Point p = r.point(0, -90);
  group("distance command -> ", () {
    test("should compute the distance between a point and a polygon", () {
      r.distance(p, c).run(connection).then(expectAsync((num distance) {
        expect(distance, equals(10001964.729312724));
      }));
    });

    test("should compute the distance for a given geo_system", () {
      r
          .distance(p, c, {'geo_system': 'unit_sphere'})
          .run(connection)
          .then(expectAsync((num distance) {
            expect(distance, equals(1.5707961689526464));
          }));
    });

    test("should compute the distance for a given unit", () {
      r
          .distance(p, c, {'geo_system': 'unit_sphere', 'unit': 'ft'})
          .run(connection)
          .then(expectAsync((num distance) {
            expect(distance, equals(5.153530738033616));
          }));
    });
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

  group("toGeojson command -> ", () {
    test("should convert a reql geometry to a GeoJSON object", () {
      r.point(0, 0).toGeojson().run(connection).then(expectAsync((Map geo) {
        expect(geo.containsKey('coordinates'), equals(true));
        expect(geo['coordinates'], equals([0, 0]));
        expect(geo.containsKey('type'), equals(true));
        expect(geo['type'], equals('Point'));
      }));
    });
  });

  group("includes command -> ", () {
    test("should return true if a geometry includes some other geometry", () {
      Point point1 = r.point(-117.220406, 32.719464);
      Point point2 = r.point(-117.206201, 32.725186);
      r
          .circle(point1, 2000)
          .includes(point2)
          .run(connection)
          .then(expectAsync((bool doesInclude) {
        expect(doesInclude, equals(true));
      }));
    });

    test(
        "should return false if a geometry does not include some other geometry",
        () {
      Point point1 = r.point(-0, 0);
      Point point2 = r.point(-100, 90);
      r
          .circle(point1, 1)
          .includes(point2)
          .run(connection)
          .then(expectAsync((bool doesInclude) {
        expect(doesInclude, equals(false));
      }));
    });

    test(
        "should filter a sequence to only contain items that include some other geometry",
        () {
      Point point1 = r.point(-0, 0);
      Point point2 = r.point(-1, 1);
      Point point3 = r.point(-99, 90);
      Point point4 = r.point(101, 90);
      Point point5 = r.point(-100, 90);
      r
          .expr([
            r.circle(point1, 2),
            r.circle(point2, 2),
            r.circle(point3, 2),
            r.circle(point4, 2)
          ])
          .includes(point5)
          .run(connection)
          .then(expectAsync((List included) {
            expect(included.length == 2, equals(true));
          }))
          .catchError((err) => print(err.message));
    });
  });

  group("intersects command -> ", () {
    test("should return true if a geometry intersects some other geometry", () {
      Point point1 = r.point(-117.220406, 32.719464);
      Line line = r.line(r.point(-117.206201, 32.725186), r.point(0, 1));
      r
          .circle(point1, 2000)
          .intersects(line)
          .run(connection)
          .then(expectAsync((bool doesIntersect) {
        expect(doesIntersect, equals(true));
      }));
    });

    test(
        "should return false if a geometry does not intersect some other geometry",
        () {
      Point point1 = r.point(-117.220406, 32.719464);
      Line line = r.line(r.point(20, 20), r.point(0, 1));
      r
          .circle(point1, 1)
          .intersects(line)
          .run(connection)
          .then(expectAsync((bool doesIntersect) {
        expect(doesIntersect, equals(false));
      }));
    });

    test(
        "should filter a sequence to only contain items that intersect some other geometry",
        () {
      var point1 = r.point(0, 0);
      var point2 = r.point(33, 30);
      var point3 = r.point(-17, 3);
      var point4 = r.point(20, 20);
      var point5 = r.point(-100, 90);
      Line line = r.line(point1, point2);
      r
          .expr([point1, point2, point3, point4, point5])
          .intersects(line)
          .run(connection)
          .then(expectAsync((List intersecting) {
            expect(intersecting.length == 2, equals(true));
          }))
          .catchError((err) => print(err.message));
    });
  });

  group("line command -> ", () {
    test("should create a line from two long/lat arrays", () {
      r.line([0, 0], [-20, -90]).run(connection).then(expectAsync((Map line) {
            expect(line.containsKey('coordinates'), equals(true));
            expect(
                line['coordinates'],
                equals([
                  [0, 0],
                  [-20, -90]
                ]));
            expect(line.containsKey('type'), equals(true));
            expect(line['type'], equals('LineString'));
          }));
    });
    test("should create a line from many long/lat arrays", () {
      r
          .line([0, 0], [-20, -90], [3, 3])
          .run(connection)
          .then(expectAsync((Map line) {
            expect(line.containsKey('coordinates'), equals(true));
            expect(
                line['coordinates'],
                equals([
                  [0, 0],
                  [-20, -90],
                  [3, 3]
                ]));
            expect(line.containsKey('type'), equals(true));
            expect(line['type'], equals('LineString'));
          }));
    });
    test("should create a line from two points", () {
      r
          .line(r.point(0, 0), r.point(-20, -90))
          .run(connection)
          .then(expectAsync((Map line) {
        expect(line.containsKey('coordinates'), equals(true));
        expect(
            line['coordinates'],
            equals([
              [0, 0],
              [-20, -90]
            ]));
        expect(line.containsKey('type'), equals(true));
        expect(line['type'], equals('LineString'));
      }));
    });
    test("should create a line from many points", () {
      r
          .line(r.point(0, 0), r.point(-20, -90), r.point(3, 3))
          .run(connection)
          .then(expectAsync((Map line) {
        expect(line.containsKey('coordinates'), equals(true));
        expect(
            line['coordinates'],
            equals([
              [0, 0],
              [-20, -90],
              [3, 3]
            ]));
        expect(line.containsKey('type'), equals(true));
        expect(line['type'], equals('LineString'));
      }));
    });
    test("should create a line from a combination of arrays and points", () {
      r
          .line(r.point(0, 0), [-20, -90], r.point(3, 3))
          .run(connection)
          .then(expectAsync((Map line) {
        expect(line.containsKey('coordinates'), equals(true));
        expect(
            line['coordinates'],
            equals([
              [0, 0],
              [-20, -90],
              [3, 3]
            ]));
        expect(line.containsKey('type'), equals(true));
        expect(line['type'], equals('LineString'));
      }));
    });
    test("should be able to fill() to create a polygon from a line", () {
      r
          .line(r.point(0, 0), [-20, -90], r.point(3, 3))
          .fill()
          .run(connection)
          .then(expectAsync((Map line) {
        expect(line.containsKey('coordinates'), equals(true));
        expect(
            line['coordinates'],
            equals([
              [
                [0, 0],
                [-20, -90],
                [3, 3],
                [0, 0]
              ]
            ]));
        expect(line.containsKey('type'), equals(true));
        expect(line['type'], equals('Polygon'));
      }));
    });
  });
  test("point command -> should create a point given a longitude and latitude",
      () {
    r.point(90, 90).run(connection).then(expectAsync((Map point) {
      expect(point.containsKey('coordinates'), equals(true));
      expect(point['coordinates'], equals([90, 90]));
      expect(point.containsKey('type'), equals(true));
      expect(point['type'], equals('Point'));
    }));
  });

  group("polygon command -> ", () {
    test("should create a polygon given three long/lat arrays", () {
      r
          .polygon([0, 0], [40, 40], [20, 0])
          .run(connection)
          .then(expectAsync((Map poly) {
            expect(poly.containsKey('coordinates'), equals(true));
            expect(poly['coordinates'][0].length, equals(4));
            expect(poly.containsKey('type'), equals(true));
            expect(poly['type'], equals('Polygon'));
          }));
    });
    test("should create a polygon given many long/lat arrays", () {
      r
          .polygon([0, 0], [40, 40], [20, 0], [50, -10], [-90, 80])
          .run(connection)
          .then(expectAsync((Map poly) {
            expect(poly.containsKey('coordinates'), equals(true));
            expect(poly['coordinates'][0].length, equals(6));
            expect(poly.containsKey('type'), equals(true));
            expect(poly['type'], equals('Polygon'));
          }));
    });
    Point point1 = r.point(0, 0);
    Point point2 = r.point(40, 0);
    Point point3 = r.point(40, 40);
    Point point4 = r.point(20, 50);
    Point point5 = r.point(0, 40);
    test("should create a polygon given three points", () {
      r
          .polygon(point1, point2, point3)
          .run(connection)
          .then(expectAsync((Map poly) {
        expect(poly.containsKey('coordinates'), equals(true));
        expect(poly['coordinates'][0].length, equals(4));
        expect(poly.containsKey('type'), equals(true));
        expect(poly['type'], equals('Polygon'));
      }));
    });
    test("should create a polygon given many points", () {
      r
          .polygon(point1, point2, point3, point4, point5)
          .run(connection)
          .then(expectAsync((Map poly) {
        expect(poly.containsKey('coordinates'), equals(true));
        expect(poly['coordinates'][0].length, equals(6));
        expect(poly.containsKey('type'), equals(true));
        expect(poly['type'], equals('Polygon'));
      }));
    });
    test("should allow a subPolygon to be removed from a polygon", () {
      r
          .polygon(point1, point2, point3, point4, point5)
          .polygonSub(r.circle(r.point(20, 20), 1))
          .run(connection)
          .then(expectAsync((Map poly) {
        expect(poly.containsKey('coordinates'), equals(true));
        expect(poly['coordinates'][0].length, equals(6));
        expect(poly.containsKey('type'), equals(true));
        expect(poly['type'], equals('Polygon'));
      }));
    });
  });

  test(
      "getIntersecting command -> should return a cursor containing all intersecting records of a table",
      () async {
    List insertedData = [
      {
        'location': r.polygon(
            r.point(0, 0), r.point(40, 0), r.point(40, 40), r.point(0, 40)),
        'name': 'a'
      },
      {
        'location': r.polygon(
            r.point(40, 0), r.point(80, 0), r.point(80, 40), r.point(40, 40)),
        'name': 'a'
      },
      {
        'location': r.polygon(
            r.point(40, 40), r.point(80, 40), r.point(80, 80), r.point(40, 80)),
        'name': 'a'
      }
    ];

    try {
      await r.tableCreate(tableName).run(connection);
      await r
          .table(tableName)
          .indexCreate('location', {'geo': true}).run(connection);
      await r.table(tableName).indexWait('location').run(connection);
      await r.table(tableName).insert(insertedData).run(connection);
      Cursor intersecting = await r.table(tableName).getIntersecting(
          r.circle(r.point(40, 20), 1), {'index': 'location'}).run(connection);
      intersecting.toList().then(expectAsync((List v) {
        expect(v.length, equals(2));
      }));
    } catch (err) {
      print(err.message);
    }
  });
  group("getNearest command -> ", () {
    test("should get a list of documents nearest a point", () {
      r
          .table(tableName)
          .getNearest(r.point(80.5, 20), {'index': 'location'})
          .run(connection)
          .then(expectAsync((List l) {
            expect(l is List, equals(true));
            expect(l.length, equals(1));
          }));
    });
  });

  test("remove the test database", () {
    r.dbDrop(testDbName).run(connection).then(expectAsync((Map response) {
      expect(response.containsKey('config_changes'), equals(true));
      expect(response['dbs_dropped'], equals(1));
      expect(response['tables_dropped'], equals(1));
    }));
  });
}
