import 'package:test/test.dart';
import 'dart:async';
import '../lib/rethinkdb_driver.dart';

main() {
  Rethinkdb r = new Rethinkdb();

  test("connect() connects with defaults if no params are passed", () {
    r.connect().then(expectAsync((c) {
      expect(c, isNot(null));
      c.close();
    }));
  });

  test("connect() connects with non-default if params are passed", () {
    r
        .connect(
            db: 'testDB',
            host: "localhost",
            port: 28015,
            user: "admin",
            password: "")
        .then(expectAsync((Connection conn) {
      expect(conn, isNot(null));
      conn.close();
    }));
  });

  test("connection should run onconnect and onclose listeners", () {
    int connectCounter = 0;
    int closeCounter = 0;
    Function f = () => connectCounter++;
    Function fClose = () => closeCounter++;
    r.connect().then(expectAsync((Connection conn) {
      expect(connectCounter, equals(0));
      conn.on('connect', f);
      conn.on('close', fClose);
      expect(closeCounter, equals(0));
      conn.close();
      conn.close();
      expect(closeCounter, equals(2));
      conn.connect().then(expectAsync((Connection c) {
        expect(connectCounter, equals(1));
        c.close();
      }));
    }));
  });

  test("connections with noreplywait should return a Future", () {
    r.connect().then(expectAsync((Connection conn) {
      var fut = conn.noreplyWait();
      expect(fut is Future, equals(true));
      conn.close();
    }));
  });

  test("connections should return server info", () {
    r.connect().then(expectAsync((Connection conn) {
      conn.server().then(expectAsync((Map m) {
        expect(m.keys.length, equals(3));
        expect(m.containsKey('id'), equals(true));
        expect(m.containsKey('name'), equals(true));
        expect(m.containsKey('proxy'), equals(true));
        conn.close();
      }));
    }));
  });
}
