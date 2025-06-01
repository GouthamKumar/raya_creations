enum StatusCodes {
  success(200),
  created(201),
  networkError(408),
  unexpectedClientError(400),
  unexpectedServerError(500);

  final int code;
  const StatusCodes(this.code);
}