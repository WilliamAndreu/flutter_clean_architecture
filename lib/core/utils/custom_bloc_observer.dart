import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rickmorty/core/utils/mirai_wrapper.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    MiraiWrapper()
        .logger
        .info('onChange(${bloc.runtimeType})', header: 'Bloc Change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    MiraiWrapper().logger.error(
        'onError(${bloc.runtimeType}, $error, $stackTrace)',
        header: 'Bloc Error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    MiraiWrapper()
        .logger
        .info('onEvent(${bloc.runtimeType}, $event)', header: 'Bloc Event');
  }
}
