import 'package:dio/dio.dart';
import 'package:rickmorty/core/exceptions/custom_exception.dart';

sealed class AppException<T extends Object?> extends CustomException<T> {
  const AppException({super.data});
}

final class GenericException extends AppException {
  @override
  String get title => 'Error';

  @override
  String get message => 'An error occurred. Please try again later.';

  const GenericException();
}

final class ServerException extends AppException<DioException> {
  @override
  String get title => 'Server Error';

  @override
  String get message => data!.response?.statusMessage ?? 'An error occurred. Please try again later.';

  const ServerException({required super.data});
}

final class NoInternetException extends AppException {
  @override
  String get title => 'No Internet Connection';

  @override
  String get message => 'Please check your internet connection and try again.';

  const NoInternetException();
}
