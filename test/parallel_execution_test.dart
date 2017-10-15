import 'package:test/test.dart';
import 'dart:async';
import '../lib/rethinkdb_driver.dart';

main() {
  test('ParallelExecution', () async {
    bool isParallel = await pEx();
  expect(isParallel, equals(true));
  }, timeout: new Timeout.factor(4));
}

Future pEx() {
  Rethinkdb r = new Rethinkdb();
  return r
      .connect(db: "test", port: 28015)
      .then((connection) => _queryWhileWriting(connection, r));
}

_queryWhileWriting(conn, r) async {
  //variable that will be set by our faster query
  int total = null;

  Completer testCompleter = new Completer();

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

  r.table("bigTable").insert(bigJson).run(conn).then((d){
    print('write done');
    //remove test tables after test complete
    return r.tableDrop("bigTable").run(conn);
  }).then((_){
    return r.tableDrop("emptyTable").run(conn);
  }).then((_){
    conn.close();
    return testCompleter.complete(total != null);
  });

  //run another query while the insert is running
  r.table("emptyTable").count().run(conn).then((t){
    total = t;
    print('total in emptyTable: $total');
  });

  return testCompleter.future;
}
