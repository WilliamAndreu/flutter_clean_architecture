import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rickmorty/core/utils/custom_flutter_error_handler.dart';
import 'package:rickmorty/di/di.dart';
import 'package:rickmorty/layers/presentation/container_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  Animate.restartOnHotReload = true;

  await initializeDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'lib/core/assets/translations',
      fallbackLocale: const Locale('es'),
      child: const ContainerApp(),
    ),
  );
}

Future<void> initializeDependencies() async {
  configureDependencies();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  await CustomFlutterErrorHandler.initialize();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    CustomFlutterErrorHandler.onErrorDetails(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    CustomFlutterErrorHandler.onError(error, stack);
    return true;
  };
}
