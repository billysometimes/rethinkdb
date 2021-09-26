import 'package:rethinkdb_dart/rethinkdb_dart.dart';

Rethinkdb r = Rethinkdb();

void main(List<String> arguments) async {
  var connection;
  try {
    // Create the database connection.
    connection = await r.connect(db: "test", host: "localhost", port: 28015);

    // Drop the table if it exists.
    await r
        .db('test')
        .tableList()
        .contains('tv_shows')
        .not()
        .rqlDo((databaseExists) {
      return r.branch(
          databaseExists, r.tableList(), r.db('test').tableDrop('tv_shows'));
    }).run(connection);

    // Create the table if it doesn't exist.
    await r.db('test').tableList().contains('tv_shows').rqlDo((databaseExists) {
      return r.branch(
          databaseExists, r.tableList(), r.db('test').tableCreate('tv_shows'));
    }).run(connection);

    // Insert some data.
    await r.table('tv_shows').insert([
      {'name': 'Star Trek TNG', 'episodes': 178},
      {'name': 'Battlestar Galactica', 'episodes': 75}
    ]).run(connection);

    // Display the data count.
    var count = await r.table('tv_shows').count().run(connection);
    print("count: $count");
  } catch (e) {
    print("Error: $e");
  } finally {
    if (connection != null) {
      connection.close();
    }
  }
}
