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

  group("eq command -> ", () {
    test("should check two equal values with eq", () async {
      var result = await r.expr(0).eq(0).run(connection);
      expect(result, equals(true));
    });
    test("should check two different values with eq", () async {
      var result = await r.expr(0).eq(1).run(connection);
      expect(result, equals(false));
    });
    test("should check three equal values with eq", () async {
      var result = await r.expr(0).eq(0).eq(true).run(connection);
      expect(result, equals(true));
    });
    test("should check three different values with eq", () async {
      var result = await r.expr(0).eq(1).eq(true).run(connection);
      expect(result, equals(false));
    });
    test("should check two equal values together with eq", () async {
      var result = await r.eq(0, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check two different values together with eq", () async {
      var result = await r.eq(0, 1).run(connection);
      expect(result, equals(false));
    });
    test("should check three equal values together with eq", () async {
      var result = await r.eq(0, 0, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check one different and two equal values together with eq",
        () async {
      var result = await r.eq(0, 1, 1).run(connection);
      expect(result, equals(false));
    });
    test("should check three different values together with eq", () async {
      var result = await r.eq(0, 1, 2).run(connection);
      expect(result, equals(false));
    });
    test("should use args with eq to compare multiple equal values", () async {
      var vals = [10, 10, 10];
      var result = await r.eq(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test(
        "should use args with eq to compare multiple different values (one different from the others)",
        () async {
      var vals = [10, 20, 20];
      var result = await r.eq(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test("should use args with eq to compare multiple different values",
        () async {
      var vals = [10, 20, 30];
      var result = await r.eq(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test("should use two args with eq to compare multiple equal values",
        () async {
      var vals1 = [10, 10, 10];
      var vals2 = [20, 20, 20];
      var result =
          await r.eq(r.args(vals1)).eq(r.eq(r.args(vals2))).run(connection);
      expect(result, equals(true));
    });
    test("should use two args with eq to compare multiple different values",
        () async {
      var vals1 = [10, 10, 10];
      var vals2 = [10, 20, 20];
      var result =
          await r.eq(r.args(vals1)).eq(r.eq(r.args(vals2))).run(connection);
      expect(result, equals(false));
    });
  });

  group("ne command -> ", () {
    test("should check two equal values with ne", () async {
      var result = await r.expr(0).ne(0).run(connection);
      expect(result, equals(false));
    });
    test("should check two different values with ne", () async {
      var result = await r.expr(0).ne(1).run(connection);
      expect(result, equals(true));
    });
    test("should check three equal values with ne", () async {
      var result = await r.expr(0).ne(0).ne(false).run(connection);
      expect(result, equals(false));
    });
    test("should check three different values with ne", () async {
      var result = await r.expr(0).ne(1).ne(false).run(connection);
      expect(result, equals(true));
    });
    test("should check two equal values together with ne", () async {
      var result = await r.ne(0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check two different values together with ne", () async {
      var result = await r.ne(0, 1).run(connection);
      expect(result, equals(true));
    });
    test("should check three equal values together with ne", () async {
      var result = await r.ne(0, 0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check one different and two equal values together with ne",
        () async {
      var result = await r.ne(0, 1, 1).run(connection);
      expect(result, equals(true));
    });
    test("should check three different values together with ne", () async {
      var result = await r.ne(0, 1, 2).run(connection);
      expect(result, equals(true));
    });
    test("should use args with ne to compare multiple equal values", () async {
      var vals = [10, 10, 10];
      var result = await r.ne(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with ne to compare multiple different values (one different from the others)",
        () async {
      var vals = [10, 20, 20];
      var result = await r.ne(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test("should use args with ne to compare multiple different values",
        () async {
      var vals = [10, 20, 30];
      var result = await r.ne(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test("should use two args with ne to compare multiple equal values",
        () async {
      var vals1 = [10, 10, 10];
      var vals2 = [20, 20, 20];
      var result =
          await r.ne(r.args(vals1)).ne(r.ne(r.args(vals2))).run(connection);
      expect(result, equals(false));
    });
    test("should use two args with ne to compare multiple different values",
        () async {
      var vals1 = [10, 10, 10];
      var vals2 = [10, 20, 20];
      var result =
          await r.ne(r.args(vals1)).ne(r.ne(r.args(vals2))).run(connection);
      expect(result, equals(true));
    });
  });

  group("lt command -> ", () {
    test("should check two equal values with lt", () async {
      var result = await r.expr(0).lt(0).run(connection);
      expect(result, equals(false));
    });
    test("should check two increasing values with lt", () async {
      var result = await r.expr(0).lt(1).run(connection);
      expect(result, equals(true));
    });
    test("should check two decreasing values with lt", () async {
      var result = await r.expr(1).lt(0).run(connection);
      expect(result, equals(false));
    });
    test("should check two equal values together with lt", () async {
      var result = await r.lt(0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check two increasing values together with lt", () async {
      var result = await r.lt(0, 1).run(connection);
      expect(result, equals(true));
    });
    test("should check two decreasing values together with lt", () async {
      var result = await r.lt(1, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check three equal values together with lt", () async {
      var result = await r.lt(0, 0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check three increasing values together with lt", () async {
      var result = await r.lt(0, 1, 2).run(connection);
      expect(result, equals(true));
    });
    test("should check three decreasing values together with lt", () async {
      var result = await r.lt(2, 1, 0).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check one lower and two higher and equal values together with lt",
        () async {
      var result = await r.lt(0, 1, 1).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check two lower and equal and one higher value together with lt",
        () async {
      var result = await r.lt(0, 0, 1).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check two higher and equal and one lower values together with lt",
        () async {
      var result = await r.lt(1, 1, 0).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check one higher and two lower and equal value together with lt",
        () async {
      var result = await r.lt(1, 0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should use args with lt to compare multiple equal values", () async {
      var vals = [10, 10, 10];
      var result = await r.lt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with lt to compare multiple values (one lower and two higher and equal)",
        () async {
      var vals = [10, 20, 20];
      var result = await r.lt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with lt to compare multiple values (two lower and equal and one higher)",
        () async {
      var vals = [10, 10, 20];
      var result = await r.lt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with lt to compare multiple values (one higher and two lower and equal)",
        () async {
      var vals = [20, 10, 10];
      var result = await r.lt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with lt to compare multiple values (two higher and equal and one lower)",
        () async {
      var vals = [20, 20, 10];
      var result = await r.lt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test("should use args with lt to compare multiple increasing values",
        () async {
      var vals = [10, 20, 30];
      var result = await r.lt(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test("should use args with lt to compare multiple decreasing values",
        () async {
      var vals = [30, 20, 10];
      var result = await r.lt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
  });

  group("le command -> ", () {
    test("should check two equal values with le", () async {
      var result = await r.expr(0).le(0).run(connection);
      expect(result, equals(true));
    });
    test("should check two increasing values with le", () async {
      var result = await r.expr(0).le(1).run(connection);
      expect(result, equals(true));
    });
    test("should check two decreasing values with le", () async {
      var result = await r.expr(1).le(0).run(connection);
      expect(result, equals(false));
    });
    test("should check two equal values together with le", () async {
      var result = await r.le(0, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check two increasing values together with le", () async {
      var result = await r.le(0, 1).run(connection);
      expect(result, equals(true));
    });
    test("should check two decreasing values together with le", () async {
      var result = await r.le(1, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check three equal values together with le", () async {
      var result = await r.le(0, 0, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check three increasing values together with le", () async {
      var result = await r.le(0, 1, 2).run(connection);
      expect(result, equals(true));
    });
    test("should check three decreasing values together with le", () async {
      var result = await r.le(2, 1, 0).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check one lower and two higher and equal values together with le",
        () async {
      var result = await r.le(0, 1, 1).run(connection);
      expect(result, equals(true));
    });
    test(
        "should check two lower and equal and one higher value together with le",
        () async {
      var result = await r.le(0, 0, 1).run(connection);
      expect(result, equals(true));
    });
    test(
        "should check two higher and equal and one lower values together with le",
        () async {
      var result = await r.le(1, 1, 0).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check one higher and two lower and equal value together with le",
        () async {
      var result = await r.le(1, 0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should use args with le to compare multiple equal values", () async {
      var vals = [10, 10, 10];
      var result = await r.le(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test(
        "should use args with le to compare multiple values (one lower and two higher and equal)",
        () async {
      var vals = [10, 20, 20];
      var result = await r.le(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test(
        "should use args with le to compare multiple values (two lower and equal and one higher)",
        () async {
      var vals = [10, 10, 20];
      var result = await r.le(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test(
        "should use args with le to compare multiple values (one higher and two lower and equal)",
        () async {
      var vals = [20, 10, 10];
      var result = await r.le(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with le to compare multiple values (two higher and equal and one lower)",
        () async {
      var vals = [20, 20, 10];
      var result = await r.le(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test("should use args with le to compare multiple increasing values",
        () async {
      var vals = [10, 20, 30];
      var result = await r.le(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test("should use args with le to compare multiple decreasing values",
        () async {
      var vals = [30, 20, 10];
      var result = await r.le(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
  });

  group("gt command -> ", () {
    test("should check two equal values with gt", () async {
      var result = await r.expr(0).gt(0).run(connection);
      expect(result, equals(false));
    });
    test("should check two increasing values with gt", () async {
      var result = await r.expr(0).gt(1).run(connection);
      expect(result, equals(false));
    });
    test("should check two decreasing values with gt", () async {
      var result = await r.expr(1).gt(0).run(connection);
      expect(result, equals(true));
    });
    test("should check two equal values together with gt", () async {
      var result = await r.gt(0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check two increasing values together with gt", () async {
      var result = await r.gt(0, 1).run(connection);
      expect(result, equals(false));
    });
    test("should check two decreasing values together with gt", () async {
      var result = await r.gt(1, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check three equal values together with gt", () async {
      var result = await r.gt(0, 0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should check three increasing values together with gt", () async {
      var result = await r.gt(0, 1, 2).run(connection);
      expect(result, equals(false));
    });
    test("should check three decreasing values together with gt", () async {
      var result = await r.gt(2, 1, 0).run(connection);
      expect(result, equals(true));
    });
    test(
        "should check one lower and two higher and equal values together with gt",
        () async {
      var result = await r.gt(0, 1, 1).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check two lower and equal and one higher value together with gt",
        () async {
      var result = await r.gt(0, 0, 1).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check two higher and equal and one lower values together with gt",
        () async {
      var result = await r.gt(1, 1, 0).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check one higher and two lower and equal value together with gt",
        () async {
      var result = await r.gt(1, 0, 0).run(connection);
      expect(result, equals(false));
    });
    test("should use args with gt to compare multiple equal values", () async {
      var vals = [10, 10, 10];
      var result = await r.gt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with gt to compare multiple values (one lower and two higher and equal)",
        () async {
      var vals = [10, 20, 20];
      var result = await r.gt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with gt to compare multiple values (two lower and equal and one higher)",
        () async {
      var vals = [10, 10, 20];
      var result = await r.gt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with gt to compare multiple values (one higher and two lower and equal)",
        () async {
      var vals = [20, 10, 10];
      var result = await r.gt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with gt to compare multiple values (two higher and equal and one lower)",
        () async {
      var vals = [20, 20, 10];
      var result = await r.gt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test("should use args with gt to compare multiple increasing values",
        () async {
      var vals = [10, 20, 30];
      var result = await r.gt(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test("should use args with gt to compare multiple decreasing values",
        () async {
      var vals = [30, 20, 10];
      var result = await r.gt(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
  });

  group("ge command -> ", () {
    test("should check two equal values with ge", () async {
      var result = await r.expr(0).ge(0).run(connection);
      expect(result, equals(true));
    });
    test("should check two increasing values with ge", () async {
      var result = await r.expr(0).ge(1).run(connection);
      expect(result, equals(false));
    });
    test("should check two decreasing values with ge", () async {
      var result = await r.expr(1).ge(0).run(connection);
      expect(result, equals(true));
    });
    test("should check two equal values together with ge", () async {
      var result = await r.ge(0, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check two increasing values together with ge", () async {
      var result = await r.ge(0, 1).run(connection);
      expect(result, equals(false));
    });
    test("should check two decreasing values together with ge", () async {
      var result = await r.ge(1, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check three equal values together with ge", () async {
      var result = await r.ge(0, 0, 0).run(connection);
      expect(result, equals(true));
    });
    test("should check three increasing values together with ge", () async {
      var result = await r.ge(0, 1, 2).run(connection);
      expect(result, equals(false));
    });
    test("should check three decreasing values together with ge", () async {
      var result = await r.ge(2, 1, 0).run(connection);
      expect(result, equals(true));
    });
    test(
        "should check one lower and two higher and equal values together with ge",
        () async {
      var result = await r.ge(0, 1, 1).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check two lower and equal and one higher value together with ge",
        () async {
      var result = await r.ge(0, 0, 1).run(connection);
      expect(result, equals(false));
    });
    test(
        "should check two higher and equal and one lower values together with ge",
        () async {
      var result = await r.ge(1, 1, 0).run(connection);
      expect(result, equals(true));
    });
    test(
        "should check one higher and two lower and equal value together with ge",
        () async {
      var result = await r.ge(1, 0, 0).run(connection);
      expect(result, equals(true));
    });
    test("should use args with ge to compare multiple equal values", () async {
      var vals = [10, 10, 10];
      var result = await r.ge(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test(
        "should use args with ge to compare multiple values (one lower and two higher and equal)",
        () async {
      var vals = [10, 20, 20];
      var result = await r.ge(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with ge to compare multiple values (two lower and equal and one higher)",
        () async {
      var vals = [10, 10, 20];
      var result = await r.ge(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test(
        "should use args with ge to compare multiple values (one higher and two lower and equal)",
        () async {
      var vals = [20, 10, 10];
      var result = await r.ge(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test(
        "should use args with ge to compare multiple values (two higher and equal and one lower)",
        () async {
      var vals = [20, 20, 10];
      var result = await r.ge(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
    test("should use args with ge to compare multiple increasing values",
        () async {
      var vals = [10, 20, 30];
      var result = await r.ge(r.args(vals)).run(connection);
      expect(result, equals(false));
    });
    test("should use args with ge to compare multiple decreasing values",
        () async {
      var vals = [30, 20, 10];
      var result = await r.ge(r.args(vals)).run(connection);
      expect(result, equals(true));
    });
  });
}
