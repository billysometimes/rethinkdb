part of rethinkdb;

class Cursor extends Stream{

    Connection _conn;
    Query _query;
    Map _opts;
    int _outstanding_requests = 0;
    bool _end_flag = false;
    StreamController _s = new StreamController<Map>();
    
    Cursor(Connection this._conn,Query this._query,Map this._opts);

    _extend(Response response){
        _end_flag = response._type != p.Response_ResponseType.SUCCESS_PARTIAL.value;
        
        if(response._type != p.Response_ResponseType.SUCCESS_PARTIAL.value &&
           response._type != p.Response_ResponseType.SUCCESS_SEQUENCE.value){
          _s.addError(new RqlDriverError("Unexpected response type received for cursor"),null);
        }
        
        try{
          _conn._check_error_response(response, _query._term);
        }catch(e){
           _s.addError(e);
        }
        
          var convertedData = _query._recursively_convert_pseudotypes(response._data, _opts);
          _s.addStream(new Stream.fromIterable(convertedData)).then((f){
            if(!_end_flag){
              _outstanding_requests++;
              Query query = new Query(p.Query_QueryType.CONTINUE, this._query._token, null, null);
              query._cursor = this;
              _conn._sendQueue.addLast(query);
              _conn._send_query();
            }else{
              _s.close();
            }
          });
    }
    
    StreamSubscription listen(Function onData,
                                 { Function onError,
                                   Function onDone,
                                   bool cancelOnError}){
      
      return _s.stream.listen(onData,onError:onError,onDone:onDone,cancelOnError:cancelOnError);
    }
}

class Feed extends Cursor{
    Feed(conn, opts, query):super(conn, opts, query);

    toSet()=>throw new RqlDriverError("`toSet` is not available for feeds.");
    toList()=>throw new RqlDriverError("`toList` is not available for feeds.");
    toString() => "Instance of 'Feed'";
}
class UnionedFeed extends Cursor{
    UnionedFeed(conn, opts, query):super(conn, opts, query);

    toSet()=>throw new RqlDriverError("`toSet` is not available for feeds.");
    toList()=>throw new RqlDriverError("`toList` is not available for feeds.");
    toString() => "Instance of 'UnionedFeed'";
}

class AtomFeed extends Cursor{
  AtomFeed(conn, opts, query):super(conn, opts, query);

  toSet()=>throw new RqlDriverError("`toSet` is not available for feeds.");
  toList()=>throw new RqlDriverError("`toList` is not available for feeds.");
  toString() => "Instance of 'AtomFeed'";
}

class OrderByLimitFeed extends Cursor{
    OrderByLimitFeed(conn, opts, query):super(conn, opts, query);

    toSet()=>throw new RqlDriverError("`toSet` is not available for feeds.");
    toList()=>throw new RqlDriverError("`toList` is not available for feeds.");
    toString() => "Instance of 'OrderByLimitFeed'";
}
