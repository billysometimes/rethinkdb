library rethinkdb;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'src/generated/ql2.pb.dart' as p;
import 'dart:mirrors';
import 'dart:convert';
import 'dart:collection';
import 'package:crypto/crypto.dart';
import 'dart:math' as math;

part 'src/ast.dart';
part 'src/errors.dart';
part 'src/net.dart';
part 'src/cursor.dart';

class Rethinkdb {
// Connection Management
/**
 * Create a new connection to the database server. Accepts the following options:
 * host: the host to connect to (default localhost).
 * port: the port to connect on (default 28015).
 * db: the default database (defaults to test).
 * user: the user name for the db (defaults to admin).
 * password: password for the user (default "").
 */
  Future<Connection> connect(
          {String db: 'test',
          String host: "localhost",
          int port: 28015,
          String user: "admin",
          String password: ""}) =>
      new Connection(db, host, port, user, password).reconnect();

/**
 *Reference a database.This command can be chained with other commands to do further processing on the data.
 */
  DB db(String dbName) => new DB(dbName);

/**
 * Create a database. A RethinkDB database is a collection of tables, similar to relational databases.
 * If successful, the operation returns an object: {created: 1}. If a database with the same name already exists the operation throws RqlRuntimeError.
 * Note: that you can only use alphanumeric characters and underscores for the database name.
 */
  DbCreate dbCreate(String dbName) => new DbCreate(dbName);

/**
 * Drop a database. The database, all its tables, and corresponding data will be deleted.
 * If successful, the operation returns the object {dropped: 1}.
 * If the specified database doesn't exist a RqlRuntimeError is thrown.
*/
  DbDrop dbDrop(String dbName) => new DbDrop(dbName, {});

/**
 * List all database names in the system. The result is a list of strings.
 */
  DbList dbList() => new DbList();

  Range range([start, end]) {
    if (start == null) {
      return new Range.asStream();
    } else if (end == null) {
      return new Range(start);
    } else {
      return new Range.withStart(start, end);
    }
  }

/**
 * Select all documents in a table. This command can be chained with other commands to do further processing on the data.
 */
  Table table(String tableName, [Map options]) => new Table(tableName, options);
/**
 * Create a table. A RethinkDB table is a collection of JSON documents.
 * If successful, the operation returns an object: {created: 1}. If a table with the same name already exists, the operation throws RqlRuntimeError.
 * Note: that you can only use alphanumeric characters and underscores for the table name.
 */
  TableCreate tableCreate(String tableName, [Map options]) =>
      new TableCreate(tableName, options);

/**
 * List all table names in a database. The result is a list of strings.
 */
  TableList tableList() => new TableList();

/**
 * Drop a table. The table and all its data will be deleted.
 */
  TableDrop tableDrop(String tableName, [Map options]) =>
      new TableDrop(tableName, options);

/**
 * Specify ascending order on an attribute
 */
  Asc asc(String attr) => new Asc(attr);

/**
 * Specify descending order on an attribute
 */
  Desc desc(String attr) => new Desc(attr);

/**
 * Create a time object for a specific time.
 */
  Time time(int year,
          [int month,
          int day,
          String timezone,
          int hour,
          int minute,
          num second]) =>
      new Time(year, month, day, timezone, hour, minute, second);

/**
 * Create a time object from a Dart DateTime object.
 *
 */
  Time nativeTime(DateTime val) => new Time(val.year, val.month, val.day,
      _formatTimeZoneOffset(val), val.hour, val.minute, val.second);

  String _formatTimeZoneOffset(DateTime val) {
    String tz = val.timeZoneOffset.inHours.toString();

    if (!val.timeZoneOffset.inHours.isNegative) tz = "+$tz";

    if (tz.length == 2) tz = tz.replaceRange(0, 1, tz[0] + "0");

    return tz;
  }

/**
 * Create a time object based on an iso8601 date-time string (e.g. '2013-01-01T01:01:01+00:00').
 * We support all valid ISO 8601 formats except for week dates.
 * If you pass an ISO 8601 date-time without a time zone, you must specify the time zone with the optarg default_timezone.
 *
 */
  RqlISO8601 ISO8601(String stringTime, [defaultTimeZone = "Z"]) =>
      new RqlISO8601(stringTime, defaultTimeZone);

/**
 * Create a time object based on seconds since epoch.
 *  The first argument is a double and will be rounded to three decimal places (millisecond-precision).
 */
  EpochTime epochTime(int eptime) => new EpochTime(eptime);

/**
 * Return a time object representing the current time in UTC.
 *  The command now() is computed once when the server receives the query, so multiple instances of r.now() will always return the same time inside a query.
 */
  Now now() => new Now();

/**
 * Evaluate the expr in the context of one or more value bindings.
 * The type of the result is the type of the value returned from expr.
 */
  FunCall rqlDo(arg, [expr]) => new FunCall(arg, expr);

/**
 * If the test expression returns false or null, the [falseBranch] will be executed.
 * In the other cases, the [trueBranch] is the one that will be evaluated.
 */
  Branch branch(test, [trueBranch, falseBranch]) =>
      new Branch(test, trueBranch, falseBranch);

/**
 * Throw a runtime error. If called with no arguments inside the second argument to default, re-throw the current error.
 */
  UserError error(String message) => new UserError(message, {});

/**
 * Create a javascript expression.
 */
  JavaScript js(String js, [Map options]) => new JavaScript(js, options);

/**
 * Parse a JSON string on the server.
 */
  Json json(String json) => new Json(json, {});

/**
 * Count the total size of the group.
 */
  Map count = {"COUNT": true};

/**
 * Compute the sum of the given field in the group.
 */
  Map sum(String attr) => {'SUM': attr};

/**
 * Compute the average value of the given attribute for the group.
 */
  Map avg(String attr) => {"AVG": attr};

/**
 * Returns the currently visited document.
 */
  ImplicitVar row = new ImplicitVar();

/**
 * Adds fields to an object
 */

  RqlObject object(args) => new RqlObject(args);

/**
 * Acts like the ruby splat operator; unpacks a list of arguments.
 */
  Args args(args) => new Args(args);

/**
 * Returns data from a specified http url
 */
  Http http(url, [optargs]) => new Http(url, optargs);

/**
 * Generates a random number between two bounds
 */
  Random random([left, right, options]) => new Random(left, right, options);

/**
 * Returns logical inverse of the arguments given
 */
  Not not(args) => new Not(args);

  RqlMap map(seq, mappingFunction) => new RqlMap([seq], mappingFunction);

/**
 * computes logical 'and' of two or more values
 */
  And and(obj1, obj2) => new And([obj1, obj2]);

/**
 * computes logical 'or' of two or more values
 */
  Or or(obj1, obj2) => new Or([obj1, obj2]);

/**
 * Returns the type of the value
 */

/**
 * Replace an object in a field instead of merging it with an existing object in a [merge] or [update] operation.
 */
  Literal literal(args) => new Literal(args);

/**
 * change the string to uppercase
 */
  Upcase upcase(String str) => new Upcase(str);

  /**
  * Change a string to lowercase
  */
  Downcase downcase(String str) => new Downcase(str);

/**
 * Convert native dart object into a RqlObject
 */
  expr(val) => new RqlQuery()._expr(val);

/**
 * Convert a GeoJSON object to a ReQL geometry object.
 */
  GeoJson geojson(Map geoJson) => new GeoJson(geoJson);

/**
 * Construct a circular line or polygon.
 */
  Circle circle(point, num radius, [Map options]) =>
      new Circle(point, radius, options);

/**
 * Construct a geometric line
 */
  Line line(point1, point2) => new Line([point1, point2]);

/**
 * Construct a geometric point
 */
  Point point(num long, num lat) => new Point(long, lat);

/**
 * Construct a geometric polygon
 */
  Polygon polygon(point1, point2) => new Polygon([point1, point2]);

/**
 * Encapsulate binary data within a query.
 */
  Binary binary(var data) => new Binary(data);

  noSuchMethod(Invocation invocation) {
    String methodName = MirrorSystem.getName(invocation.memberName);
    List args = new List.from(invocation.positionalArguments);

    switch (methodName) {
      case "object":
        return this.object(args);
      case "rqlDo":
        return this.rqlDo(args.sublist(0, args.length - 1), args.last);
      case "line":
        return new Line(args);
      case "polygon":
        return new Polygon(args);
      case "and":
        return new And(args);
      case "or":
        return new Or(args);
      case "map":
        return new RqlMap(args.sublist(0, args.length - 1), args.last);
      default:
        throw new RqlDriverError("Unknown method $methodName");
    }
  }

  RqlTimeName monday = new RqlTimeName(p.Term_TermType.MONDAY);
  RqlTimeName tuesday = new RqlTimeName(p.Term_TermType.TUESDAY);
  RqlTimeName wednesday = new RqlTimeName(p.Term_TermType.WEDNESDAY);
  RqlTimeName thursday = new RqlTimeName(p.Term_TermType.THURSDAY);
  RqlTimeName friday = new RqlTimeName(p.Term_TermType.FRIDAY);
  RqlTimeName saturday = new RqlTimeName(p.Term_TermType.SATURDAY);
  RqlTimeName sunday = new RqlTimeName(p.Term_TermType.SUNDAY);

  RqlTimeName january = new RqlTimeName(p.Term_TermType.JANUARY);
  RqlTimeName february = new RqlTimeName(p.Term_TermType.FEBRUARY);
  RqlTimeName march = new RqlTimeName(p.Term_TermType.MARCH);
  RqlTimeName april = new RqlTimeName(p.Term_TermType.APRIL);
  RqlTimeName may = new RqlTimeName(p.Term_TermType.MAY);
  RqlTimeName june = new RqlTimeName(p.Term_TermType.JUNE);
  RqlTimeName july = new RqlTimeName(p.Term_TermType.JULY);
  RqlTimeName august = new RqlTimeName(p.Term_TermType.AUGUST);
  RqlTimeName september = new RqlTimeName(p.Term_TermType.SEPTEMBER);
  RqlTimeName october = new RqlTimeName(p.Term_TermType.OCTOBER);
  RqlTimeName november = new RqlTimeName(p.Term_TermType.NOVEMBER);
  RqlTimeName december = new RqlTimeName(p.Term_TermType.DECEMBER);

  RqlConstant minval = new RqlConstant(p.Term_TermType.MINVAL);
  RqlConstant maxval = new RqlConstant(p.Term_TermType.MAXVAL);

  Uuid uuid([str]) => new Uuid(str);
}
