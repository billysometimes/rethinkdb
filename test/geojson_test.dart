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
      List coords = [[[-90,-0.00004521847385251901],[-90.0000087626309,-0.00004434961355684884],[-90.00001718851881,-0.00004177642248373849],[-90.00002495386158,-0.00003759778692306559],[-90.00003176024146,-0.000031974289496021165],[-90.00003734609305,-0.000025122038055033023],[-90.00004149675523,-0.000017304360780191545],[-90.0000440527204,-0.000008821686624964948],[-90.0000449157642,0],[-90.0000440527204,0.000008821686624964955],[-90.00004149675523,0.00001730436078019155],[-90.00003734609305,0.000025122038055033023],[-90.00003176024146,0.000031974289496021165],[-90.00002495386158,0.00003759778692306559],[-90.00001718851881,0.00004177642248373849],[-90.0000087626309,0.00004434961355684884],[-90,0.00004521847385251901],[-89.9999912373691,0.00004434961355684884],[-89.99998281148119,0.00004177642248373849],[-89.99997504613842,0.00003759778692306559],[-89.99996823975854,0.000031974289496021165],[-89.99996265390695,0.000025122038055033023],[-89.99995850324477,0.00001730436078019155],[-89.9999559472796,0.000008821686624964955],[-89.9999550842358,0],[-89.9999559472796,-0.000008821686624964948],[-89.99995850324477,-0.000017304360780191545],[-89.99996265390695,-0.000025122038055033023],[-89.99996823975854,-0.000031974289496021165],[-89.99997504613842,-0.00003759778692306559],[-89.99998281148119,-0.00004177642248373849],[-89.9999912373691,-0.00004434961355684884],[-90,-0.00004521847385251901]]];
      r.circle([long,lat],rad).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response['coordinates'], equals(coords));
        expect(response.containsKey('type'), equals(true));
        expect(response['type'], equals('Polygon'));
      }));
    });
    test("should create a polygon given a point and also a radius",(){
      int long = -90;
      int lat = 0;
      int rad = 5;
      Point p = r.point(long, lat);
      List coords = [[[-90,-0.00004521847385251901],[-90.0000087626309,-0.00004434961355684884],[-90.00001718851881,-0.00004177642248373849],[-90.00002495386158,-0.00003759778692306559],[-90.00003176024146,-0.000031974289496021165],[-90.00003734609305,-0.000025122038055033023],[-90.00004149675523,-0.000017304360780191545],[-90.0000440527204,-0.000008821686624964948],[-90.0000449157642,0],[-90.0000440527204,0.000008821686624964955],[-90.00004149675523,0.00001730436078019155],[-90.00003734609305,0.000025122038055033023],[-90.00003176024146,0.000031974289496021165],[-90.00002495386158,0.00003759778692306559],[-90.00001718851881,0.00004177642248373849],[-90.0000087626309,0.00004434961355684884],[-90,0.00004521847385251901],[-89.9999912373691,0.00004434961355684884],[-89.99998281148119,0.00004177642248373849],[-89.99997504613842,0.00003759778692306559],[-89.99996823975854,0.000031974289496021165],[-89.99996265390695,0.000025122038055033023],[-89.99995850324477,0.00001730436078019155],[-89.9999559472796,0.000008821686624964955],[-89.9999550842358,0],[-89.9999559472796,-0.000008821686624964948],[-89.99995850324477,-0.000017304360780191545],[-89.99996265390695,-0.000025122038055033023],[-89.99996823975854,-0.000031974289496021165],[-89.99997504613842,-0.00003759778692306559],[-89.99998281148119,-0.00004177642248373849],[-89.9999912373691,-0.00004434961355684884],[-90,-0.00004521847385251901]]];
      r.circle(p,rad).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response['coordinates'], equals(coords));
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
      List coords = [[ [-90, -0.01674892271018241],
      [-90.01440789072717, 0.008374461268033442],
      [-89.98559210927283, 0.008374461268033442],
      [-90, -0.01674892271018241]]];
      r.circle(p,rad, {'num_vertices':3,'unit':'nm'}).run(connection).then(expectAsync((Map response){
        expect(response.containsKey('coordinates'), equals(true));
        expect(response['coordinates'], equals(coords));
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

  test("should return false if a geometry includes some other geometry",(){
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
}
//TODO on line tests test fill
//TODO make a table to test getIntersecting and getNearest
