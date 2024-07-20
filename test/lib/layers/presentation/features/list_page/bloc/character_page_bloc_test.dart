import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickmorty/layers/domain/usecase/characters/filter_characters_by_name.dart';
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart';
import 'package:rickmorty/layers/presentation/features/list_page/bloc/character_page_bloc.dart';

import '../../../../../../mocks/character_mocks.dart';

class MockGetAllCharacters extends Mock implements GetAllCharacters {}
class MockGetAllCharacters2 extends Mock implements  FilterCharactersByName {}


void main() {
  late CharacterPageBloc bloc;
  late GetAllCharacters getAllCharacters;
  late FilterCharactersByName filterCharactersByName;
  


  setUp(() {
    getAllCharacters = MockGetAllCharacters();
 
    filterCharactersByName = MockGetAllCharacters2();
    bloc = CharacterPageBloc(getAllCharacters: getAllCharacters, getCharactersByName: filterCharactersByName);
  });

  group('CharacterPageBloc', () {
    test('initial state is correct', () {
      final initial = bloc.state;
      expect(initial, const CharacterPageState());
    });

    group('.FetchNextPageEvent', () {
      blocTest<CharacterPageBloc, CharacterPageState>(
        'emits loading -> runs UseCase -> emits success with a list',
        build: () => bloc,
        setUp: () {
          when(() => getAllCharacters(page: 1)).thenAnswer(
            (_) async => characterList1,
          );
        },
        act: (bloc) => bloc..add(const FetchNextPageEvent()),
        expect: () => [
          const CharacterPageState(
            status: CharacterPageStatus.loading,
          ),
          CharacterPageState(
            status: CharacterPageStatus.success,
            characters: characterList1,
            hasReachedEnd: false,
            currentPage: 2,
            cacheCharacters: characterList1,
            isFilteredList: false
          ),
        ],
        verify: (_) {
          verify(() => getAllCharacters.call(page: 1));
          verifyNoMoreInteractions(getAllCharacters);
        },
      );

      blocTest<CharacterPageBloc, CharacterPageState>(
        "emits a state with hasReachedEnd 'true' when there are no more items",
        build: () => bloc,
        setUp: () {
          when(() => getAllCharacters(page: 1)).thenAnswer(
            (_) async => const [],
          );
        },
        skip: 1,
        act: (bloc) => bloc..add(const FetchNextPageEvent()),
        expect: () => [
          const CharacterPageState(
            status: CharacterPageStatus.success,
            characters: [],
            hasReachedEnd: true,
            currentPage: 2,
          ),
        ],
      );
    });
  });
}
