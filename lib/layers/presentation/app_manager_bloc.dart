import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/layers/data/repositories/characters/character_repository_impl.dart';
import 'package:rickmorty/layers/domain/usecase/characters/filter_characters_by_name.dart';
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart';
import 'package:rickmorty/layers/presentation/container_app.dart';
import 'package:rickmorty/main.dart';
import '../data/datasource/characters/local/characters_local_datasource_imp.dart';
import '../data/datasource/characters/remote/characters_remote_datasource_imp.dart';

class BlocAppManager extends StatelessWidget {
  const BlocAppManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GetAllCharacters>(
          create: (context) => GetAllCharacters(
            repository: CharacterRepositoryImpl(
              api: ApiImpl(),
              localStorage: CharactersLocalDataSourceImp(sharedPreferences: sharedPref),
            ),
          ),
        ),
        RepositoryProvider<FilterCharactersByName>(
          create: (context) => FilterCharactersByName(),
        ),
      ],
      child: const ContainerApp(),
    );
  }
}
