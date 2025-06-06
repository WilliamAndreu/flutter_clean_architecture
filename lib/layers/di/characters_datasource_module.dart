import 'package:injectable/injectable.dart';
import 'package:rickmorty/core/config/moshi_wrapper.dart';
import 'package:rickmorty/layers/data/datasource/characters/remote/characters_remote_datasource_imp.dart';
import 'package:rickmorty/layers/data/datasource/characters/source/characters_local_datasource.dart';
import 'package:rickmorty/layers/data/datasource/characters/source/characters_remote_datasource.dart';
import 'package:rickmorty/main.dart';

import '../data/datasource/characters/local/characters_local_datasource_imp.dart';

@module
abstract class CharactersDatasourceModule {
  CharactersLocalDataSource get charactersLocalDataSource => CharactersLocalDataSourceImp(
        sharedPreferences: sharedPref,
      );

  CharactersRemoteDataSource get charactersRemoteDataSource => ApiImpl(
        moshi: MoshiWrapper(),
      );
}
