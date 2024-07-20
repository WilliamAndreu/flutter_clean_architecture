import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rickmorty/core/utils/custom_error_handler.dart';
import 'package:rickmorty/layers/presentation/app_manager_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  Animate.restartOnHotReload = true;

  await CustomErrorHandler.initialize();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    CustomErrorHandler.onErrorDetails(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    CustomErrorHandler.onError(error, stack);
    return true;
  };

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'lib/core/assets/translations',
      fallbackLocale: const Locale('es'),
      child: const BlocAppManager(),
    ),
  );
}
