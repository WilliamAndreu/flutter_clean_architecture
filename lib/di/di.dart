import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rickmorty/di/di.config.dart';

@InjectableInit()
void configureDependencies() => GetIt.instance.init();
