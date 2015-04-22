library EventEmitter;
   
class EventEmitter{

  int _maxListeners = -1;
  Map<String, List> _events = {};
  
  on(String evt, Function listener){
    if (_maxListeners > 0 && _events[evt] != null && _events[evt].length >= _maxListeners) {
      throw new Exception("$evt already has the maximum number of listeners");
    }else
      _events.putIfAbsent(evt,()=>[]).add(listener);
  }
  
  addListener(String evt, Function listener) => on(evt,listener);
  
  once(String evt, Function listener){
  var l;
  l = (args){
    listener(args);
    removeListener(evt,l);
  };
  on(evt,l);
  }
  
  removeListener(String evt, Function listener){
    if(_events.containsKey(evt)){
      int index = _events[evt].indexOf(listener);
      if(index >= 0){
        _events[evt][index] = null;
        if(_events[evt].length == 0){
          _events.remove(evt);
        }
      }
    }
  }
  
  removeAllListeners([String evt]){
    if(evt == null){
      _events.clear();
    }else if(_events.containsKey(evt))
      _events.remove(evt);
  }
  
  void set maxListeners(int n){
    _maxListeners = n;
  }
  
  List listeners(String evt){
    if(_events.containsKey(evt))
      return _events[evt];
    else
      return [];
  }
  
  emit(String evt, var data){
    if(_events.containsKey(evt)){
      _em(_events[evt],data,0);
      if(_events[evt] != null && _events[evt].isEmpty){
        _events.remove(evt);
      }
    }
  }
  
  _em(List evts, var data, int index){
    if(evts.isNotEmpty && index < evts.length){
      if(evts[index] is Function){
        evts[index](data);
      }
      
      if(evts[index] == null){
        evts.removeAt(index);
        _em(evts,data,index);
      }else{
        _em(evts,data,++index);
      }
    }
  }
}