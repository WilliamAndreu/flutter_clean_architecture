import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mirai_trace_logger/mirai_logger.dart';
import 'package:rickmorty/core/utils/mirai_wrapper.dart';

class CustomInterceptor extends Interceptor {
  final _requestQueue = <Future<dynamic>>[];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    MiraiWrapper().logger.httpRequest(MiraiHttpRequest(path: options.path, method: options.method));

    await Future.wait(_requestQueue);
    _requestQueue.add(_handleRequest(options, handler));
  }

  Future<void> _handleRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const maxRetries = 3;
    int retryCount = 0;
    DioException er = DioException(requestOptions: options);
    while (retryCount < maxRetries) {
      try {
        Response<dynamic> response = await Dio().request(
          options.path,
          options: Options(
            method: options.method,
            headers: options.headers,
            contentType: options.contentType,
          ),
          data: options.data,
          queryParameters: options.queryParameters,
        );
        if (response.statusCode == 200) {
          handler.next(options);
          return;
        } else {
          retryCount++;
        }
      } on DioException catch (error) {
        retryCount++;
        er = error;
        er.requestOptions.extra['retryCount'] = retryCount;
        await Future.delayed(const Duration(seconds: 3), () => null);
      }
    }
    handler.reject(er);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    MiraiWrapper().logger.httpResponse(MiraiHttpResponse(statusCode: response.statusCode.toString()));

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    MiraiWrapper().logger.httpError(
          MiraiHttpError(
            path: err.response!.requestOptions.path.toString(),
            statusCode: err.response!.requestOptions.queryParameters.toString(),
            statusMessage: err.response?.statusMessage.toString(),
          ),
        );
    handler.reject(err);
  }
}
