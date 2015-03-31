part of rethinkdb;

class Cursor extends IterableBase{

    Connection _conn;
    Query _query;
    Map _opts;
    List<Response> _responses = [];
    int _outstanding_requests = 0;
    bool _end_flag = false;
    EventEmitter _emitter = null;

    Cursor(Connection this._conn,Query this._query,Map this._opts);

    _extend(Response response){
        _end_flag = response._type != p.Response_ResponseType.SUCCESS_PARTIAL.value;
        if(response._data.length > 0)
          _responses.add(response);

    }
       
    hasNext() => throw new RqlDriverError("The `hasNext` command has been removed since 1.13. Use `next` instead.");

    Iterator get iterator => _responses.iterator;
    
    toString() => "Instance of 'Cursor'";
   

    forEach(Function cb){
      return each(cb);
    }
    
    addListener(String evt,Function f){
      on(evt,f);
    }
    
    on(String data,Function f){
      if(_emitter == null){
        _makeEmitter();
        _emitter.on(data,f);
        _each((data){
          return _emitter.emit('data', data);
        }).catchError((err){
          return _emitter.emit('error', err);
        });
      }else{
        _emitter.on(data,f);
      }
    }
    
    once(String data,Function f){
      if(_emitter == null){
        _makeEmitter();
        _emitter.once(data,f);
        _each((data){
          return _emitter.emit('data', data);
        }).catchError((err){
          return _emitter.emit('error', err);
        });
      }else{
        _emitter.once(data,f);
      }
    }
    
    removeListener(String evt,Function f){
      _makeEmitter();
      _emitter.removeListener(evt, f);
    }
    
    removeAllListeners([String event]){
      _makeEmitter();
      _emitter.removeAllListeners(event);
    }
    
    setMaxListeners(int n){
      _makeEmitter();
      _emitter.maxListeners = n;
    }
    
    listeners(String event){
      _makeEmitter();
      _emitter.listeners(event);
    }
        
    _makeEmitter(){
      if(_emitter == null){
        _emitter = new EventEmitter();
      }
    }
    
    each(Function cb){
      if(_emitter != null){
        Completer c = new Completer();
        c.completeError(new RqlDriverError("Cannot use 'each' and emitter functions at the same time"));
        return c.future;
      }else{
        return _each(cb);
      }
    }

    _each(Function cb){

      Completer c = new Completer();

      _next().then((data){
        if(data != null){
          cb(data);
          c.complete(_each(cb));
        }else
          c.complete();
      }).catchError((err){
        c.completeError(err);
      });

      return c.future;
    }
    
    next(){
      if(_emitter != null){
        Completer c = new Completer();
        c.completeError(new RqlDriverError("Cannot use 'next' and emitter functions at the same time"));
        return c.future;
      }else{
        return _next();
      }
    }
    
    _next(){
      Completer c = new Completer();
      
      if(_conn.isClosed){
        if(c.isCompleted == false)
          c.completeError(new RqlDriverError("Connection closed, cannot read cursor"),null);
      }

      if(_responses.length > 0){
        
        try{
          for(var i=0; i<_responses.length;i++)
            _conn._check_error_response(_responses[0], _query._term);
        }catch(e){
          if(!c.isCompleted)
            c.completeError(e);
        }
        
        if(_responses[0]._type != p.Response_ResponseType.SUCCESS_PARTIAL.value &&
           _responses[0]._type != p.Response_ResponseType.SUCCESS_SEQUENCE.value){
          if(!c.isCompleted)
            c.completeError(new RqlDriverError("Unexpected response type received for cursor"),null);
        }
        
        var convertedData = _query._recursively_convert_pseudotypes(_responses[0]._data.removeAt(0), _opts);
        if(_responses[0]._data.isEmpty){
          _responses.removeAt(0);
        }  
        if(!c.isCompleted)
          c.complete(convertedData);
      }
      
      if(!_end_flag){
        _outstanding_requests++;

        Query query = new Query(p.Query_QueryType.CONTINUE, this._query._token, null, null);
        _conn._sendQueue.addLast(query);
        _conn._send_query().then((res){
          c.complete(_next());
        });
      }
      
      if(_end_flag && _responses.length == 0 && !c.isCompleted){
        c.complete();
      }
      

      return c.future;
    
    }

    toArray(){
      Completer c = new Completer();
      List results = [];
      this._each((row) {
         results.add(row);
      }).then((r){
        c.complete(results);
      }).catchError((err){
        c.completeError(err);
      });
      return c.future;

    }

    Future close(){
        if(!_end_flag){
            _outstanding_requests++;
            _end_flag = true;
            Query query = new Query(p.Query_QueryType.STOP, this._query._token, null, null);
            _conn._sendQueue.addLast(query);
           return _conn._send_query();
        }else{
          Completer c = new Completer();
          c.completeError(new Exception("Cursor already closed"));
          return c.future;
        }
    }
}

class Feed extends Cursor{
    Feed(conn, opts, query):super(conn, opts, query);

    hasNext()=>throw new RqlDriverError("`hasNext` is not available for feeds.");
    toArray()=>throw new RqlDriverError("`toArray` is not available for feeds.");
    toString() => "Instance of 'Feed'";
}
class UnionedFeed extends Cursor{
    UnionedFeed(conn, opts, query):super(conn, opts, query);

    hasNext()=>throw new RqlDriverError("`hasNext` is not available for feeds.");
    toArray()=>throw new RqlDriverError("`toArray` is not available for feeds.");
    toString() => "Instance of 'UnionedFeed'";
}

class AtomFeed extends Cursor{
  AtomFeed(conn, opts, query):super(conn, opts, query);

  hasNext()=>throw new RqlDriverError("`hasNext` is not available for feeds.");
  toArray()=>throw new RqlDriverError("`toArray` is not available for feeds.");
  toString() => "Instance of 'AtomFeed'";
}

class OrderByLimitFeed extends Cursor{
    OrderByLimitFeed(conn, opts, query):super(conn, opts, query);

    hasNext()=>throw new RqlDriverError("`hasNext` is not available for feeds.");
    toArray()=>throw new RqlDriverError("`toArray` is not available for feeds.");
    toString() => "Instance of 'OrderByLimitFeed'";
}
