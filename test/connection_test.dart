import 'package:test/test.dart';
import 'dart:async';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

main() {
  Rethinkdb r = Rethinkdb();

  test("connect() connects with defaults if no params are passed", () async {
    Connection c = await r.connect();
    expect(c, isNot(null));
    c.close();
  });

  test("connect() connects with non-default if params are passed", () async {
    Connection conn = await r.connect(
        db: 'testDB',
        host: "localhost",
        port: 28015,
        user: "admin",
        password: "");

    expect(conn, isNot(null));
    conn.close();
  });

  test("connection should run onconnect and onclose listeners", () async {
    int connectCounter = 0;
    int closeCounter = 0;
    Function f = () => connectCounter++;
    Function fClose = () => closeCounter++;
    Connection conn = await r.connect();

    expect(connectCounter, equals(0));
    conn.on('connect', f);
    conn.on('close', fClose);
    expect(closeCounter, equals(0));
    conn.close();
    conn.close();
    expect(closeCounter, equals(1));
    Connection c = await conn.connect();

    expect(connectCounter, equals(1));
    c.close();
  });

  test("connections with noreplywait should return a Future", () async {
    Connection conn = await r.connect();
    var fut = conn.noreplyWait();
    expect(fut is Future, equals(true));
    conn.close();
  });

  test("connections should return server info", () async {
    Connection conn = await r.connect();
    Map m = await conn.server();

    expect(m.keys.length, equals(3));
    expect(m.containsKey('id'), equals(true));
    expect(m.containsKey('name'), equals(true));
    expect(m.containsKey('proxy'), equals(true));
    conn.close();
  });
}
