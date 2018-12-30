import 'package:test/test.dart';
import '../lib/rethinkdb_dart.dart';

main() {
  Rethinkdb r = Rethinkdb();
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

  group("add command -> ", () {
    test("should add two numbers", () async {
      var result = await r.expr(2).add(2).run(connection);
      expect(result, equals(4));
    });
    test("should add three numbers", () async {
      var result = await r.expr(2).add(2).add(2).run(connection);
      expect(result, equals(6));
    });
    test("should add two numbers together", () async {
      var result = await r.add(2, 2).run(connection);
      expect(result, equals(4));
    });
    test("should add three numbers together", () async {
      var result = await r.add(2, 2, 2).run(connection);
      expect(result, equals(6));
    });
    test("should concatenate strings", () async {
      var result = await r.expr("foo").add("bar", "baz").run(connection);
      expect(result, equals("foobarbaz"));
    });
    test("should concatenate arrays", () async {
      var result = await r.expr(["foo", "bar"]).add(["buzz"]).run(connection);
      expect(result, equals(["foo", "bar", "buzz"]));
    });
    test("should create a date one year from now", () async {
      var result = await r.now().add(365 * 24 * 60 * 60).run(connection);
      expect(
          DateTime.now().add(Duration(days: 365)).difference(result).inMinutes,
          lessThan(1));
    });
    test("should use args with add to sum multiple values", () async {
      var vals = [10, 20, 30];
      var result = await r.add(r.args(vals)).run(connection);
      expect(result, equals(60));
    });
    test("should use two args with add to sum multiple values", () async {
      var vals1 = [10, 20, 30];
      var vals2 = [40, 50, 60];
      var result =
          await r.add(r.args(vals1)).add(r.args(vals2)).run(connection);
      expect(result, equals(210));
    });
    test("should use two args together with add to sum multiple values",
        () async {
      var vals1 = [10, 20, 30];
      var vals2 = [40, 50, 60];
      var result = await r.add(r.args(vals1), r.args(vals2)).run(connection);
      expect(result, equals(210));
    });
    test("should concatenate an array of strings with args", () async {
      var vals = ['foo', 'bar', 'buzz'];
      var result = await r.add(r.args(vals)).run(connection);
      expect(result, equals("foobarbuzz"));
    });
    test("should concatenate two arrays of strings with args", () async {
      var vals1 = ['foo', 'bar', 'buzz'];
      var vals2 = ['foo1', 'bar1', 'buzz1'];
      var result =
          await r.add(r.args(vals1)).add(r.args(vals2)).run(connection);
      expect(result, equals("foobarbuzzfoo1bar1buzz1"));
    });
    test("should concatenate two arrays together of strings with args",
        () async {
      var vals1 = ['foo', 'bar', 'buzz'];
      var vals2 = ['foo1', 'bar1', 'buzz1'];
      var result = await r.add(r.args(vals1), r.args(vals2)).run(connection);
      expect(result, equals("foobarbuzzfoo1bar1buzz1"));
    });
  });

  group("sub command -> ", () {
    test("should sub two numbers", () async {
      var result = await r.expr(4).sub(2).run(connection);
      expect(result, equals(2));
    });
    test("should sub three numbers", () async {
      var result = await r.expr(4).sub(2).sub(2).run(connection);
      expect(result, equals(0));
    });
    test("should sub two numbers together", () async {
      var result = await r.sub(4, 2).run(connection);
      expect(result, equals(2));
    });
    test("should sub three numbers together", () async {
      var result = await r.sub(4, 2, 2).run(connection);
      expect(result, equals(0));
    });
    test("should create a date one year ago today", () async {
      var result = await r.now().sub(365 * 24 * 60 * 60).run(connection);
      expect(
          DateTime.now()
              .subtract(Duration(days: 365))
              .difference(result)
              .inMinutes,
          lessThan(1));
    });
    test("should retrieve how many seconds elapsed between today and date",
        () async {
      var date = DateTime(2018);
      var result = await r.now().sub(date).run(connection);
      expect(
          DateTime.now()
              .difference(DateTime(2018).add(Duration(minutes: result.round())))
              .inMinutes,
          lessThan(1));
    });
    test("should use args with sub to subtract multiple values", () async {
      var vals = [30, 20, 10];
      var result = await r.sub(r.args(vals)).run(connection);
      expect(result, equals(0));
    });
    test("should use two args with sub to subtract multiple values", () async {
      var vals1 = [60, 50, 40];
      var vals2 = [30, 20, 10];
      var result =
          await r.sub(r.args(vals1)).sub(r.args(vals2)).run(connection);
      expect(result, equals(-90));
    });
    test("should use two args together with sub to subtract multiple values",
        () async {
      var vals1 = [60, 50, 40];
      var vals2 = [30, 20, 10];
      var result = await r.sub(r.args(vals1), r.args(vals2)).run(connection);
      expect(result, equals(-90));
    });
  });

  group("mul command -> ", () {
    test("should mul two numbers", () async {
      var result = await r.expr(4).mul(2).run(connection);
      expect(result, equals(8));
    });
    test("should mul three numbers", () async {
      var result = await r.expr(4).mul(2).mul(2).run(connection);
      expect(result, equals(16));
    });
    test("should mul two numbers together", () async {
      var result = await r.mul(4, 2).run(connection);
      expect(result, equals(8));
    });
    test("should mul three numbers together", () async {
      var result = await r.mul(4, 2, 2).run(connection);
      expect(result, equals(16));
    });
    test("should multiply an array by a number", () async {
      var result = await r
          .expr(["This", "is", "the", "song", "that", "never", "ends."])
          .mul(2)
          .run(connection);
      expect(
          result,
          equals([
            "This",
            "is",
            "the",
            "song",
            "that",
            "never",
            "ends.",
            "This",
            "is",
            "the",
            "song",
            "that",
            "never",
            "ends."
          ]));
    });
    test("should use args with mul to multiply multiple values", () async {
      var vals = [10, 20, 30];
      var result = await r.mul(r.args(vals)).run(connection);
      expect(result, equals(6000));
    });
    test("should use two args with mul to multiply multiple values", () async {
      var vals1 = [10, 20, 30];
      var vals2 = [40, 50, 60];
      var result =
          await r.mul(r.args(vals1)).mul(r.args(vals2)).run(connection);
      expect(result, equals(720000000));
    });
    test("should use two args together with mul to multiply multiple values",
        () async {
      var vals1 = [10, 20, 30];
      var vals2 = [40, 50, 60];
      var result = await r.mul(r.args(vals1), r.args(vals2)).run(connection);
      expect(result, equals(720000000));
    });
  });

  group("div command -> ", () {
    test("should div two numbers", () async {
      var result = await r.expr(4).div(2).run(connection);
      expect(result, equals(2));
    });
    test("should div three numbers", () async {
      var result = await r.expr(4).div(2).div(2).run(connection);
      expect(result, equals(1));
    });
    test("should div two numbers together", () async {
      var result = await r.div(4, 2).run(connection);
      expect(result, equals(2));
    });
    test("should div three numbers together", () async {
      var result = await r.div(4, 2, 2).run(connection);
      expect(result, equals(1));
    });
    test("should use args with div to divide by multiple values", () async {
      var vals = [30, 2, 3];
      var result = await r.div(r.args(vals)).run(connection);
      expect(result, equals(5));
    });
    test("should use two args with div to divide by multiple values", () async {
      var vals1 = [900, 6, 3];
      var vals2 = [2, 5, 5];
      var result =
          await r.div(r.args(vals1)).div(r.args(vals2)).run(connection);
      expect(result, equals(1));
    });
    test("should use two args together with div to divide by multiple values",
        () async {
      var vals1 = [900, 6, 3];
      var vals2 = [2, 5, 5];
      var result = await r.div(r.args(vals1), r.args(vals2)).run(connection);
      expect(result, equals(1));
    });
  });

  group("mod command -> ", () {
    test("should mod two numbers", () async {
      var result = await r.expr(3).mod(2).run(connection);
      expect(result, equals(1));
    });
    test("should mod three numbers", () async {
      var result = await r.expr(9).mod(5).mod(5).run(connection);
      expect(result, equals(4));
    });
  });

  group("and command -> ", () {
    test("should evaluate two false values with and", () async {
      var a = false, b = false;
      var result = await r.expr(a).and(b).run(connection);
      expect(result, equals(false));
    });
    test("should evaluate one false and one true value with and", () async {
      var a = true, b = false;
      var result = await r.expr(a).and(b).run(connection);
      expect(result, equals(false));
    });
    test("should evaluate two true values with and", () async {
      var a = true, b = true;
      var result = await r.expr(a).and(b).run(connection);
      expect(result, equals(true));
    });
    test("should evaluate three false values together with and", () async {
      var x = false, y = false, z = false;
      var result = await r.and(x, y, z).run(connection);
      expect(result, equals(false));
    });
    test("should evaluate one false and two true values together with and",
        () async {
      var x = false, y = true, z = true;
      var result = await r.and(x, y, z).run(connection);
      expect(result, equals(false));
    });
    test("should evaluate three true values together with and", () async {
      var x = true, y = true, z = true;
      var result = await r.and(x, y, z).run(connection);
      expect(result, equals(true));
    });
  });

  group("or command -> ", () {
    test("should evaluate two false values with or", () async {
      var a = false, b = false;
      var result = await r.expr(a).or(b).run(connection);
      expect(result, equals(false));
    });
    test("should evaluate one false and one true value with or", () async {
      var a = true, b = false;
      var result = await r.expr(a).or(b).run(connection);
      expect(result, equals(true));
    });
    test("should evaluate two true values with or", () async {
      var a = true, b = true;
      var result = await r.expr(a).or(b).run(connection);
      expect(result, equals(true));
    });
    test("should evaluate three false values together with or", () async {
      var x = false, y = false, z = false;
      var result = await r.or(x, y, z).run(connection);
      expect(result, equals(false));
    });
    test("should evaluate one true and two false values together with or",
        () async {
      var x = true, y = false, z = false;
      var result = await r.or(x, y, z).run(connection);
      expect(result, equals(true));
    });
    test("should evaluate three true values together with or", () async {
      var x = true, y = true, z = true;
      var result = await r.or(x, y, z).run(connection);
      expect(result, equals(true));
    });
  });
}
