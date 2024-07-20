import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/core/config/moshi_wrapper.dart';
import 'package:rickmorty/core/utils/custom_bloc_observer.dart';
import 'package:rickmorty/core/utils/navigator_util.dart';
import 'package:rickmorty/layers/presentation/features/list_page/character_page.dart';
import 'package:rickmorty/core/theme/base_theme.dart';

class ContainerApp extends StatefulWidget {
  const ContainerApp({super.key});

  @override
  State<ContainerApp> createState() => _ContainerAppState();
}

class _ContainerAppState extends State<ContainerApp> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    MoshiWrapper().initialize(Navify().currentContext);
    _initialiceThemeMode();
    Bloc.observer = CustomBlocObserver();
  }

  void _initialiceThemeMode() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    themeMode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    const theme = BaseTheme();

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: themeMode,
      navigatorKey: Navify().navigatorKey,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Bloc & Clean Arch',
              ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
              actions: [
                IconButton(
                  onPressed: () => changeThemeMode(),
                  icon: const Icon(Icons.contrast),
                ),
              ],
            ),
            body: const CharacterPage().animate().fadeIn(delay: 1.2.seconds, duration: .7.seconds),
          );
        },
      ),
    );
  }

  void changeThemeMode() => setState(() => themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}
