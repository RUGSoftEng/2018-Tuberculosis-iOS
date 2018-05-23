class ApiResult<T> {
  final bool success;
  final T result;
  final String error;

  ApiResult(this.result, this.error) : success = result != null;
}