part of rethinkdb;

class Query extends RqlQuery{
    p.Query_QueryType _type;
    int _token;
    RqlQuery _term;
    Map _global_optargs;
    final Completer _queryCompleter = new Completer();

    Query(p.Query_QueryType this._type, int this._token, [RqlQuery this._term, Map this._global_optargs]);

    serialize(){
        List res = [_type.value];
        if(_term != null){
          res.add(_term.build());
        }
        if(_global_optargs != null){
            Map optargs = {};
            _global_optargs.forEach((k,v){
              optargs[k] = v is RqlQuery ? v.build() : v.value;
            });

            res.add(optargs);
        }
        return JSON.encode(res);
    }
}

class Response{
    int _token;
    int _type;
    var _data;
    var _backtrace;
    var _profile;
    Response(int this._token,String json_str){
        if(json_str.length > 0){
        Map full_response = JSON.decode(json_str);
        this._type = full_response["t"];
        this._data = full_response["r"];
        this._backtrace = full_response["b"];
        this._profile = full_response["p"];
        }
    }
}

class Cursor{

    Connection _conn;
    Query _query;
    Map _opts;
    List<Response> _responses = [];
    int _outstanding_requests = 0;
    bool _end_flag = false;
    bool _connection_closed = false;

    Cursor(Connection this._conn,Query this._query,Map this._opts);

    _extend(Response response){
        _end_flag = response._type != p.Response_ResponseType.SUCCESS_PARTIAL.value && response._type != p.Response_ResponseType.SUCCESS_FEED.value;
        _responses.add(response);
    }



    each(Function cb, [Function onDone]){
      if(_responses.length >0){
      _conn._check_error_response(_responses[0], _query._term);
      if(_responses[0]._type != p.Response_ResponseType.SUCCESS_PARTIAL.value &&
         _responses[0]._type != p.Response_ResponseType.SUCCESS_SEQUENCE.value &&
         _responses[0]._type != p.Response_ResponseType.SUCCESS_FEED.value)
           cb(new RqlDriverError("Unexpected response type received for cursor"),null);
      }

      if(_responses.length == 0 && _connection_closed)
        cb(new RqlDriverError("Connection closed, cannot read cursor"),null);


      if(_responses.length == 1){
        List response_data = recursively_convert_pseudotypes(_responses.removeAt(0)._data, _opts);
        response_data.forEach((var e){
          cb(null,e);
        });
      }


      if(_responses.length == 0 && !_end_flag){

        Query query = new Query(p.Query_QueryType.CONTINUE, this._query._token, null, null);
        _conn._sendQueue.addLast(query);
        _conn._send_query().then((res){
          each(cb,onDone);
        });
      }

      if (_responses.length == 0 && _end_flag)
      {
        if(onDone != null){
          onDone();
        }
      }

    }

    next(){
      Completer c = new Completer();
      if(_responses.length >0){
            _conn._check_error_response(_responses[0], _query._term);
            if(_responses[0]._type != p.Response_ResponseType.SUCCESS_PARTIAL.value &&
               _responses[0]._type != p.Response_ResponseType.SUCCESS_SEQUENCE.value &&
               _responses[0]._type != p.Response_ResponseType.SUCCESS_FEED.value)
                 c.completeError(new RqlDriverError("Unexpected response type received for cursor"));
      }
      if(_responses.length == 0 && _connection_closed){
             c.completeError(new RqlDriverError("Connection closed, cannot read cursor"));

      }else if(_responses.length == 1){
         c.complete(recursively_convert_pseudotypes(_responses.removeAt(0)._data, _opts));
      }else if(_responses.length == 0 && !_end_flag){

        Query query = new Query(p.Query_QueryType.CONTINUE, this._query._token, null, null);
        _conn._sendQueue.addLast(query);
        _conn._send_query().then((res){
          c.complete(next());
        });
      }
      return c.future;
    }

    toArray(){
      Completer c = new Completer();
      List results = [];
      this.each((err,row) {
         results.add(row);
      },(){c.complete(results);});

      return c.future;

    }

    close(){
        if(!_end_flag){
            _end_flag = true;
            Query query = new Query(p.Query_QueryType.STOP, this._query._token, null, null);
            _conn._sendQueue.addLast(query);
            _conn._send_query();
        }
    }
}

class Connection {

    Socket _socket = null;
    int _next_token = 1;
    String _host;
    int _port;
    String _db;
    String _auth_key;
    Map<int,Cursor> _cursor_cache = {};

    Completer _completer = new Completer();

    int _response_length = 0;
    List<int> _response_buffer = [];

    final Map _replyQueries = new Map();
    final Queue<Query> _sendQueue = new Queue<Query>();

    final Map <String, List> _listeners = new Map<String, List>();


    Connection(String this._db, String this._host, int this._port, String this._auth_key);

    use(String db){
        _db = db;
    }

    Future<Connection> connect([bool noreply_wait=true]){
      return(_reconnect(noreply_wait));
    }
    Future<Connection> _reconnect([bool noreply_wait=true]){

        close(noreply_wait);

        if(_listeners["connect"] != null)
          _listeners["connect"].forEach((func)=>func());

        Socket.connect(_host, _port).then((socket) {
                _socket = socket;
                _socket.listen(_handleResponse);
                _socket.add(_toBytes(p.VersionDummy_Version.V0_3.value));
                List<int> authInfo = [];
                authInfo.addAll(_toBytes(_auth_key.length));
                authInfo.addAll(_auth_key.codeUnits);
                _socket.add(authInfo);
                _socket.add(_toBytes(p.VersionDummy_Protocol.JSON.value));


              }).catchError((err)=>throw new RqlDriverError("Could not connect to $_host:$_port.  Error $err"));
        return _completer.future;
    }

    _handleResponse(List<int> bytes){
      if(!_completer.isCompleted){
        _handleAuthResponse(bytes);
      }else{
        _handleQueryResponse(bytes);
      }
    }

    _handleAuthResponse(List<int> res){
      List<int> response = [];
      for(final byte in res){
        if(byte == 0){
          break;
        }
        response.add(byte);
      }
      String responseString = UTF8.decode(response);
      if(responseString != "SUCCESS"){
        Exception error = new RqlDriverError("Server dropped connection with message: $response");
        if(_listeners["error"] != null)
          _listeners["error"].forEach((func)=>func(error));
        _completer.completeError(error);
      }else{
        _completer.complete(this);
      }

    }

    _handleQueryResponse(List<int> res){
      var response = _read_response(res);
      if(response is Response){
        Query query = _replyQueries.remove(response._token);

        Exception hasError = _check_error_response(response,query._term);
        if(hasError != null){
          query._queryCompleter.completeError(hasError);
        }
        var value;

        if(response._type == p.Response_ResponseType.SUCCESS_PARTIAL.value ||
               response._type == p.Response_ResponseType.SUCCESS_SEQUENCE.value ||
               response._type == p.Response_ResponseType.SUCCESS_FEED.value){

                value = new Cursor(this, query,{});
                _cursor_cache[query._token] = value;
                value._extend(response);
      }else if(response._type == p.Response_ResponseType.SUCCESS_ATOM.value){
        if(response._data.length < 1){
        value = null;
        }
        value = recursively_convert_pseudotypes(response._data[0], null);

      }else if(response._type == p.Response_ResponseType.WAIT_COMPLETE.value){
        //Noreply_wait response
        value = null;
      }else{

        if(!query._queryCompleter.isCompleted)
          query._queryCompleter.completeError(new RqlDriverError("Error: ${response._data}."));
      }

      if(response._profile != null)
        value = {"value": value, "profile": response._profile};
      if(!query._queryCompleter.isCompleted)
        query._queryCompleter.complete(value);
      }
    }

    close([bool noreply_wait=true]){
      if(_listeners["close"] != null)
        _listeners["close"].forEach((func)=>func());

        if(_socket != null){
            if(noreply_wait)
              noreplyWait();
            try{
                _socket.close();
            }catch(err){

            }

            _socket.destroy();
            _socket = null;
        }

        _cursor_cache.forEach((token,cursor){
          cursor._end_flag = true;
          cursor._connection_closed = true;
        });

        _cursor_cache = {};

    }

    /**
  * Alias for addListener
  */
    void on(String key, Function val)
    {
      addListener(key,val);
    }
    /**
  * Adds a listener to the connection.
  */
    void addListener(String key, Function val)
    {
      List currentListeners = [];
      if(_listeners != null && _listeners[key] != null)
        _listeners[key].forEach((element)=>currentListeners.add(element));

      currentListeners.add(val);
      _listeners[key] = currentListeners;
    }

    noreplyWait(){
        int token = _next_token++;

        RqlQuery query = new Query(p.Query_QueryType.NOREPLY_WAIT, token);

        _sendQueue.add(query);
        return _start(query);
    }

    _handle_cursor_response(Response response){
        Cursor cursor = _cursor_cache[response._token];
        cursor._extend(response);
        cursor._outstanding_requests--;

        if(response._type != p.Response_ResponseType.SUCCESS_PARTIAL.value && response._type != p.Response_ResponseType.SUCCESS_FEED.value && cursor._outstanding_requests == 0)
            _cursor_cache.remove(response._token);
    }

    _read_response(res){
        int response_token;
        String response_buf;
        int response_len;

          if(res is List){
            _response_buffer.addAll(res);
          }else
            _response_buffer.add(res);
          _response_length = _response_buffer.length;

        if(_response_length >= 12){

          response_token = _fromBytes(_response_buffer.sublist(0,8));
          response_len = _fromBytes(_response_buffer.sublist(8,12));
          if(_response_length >= response_len+12){
            response_buf = UTF8.decode(_response_buffer.sublist(12,response_len+12));
          }
        }

        if(response_token != null && response_buf != null){
          _response_buffer.removeRange(0, response_len+12);
          _response_length = _response_buffer.length;

          Response response = new Response(response_token, response_buf);



          if(_cursor_cache.containsKey(response._token)){
              _handle_cursor_response(response);
          }
         if(_replyQueries.containsKey(response._token))
              return response;
          else{
              throw new RqlDriverError("Unexpected response received.");
          }

          //if for some reason there are other queries on the line...
          if(_response_length > 0){
            _read_response([]);
          }
       }

    }

    _check_error_response(Response response, RqlQuery term){
        var message;
        var frames;
        if(response._type == p.Response_ResponseType.RUNTIME_ERROR){
            message = response._data[0];
            frames = response._backtrace;
            return new RqlRuntimeError(message, term, frames);
        }else if(response._type == p.Response_ResponseType.COMPILE_ERROR){
            message = response._data[0];
            frames = response._backtrace;
            return new RqlCompileError(message, term, frames);
        }else if(response._type == p.Response_ResponseType.CLIENT_ERROR){
            message = response._data[0];
            frames = response._backtrace;
            return new RqlClientError(message, term, frames);
        }
        return null;
    }

    _send_query(){

          if (!_sendQueue.isEmpty) {


            Query query = _sendQueue.removeFirst();


            // Error if this connection has closed
            if(_socket == null){
                query._queryCompleter.completeError(new RqlDriverError("Connection is closed."));
            }else{

              // Send json
              List  query_str = UTF8.encode(query.serialize());
              List query_header = [];
              query_header.addAll(_toBytes8(query._token));
              query_header.addAll(_toBytes(query_str.length));
              query_header.addAll(query_str);
              _socket.add(query_header);

              _replyQueries[query._token] = query;
              return query._queryCompleter.future;
          }

        }
}

    _start(RqlQuery term, [Map global_optargs]){

        if(global_optargs == null){
          global_optargs = {};
        }
        if(global_optargs['db'] != null){
          global_optargs['db'] = new DB(global_optargs['db']);
        }else{
          global_optargs['db'] = new DB(_db);
        }


        Query query = new Query(p.Query_QueryType.START, _next_token,term, global_optargs);
        _next_token++;
        _sendQueue.addLast(query);
        return _send_query();
    }


Uint8List _toBytes(int data) {
  ByteBuffer buffer = new Uint8List(4).buffer;
  ByteData bdata = new ByteData.view(buffer);
  bdata.setInt32(0, data,Endianness.LITTLE_ENDIAN);
  return new Uint8List.view(buffer);
}

Uint8List _toBytes8(int data){
  ByteBuffer buffer = new Uint8List(8).buffer;
  ByteData bdata = new ByteData.view(buffer);
  bdata.setInt32(0, data,Endianness.LITTLE_ENDIAN);
  return new Uint8List.view(buffer);
}

int _fromBytes(List<int> data){
  Uint8List buf = new Uint8List.fromList(data);
  ByteData bdata = new ByteData.view(buf.buffer);
  return bdata.getInt32(0,Endianness.LITTLE_ENDIAN);
  }

}


