import 'package:connection_pool/connection_pool.dart';
import 'rethinkdb_driver.dart';
import 'dart:async';

/**
 * Simple pool for RethinkDB
 *  Rdb rb = new Rdb("database",port,"ip","auth", POOL_SIZE);

    ManagedConnection managedConnection = await rb.getConnection(); // get connection
    Rethinkdb r = new Rethinkdb();
    Cursor result = await r.table("tv_shows").run(managedConnection.conn); //
 */
class Rdb extends ConnectionPool<Connection> {
  String _database;
  int _port;
  String _host;
  String _auth;

  Rdb(this._database, this._port, this._host, this._auth, int poolSize) : super(poolSize);

  @override
  void closeConnection(Connection conn) {
    conn.close();
  }

  @override
  Future<Connection> openNewConnection() {
    Rethinkdb r = new Rethinkdb();
    return r.connect(db: _database, port: _port, host:_host, authKey:_auth).then((connection) => connection);
  }
}
