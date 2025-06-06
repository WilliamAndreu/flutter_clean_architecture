import 'package:flutter/material.dart';
import 'package:rickmorty/core/utils/hybrid_logger_wrapper.dart';

class CustomFlutterErrorHandler {
  static Future<void> initialize() async {}

  static void onErrorDetails(FlutterErrorDetails details) {
    HybridLoggerWrapper().logger.error('$details', header: 'Flutter Error Details');
  }

  static void onError(dynamic error, dynamic stack) {
    HybridLoggerWrapper().logger.stackTrx(stack, header: 'Error: $error');
  }
}
