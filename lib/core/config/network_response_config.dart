abstract class NetworkResponse {
  NetworkResponse();
}

class NetworkSucced<T> extends NetworkResponse {
  T model;
  NetworkSucced(this.model);
}

class NetworkHttpError extends NetworkResponse {
  String statusMessage;
  NetworkHttpError(this.statusMessage);
}

class NetworkException extends NetworkResponse {
  String exception;
  NetworkException(this.exception);
}
