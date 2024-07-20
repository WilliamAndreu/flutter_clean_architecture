import 'package:mocktail/mocktail.dart';
import 'package:rickmorty/layers/data/datasource/characters/source/characters_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import '../../../../../mocks/character_mocks.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late LocalStorageImpl localStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() async {
    mockSharedPreferences = MockSharedPreferences();
    localStorage = LocalStorageImpl(sharedPreferences: mockSharedPreferences);
  });

  group('LocalStorageImpl', () {
    test('should save a list of CharacterDto per page', () async {
      when(() => mockSharedPreferences.setStringList(any(), any()))
          .thenAnswer((_) async => true);

      final result1 = await localStorage.saveCharactersPage(
        page: 1,
        list: characterList1,
      );
      expect(result1, true);
      final key1 = LocalStorageImpl.getKeyToPage(1);
      final list1Raw = characterList1.map((e) => e.toRawJson()).toList();
      verify(() => mockSharedPreferences.setStringList(key1, list1Raw))
          .called(1);

      final result2 = await localStorage.saveCharactersPage(
        page: 2,
        list: characterList2,
      );
      expect(result2, true);
      final key2 = LocalStorageImpl.getKeyToPage(2);
      final list2Raw = characterList2.map((e) => e.toRawJson()).toList();
      verify(() => mockSharedPreferences.setStringList(key2, list2Raw))
          .called(1);

      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should load a list of CharacterDto per page', () {
      final key1 = LocalStorageImpl.getKeyToPage(1);
      when(() => mockSharedPreferences.getStringList(key1)).thenReturn(
        characterList1.map((e) => e.toRawJson()).toList(),
      );

      final result1 = localStorage.loadCharactersPage(page: 1);

      expect(result1, hasLength(2));
      for (int i = 0; i < characterList1.length; i++) {
        expect(result1[i], characterList1[i]);
      }
      verify(() => mockSharedPreferences.getStringList(key1)).called(1);

      final key2 = LocalStorageImpl.getKeyToPage(2);
      when(() => mockSharedPreferences.getStringList(key2)).thenReturn(
        characterList2.map((e) => e.toRawJson()).toList(),
      );

      final result2 = localStorage.loadCharactersPage(page: 2);

      expect(result2, hasLength(2));
      for (int i = 0; i < characterList2.length; i++) {
        expect(result2[i], characterList2[i]);
      }
      verify(() => mockSharedPreferences.getStringList(key2)).called(1);

      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
