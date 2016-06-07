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
    });
  });

  tearDown(() {
      connection.close();
  });
  group("circle command -> ",(){
    test("should create a polygon given an array containing longitude and latitude and also a radius",(){
      int long = -90;
      int lat = 0;
      int rad = 5;
      r.circle([long,lat],rad).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('Polygon'));
      }));
    });
    test("should create a polygon given a point and also a radius",(){
      int long = -90;
      int lat = 0;
      int rad = 5;
      Point p = r.point(long, lat);
      r.circle(p,rad).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('Polygon'));
      }));
    });
    test("should create a polygon with a specified number of vertices",(){
      int long = -90;
      int lat = 0;
      int rad = 5;
      Point p = r.point(long, lat);

      r.circle(p,rad, {'num_vertices':4}).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response['coordinates'][0].length, equals(5));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('Polygon'));
      }));
    });

    test("should create a polygon with a specified geo_system",(){
      int long = -90;
      int lat = 0;
      int rad = 1;
      Point p = r.point(long, lat);

      r.circle(p,rad, {'geo_system':'unit_sphere'}).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('Polygon'));
      }));
    });

    test("should create a polygon with a specified unit",(){
      int long = -90;
      int lat = 0;
      int rad = 1;
      Point p = r.point(long, lat);

      r.circle(p,rad, {'num_vertices':3,'unit':'nm'}).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('Polygon'));
      }));
    });

    test("should create an unfilled line", (){
      int long = -90;
      int lat = 0;
      int rad = 5;
      Point p = r.point(long, lat);

      r.circle(p,rad, {'num_vertices':4,'fill':false}).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('LineString'));
      }));
    });
  });

  group("distance command -> ",(){
    test("should compute the distance between a point and a polygon",(){
      Circle c = r.circle([-90,0],1);
      Point p = r.point(0,-90);

      r.distance(p,c).run(connection).then(expectAsync((num distance){
        expect(distance, equals(10001964.729312724));
      }));
    });

    test("should compute the distance for a given geo_system",(){
      Circle c = r.circle([-90,0],1);
      Point p = r.point(0,-90);

      r.distance(p,c,{'geo_system':'unit_sphere'}).run(connection).then(expectAsync((num distance){
        expect(distance, equals(1.5707961689526464));
      }));
    });

    test("should compute the distance for a given unit",(){
      Circle c = r.circle([-90,0],1);
      Point p = r.point(0,-90);

      r.distance(p,c,{'geo_system':'unit_sphere','unit':'ft'}).run(connection).then(expectAsync((num distance){
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

  group("toGeojson command -> ",(){
    test("should convert a reql geometry to a GeoJSON object",(){
      r.point(0,0).toGeojson().run(connection).then(expectAsync((Map geo){
        expect(geo.containsKey('coordinates'), equals(true));
        expect(geo['coordinates'], equals([0,0]));
        expect(geo.containsKey('type'),equals(true));
        expect(geo['type'],equals('Point'));
      }));
    });
  });

  group("includes command -> ",(){
    test("should return true if a geometry includes some other geometry",(){
      var point1 = r.point(-117.220406,32.719464);
      var point2 = r.point(-117.206201,32.725186);
      r.circle(point1, 2000).includes(point2).run(connection).then(expectAsync((bool doesInclude){
        expect(doesInclude, equals(true));
      }));
  });

  test("should return false if a geometry does not include some other geometry",(){
    var point1 = r.point(-0,0);
    var point2 = r.point(-100,90);
    r.circle(point1, 1).includes(point2).run(connection).then(expectAsync((bool doesInclude){
      expect(doesInclude, equals(false));
    }));
  });

  test("should filter a sequence to only contain items that include some other geometry",(){
    var point1 = r.point(-0,0);
    var point2 = r.point(-1,1);
    var point3 = r.point(-99,90);
    var point4 = r.point(101,90);
    var point5 = r.point(-100,90);
    r.expr([r.circle(point1, 2),r.circle(point2,2), r.circle(point3,2),r.circle(point4,2)]).includes(point5).run(connection).then(expectAsync((List included){
      expect(included.length == 2, equals(true));
    })).catchError((err)=>print(err.message));
  });
});

group("intersects command -> ",(){
  test("should return true if a geometry intersects some other geometry",(){
    Point point1 = r.point(-117.220406,32.719464);
    Line line = r.line(r.point(-117.206201,32.725186), r.point(0,1));
    r.circle(point1, 2000).intersects(line).run(connection).then(expectAsync((bool doesIntersect){
      expect(doesIntersect, equals(true));
    }));
  });

  test("should return false if a geometry does not intersect some other geometry",(){
    Point point1 = r.point(-117.220406,32.719464);
    Line line = r.line(r.point(20,20), r.point(0,1));
    r.circle(point1, 1).intersects(line).run(connection).then(expectAsync((bool doesIntersect){
      expect(doesIntersect, equals(false));
    }));
  });

  test("should filter a sequence to only contain items that intersect some other geometry",(){
    var point1 = r.point(0,0);
    var point2 = r.point(33,30);
    var point3 = r.point(-17,3);
    var point4 = r.point(101,90);
    var point5 = r.point(-100,90);
    Line line = r.line(r.point(0,0),r.point(20,20));
    r.expr([r.circle(point1, 2),r.circle(point2,2), r.circle(point3,2),r.circle(point4,2)]).intersects(point5).run(connection).then(expectAsync((List intersecting){
      expect(intersecting.length == 1, equals(true));
    })).catchError((err)=>print(err.message));
  });
});

}
//TODO on line tests test fill
//TODO make a table to test getIntersecting and getNearest
