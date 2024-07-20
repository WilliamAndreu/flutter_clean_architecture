import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:rickmorty/layers/domain/usecase/characters/filter_characters_by_name.dart';
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart';

class GetAllCharactersMock extends Mock implements GetAllCharacters {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    GetAllCharacters? getAllCharacters,
    FilterCharactersByName? filterCharactersByName
  }) {
    final innerChild = Scaffold(
      body: widget,
    );

    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: getAllCharacters ?? GetAllCharactersMock(),
          ),
          RepositoryProvider.value(
            value: filterCharactersByName ?? FilterCharactersByName(),
          ),
        ],
        child: MaterialApp(
          home: navigator == null
              ? innerChild
              : MockNavigatorProvider(
                  navigator: navigator,
                  child: innerChild,
                ),
        ),
      ),
    );
  }
}
