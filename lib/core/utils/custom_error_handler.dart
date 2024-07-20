import 'package:flutter/material.dart';
import 'package:rickmorty/core/utils/mirai_wrapper.dart';

class CustomErrorHandler {
  static Future<void> initialize() async {}

  static void onErrorDetails(FlutterErrorDetails details) {
    MiraiWrapper().logger.error('$details', header: 'Flutter Error Details');
  }

  static void onError(dynamic error, dynamic stack) {
    MiraiWrapper().logger.stackTrx(stack, header: 'Error: $error');
  }
}
