import 'package:mirai_trace_logger/mirai_logger.dart';

class MiraiWrapper {
  static final MiraiWrapper _instance = MiraiWrapper._internal();
  final _miraiLogger = MiraiTraceLogger(
    settings: MiraiSettings(
      type: LogTypeEntity.info,
    ),
  );

  MiraiTraceLogger get logger => _miraiLogger;

  factory MiraiWrapper() {
    return _instance;
  }
  MiraiWrapper._internal();
}
