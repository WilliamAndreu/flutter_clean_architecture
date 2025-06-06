import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rickmorty/core/utils/hybrid_logger_wrapper.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    HybridLoggerWrapper()
        .logger
        .info('onChange(${bloc.runtimeType}, ${change.currentState.runtimeType})', header: 'Bloc Change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    HybridLoggerWrapper().logger.error(
          'onError(${bloc.runtimeType}, $error, $stackTrace)',
          header: 'Bloc Error',
        );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    HybridLoggerWrapper().logger.info('onEvent(${bloc.runtimeType}, $event)', header: 'Bloc Event');
  }
}
