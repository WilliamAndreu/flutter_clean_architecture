import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rickmorty/core/exceptions/app_exceptions.dart';
import 'package:rickmorty/core/utils/hybrid_logger_wrapper.dart';

@Injectable()
class AppExceptionHandler {
  AppException handle({required Object? exception, required StackTrace stackTrx}) {
    HybridLoggerWrapper().logger.error(exception.toString(), stack: stackTrx, header: 'AppExceptionHandler');

    if (exception is SocketException) {
      return const NoInternetException();
    }

    if (exception is DioException) {
      if (exception.error is SocketException) {
        return const NoInternetException();
      }

      return ServerException(data: exception);
    }

    return GenericException();
  }
}
