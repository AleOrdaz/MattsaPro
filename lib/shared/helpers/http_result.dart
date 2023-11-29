class HttpResult<T> {
  T? data;
  int statusCode;
  final HttpError? error;

  HttpResult(
      {required this.data, required this.statusCode, required this.error});
}

class HttpError {
  final Object? exception;
  final StackTrace stackTrace;
  final dynamic data;

  HttpError(
      {required this.exception, required this.stackTrace, required this.data});
}
