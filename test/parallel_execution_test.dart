import 'package:test/test.dart';
import 'dart:async';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

main() {
  test('ParallelExecution', () async {
    bool isParallel = await pEx();
    expect(isParallel, equals(true));
  }, timeout: Timeout.factor(4));
}

Future pEx() {
  var r = Rethinkdb() as dynamic;
  return r
      .connect(db: "test", port: 28015)
      .then((connection) => _queryWhileWriting(connection, r));
}

_queryWhileWriting(conn, r) async {
  //variable that will be set by our faster query
  int total;

  Completer testCompleter = Completer();

  //set up some test tables

  try {
    await r.tableCreate("emptyTable").run(conn);
    await r.tableCreate("bigTable").run(conn);
  } catch (err) {
    //table exists
  }

  //create a big array to write
  var bigJson = [];
  for (var i = 0; i < 100000; i++) {
    bigJson.add({'id': i, 'name': 'a$i'});
  }

  print('json built, starting write');

  r.table("bigTable").insert(bigJson).run(conn).then((d) {
    print('write done');
    //remove test tables after test complete
    return r.tableDrop("bigTable").run(conn);
  }).then((_) {
    return r.tableDrop("emptyTable").run(conn);
  }).then((_) {
    conn.close();
    return testCompleter.complete(total != null);
  });

  //run another query while the insert is running
  r.table("emptyTable").count().run(conn).then((t) {
    total = t;
    print('total in emptyTable: $total');
  });

  return testCompleter.future;
}
