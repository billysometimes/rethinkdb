part of rethinkdb;

class RqlError implements Exception{
  String message;
  var term;
  var frames;

  RqlError(this.message, this.term, this.frames);
}

class RqlClientError extends RqlError{
  RqlClientError(String message, term, frames):super(message,term, frames);
}

class RqlCompileError extends RqlError{
    RqlCompileError(String message, term, frames):super(message,term, frames);
}

class RqlRuntimeError extends RqlError{
  RqlRuntimeError(String message, term, frames):super(message,term, frames);
}
class RqlDriverError implements Exception{
    String message;
    RqlDriverError(this.message);

    toString() => message;
}

