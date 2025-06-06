import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickmorty/layers/presentation/widgets/character_list_item.dart';
import 'package:rickmorty/layers/presentation/features/characters_list/bloc/characters_list_bloc.dart';
import 'package:rickmorty/layers/presentation/features/characters_list/characters_list_page.dart';

import '../../../../../mocks/character_mocks.dart';
import '../../helper/pump_app.dart';

class CharacterBlocMock extends MockBloc<CharactersListEvent, CharacterPageState> implements CharactersListBloc {}

void main() {
  group('CharacterPage', () {
    late GetAllCharactersMock getAllCharactersMock;

    late CharactersListBloc blocMock;

    setUp(() {
      getAllCharactersMock = GetAllCharactersMock();

      blocMock = CharacterBlocMock();

      when(() => getAllCharactersMock.call(page: any(named: 'page')))
          .thenAnswer((_) async => [...characterList1, ...characterList2]);
    });

    testWidgets('renders CharacterView', (tester) async {
      try {
        await tester.pumpApp(
          const CharactersListPage(),
          getAllCharacters: getAllCharactersMock,
        );
        await tester.pumpAndSettle();
      } catch (e) {}

      expectLater(find.byType(CharactersListView), findsOneWidget);
    });

    testWidgets('renders a grid of Characters widgets', (tester) async {
      const key = Key('character_page_list_key');
      when(() => blocMock.state).thenReturn(
        CharacterPageState(
          currentPage: 2,
          status: CharacterPageStatus.success,
          hasReachedEnd: false,
          characters: [...characterList1, ...characterList2],
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: blocMock,
          child: const CharactersListView(),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
      final list = [...characterList1, ...characterList2];
      expectLater(find.byType(CharacterListItem), findsNWidgets(list.length));
    });
  });
}
