library rethinkdb;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'src/generated/ql2.pb.dart' as p;
import 'dart:mirrors';
import 'dart:convert';
import 'dart:collection';


part 'src/ast.dart';
part 'src/errors.dart';
part 'src/net.dart';



class Rethinkdb{
// Connection Management
/**
 * Create a new connection to the database server. Accepts the following options:
 * host: the host to connect to (default localhost).
 * port: the port to connect on (default 28015).
 * db: the default database (defaults to test).
 * authKey: the authentication key (default none).
 */
Future<Connection> connect({String db, String host: "localhost", int port: 28015,
  String authKey: ""}) =>  new Connection(db,host,port,authKey)._reconnect();

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
DbDrop dbDrop(String dbName) => new DbDrop(dbName,{});

/**
 * List all database names in the system. The result is a list of strings.
 */
DbList dbList() => new DbList();


/**
 * Select all documents in a table. This command can be chained with other commands to do further processing on the data.
 */
 Table table(String tableName,[Map options]) => new Table(tableName,options);
/**
 * Create a table. A RethinkDB table is a collection of JSON documents.
 * If successful, the operation returns an object: {created: 1}. If a table with the same name already exists, the operation throws RqlRuntimeError.
 * Note: that you can only use alphanumeric characters and underscores for the table name.
 */
TableCreate tableCreate(String tableName,[Map options]) => new TableCreate(tableName,options);

/**
 * List all table names in a database. The result is a list of strings.
 */
TableList tableList() => new TableList();

/**
 * Drop a table. The table and all its data will be deleted.
 */
TableDrop tableDrop(String tableName,[Map options]) => new TableDrop(tableName,options);

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
Time time(int year,[int month,int day,String timezone,int hour,int minute,num second]) => new Time(year, month, day,timezone,hour, minute, second);

/**
 * Create a time object from a Dart DateTime object.
 *
 */
Time nativeTime(DateTime time) => new Time.nativeTime(time);

/**
 * Create a time object based on an iso8601 date-time string (e.g. '2013-01-01T01:01:01+00:00').
 * We support all valid ISO 8601 formats except for week dates.
 * If you pass an ISO 8601 date-time without a time zone, you must specify the time zone with the optarg default_timezone.
 *
 */
RqlISO8601 ISO8601(String stringTime,[default_time_zone="Z"]) => new RqlISO8601(stringTime,default_time_zone);

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
FunCall rqlDo(arg,[expr]) => new FunCall(arg,expr);

/**
 * If the test expression returns false or null, the [falseBranch] will be executed.
 * In the other cases, the [trueBranch] is the one that will be evaluated.
 */
Branch branch(test,[trueBranch,falseBranch]) => new Branch(test,trueBranch,falseBranch);

/**
 * Throw a runtime error. If called with no arguments inside the second argument to default, re-throw the current error.
 */
UserError error(String message) => new UserError(message,{});

/**
 * Create a javascript expression.
 */
JavaScript js(String js,[Map options]) => new JavaScript(js,options);

/**
 * Parse a JSON string on the server.
 */
Json json(String json) => new Json(json,{});

/**
 * Count the total size of the group.
 */
Map count = {"COUNT":true};

/**
 * Compute the sum of the given field in the group.
 */
Map sum(String attr) => {'SUM':attr};

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


//TODO label new stuff
Args args(args) => new Args(args);

Http http(url,[optargs]) => new Http(url,optargs);

Random random([left,right, options]) => new Random(left,right,options);

Not not(args) => new Not(args);

/**
All and(args) => new All(args);

Any or(args) => new Any(args);
* **/

TypeOf typeOf(args) => new TypeOf(args);

Info info(args) => new Info(args);

Literal literal(args) => new Literal(args);


/**
 * change the string to uppercase
 */
Upcase upcase(String str) => new Upcase(str);

 /**
  * Change a string to lowercase
  */
Downcase downcase(String str) => new Downcase(str);

expr(val) => _expr(val);

 noSuchMethod(Invocation invocation) {
       var methodName = invocation.memberName;
       List tmp = invocation.positionalArguments;
             List args = [];
             Map options = null;
             for(var i=0; i < tmp.length; i++){
               if(tmp[i] is Map && i == tmp.length-1)
                 options = tmp[i];
               else
                 args.add(tmp[i]);
             }

       if(methodName == const Symbol("object"))
         return this.object(args);
       if(methodName == const Symbol("rqlDo"))
         return this.rqlDo(args.sublist(0, args.length-1),args[args.length-1]);
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

}
