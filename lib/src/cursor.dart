part of rethinkdb;

class Cursor extends Stream {
  Connection _conn;
  Query _query;
  Map _opts;
  int _outstandingRequests = 0;
  bool _endFlag = false;
  StreamController _s = StreamController();

  Cursor(this._conn, this._query, this._opts);

  _extend(Response response) {
    _endFlag = response._type != p.Response_ResponseType.SUCCESS_PARTIAL.value;

    if (response._type != p.Response_ResponseType.SUCCESS_PARTIAL.value &&
        response._type != p.Response_ResponseType.SUCCESS_SEQUENCE.value) {
      _s.addError(
          RqlDriverError("Unexpected response type received for cursor"), null);
    }

    try {
      _conn._checkErrorResponse(response, _query._term);
    } catch (e) {
      _s.addError(e);
    }

    var convertedData =
        _query._recursivelyConvertPseudotypes(response._data, _opts);
    _s.addStream(Stream.fromIterable(convertedData)).then((f) {
      if (!_endFlag) {
        _outstandingRequests++;
        Query query =
            Query(p.Query_QueryType.CONTINUE, this._query._token, null, null);
        query._cursor = this;
        _conn._sendQueue.addLast(query);
        _conn._sendQuery();
      } else {
        _s.close();
      }
    });
  }

  Future close() => _s.close();

  StreamSubscription listen(Function onData,
      {Function onError, Function onDone, bool cancelOnError}) {
    return _s.stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

class Feed extends Cursor {
  Feed(conn, opts, query) : super(conn, opts, query);

  toSet() => throw RqlDriverError("`toSet` is not available for feeds.");
  toList() => throw RqlDriverError("`toList` is not available for feeds.");
  toString() => "Instance of 'Feed'";
}

class UnionedFeed extends Cursor {
  UnionedFeed(conn, opts, query) : super(conn, opts, query);

  toSet() => throw RqlDriverError("`toSet` is not available for feeds.");
  toList() => throw RqlDriverError("`toList` is not available for feeds.");
  toString() => "Instance of 'UnionedFeed'";
}

class AtomFeed extends Cursor {
  AtomFeed(conn, opts, query) : super(conn, opts, query);

  toSet() => throw RqlDriverError("`toSet` is not available for feeds.");
  toList() => throw RqlDriverError("`toList` is not available for feeds.");
  toString() => "Instance of 'AtomFeed'";
}

class OrderByLimitFeed extends Cursor {
  OrderByLimitFeed(conn, opts, query) : super(conn, opts, query);

  toSet() => throw RqlDriverError("`toSet` is not available for feeds.");
  toList() => throw RqlDriverError("`toList` is not available for feeds.");
  toString() => "Instance of 'OrderByLimitFeed'";
}
