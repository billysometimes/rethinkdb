part of rethinkdb;

class RqlError implements Exception {
  String message;
  var term;
  var frames;

  RqlError(this.message, this.term, this.frames);

  toString() => "${this.runtimeType}!\n\n$message\n\n$term\n\n$frames";
}

class RqlClientError extends RqlError {
  RqlClientError(String message, term, frames) : super(message, term, frames);
}

class RqlCompileError extends RqlError {
  RqlCompileError(String message, term, frames) : super(message, term, frames);
}

class RqlRuntimeError extends RqlError {
  RqlRuntimeError(String message, term, frames) : super(message, term, frames);
}

class RqlDriverError implements Exception {
  String message;
  RqlDriverError(this.message);

  toString() => message;
}

class ReqlInternalError extends RqlRuntimeError {
  ReqlInternalError(String message, term, frames)
      : super(message, term, frames);
}

class ReqlResourceLimitError extends RqlRuntimeError {
  ReqlResourceLimitError(String message, term, frames)
      : super(message, term, frames);
}

class ReqlQueryLogicError extends RqlRuntimeError {
  ReqlQueryLogicError(String message, term, frames)
      : super(message, term, frames);
}

class ReqlNonExistenceError extends RqlRuntimeError {
  ReqlNonExistenceError(String message, term, frames)
      : super(message, term, frames);
}

class ReqlOpFailedError extends RqlRuntimeError {
  ReqlOpFailedError(String message, term, frames)
      : super(message, term, frames);
}

class ReqlOpIndeterminateError extends RqlRuntimeError {
  ReqlOpIndeterminateError(String message, term, frames)
      : super(message, term, frames);
}

class ReqlUserError extends RqlRuntimeError {
  ReqlUserError(String message, term, frames) : super(message, term, frames);
}

class ReqlPermissionError extends RqlRuntimeError {
  ReqlPermissionError(String message, term, frames)
      : super(message, term, frames);
}
