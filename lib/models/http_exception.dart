import 'dart:io';

class HttpStatusException implements HttpException {
  final String message;
  final int statusCode;

  HttpStatusException(this.message, this.statusCode);

  @override
  String toString() {
    return 'HttpStatusException: $message (Status code: $statusCode)';
  }

  @override
  // TODO: implement uri
  Uri? get uri => throw UnimplementedError();
}
