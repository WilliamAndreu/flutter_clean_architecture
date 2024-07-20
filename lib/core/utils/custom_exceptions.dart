import 'dart:developer';

class CustomException implements Exception {
  final String message;

  CustomException(this.message) {
    log(message);
  }
}

class NetworkException extends CustomException {
  NetworkException() : super('Network error');
}
