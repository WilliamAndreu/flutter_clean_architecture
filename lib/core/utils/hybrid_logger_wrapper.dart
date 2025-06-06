import 'package:hybrid_logger/hybrid_logger.dart';

class HybridLoggerWrapper {
  static final HybridLoggerWrapper _instance = HybridLoggerWrapper._internal();
  final _miraiLogger = HybridLogger(
    settings: HybridSettings(
      type: LogTypeEntity.info,
    ),
  );

  HybridLogger get logger => _miraiLogger;

  factory HybridLoggerWrapper() {
    return _instance;
  }
  HybridLoggerWrapper._internal();
}
