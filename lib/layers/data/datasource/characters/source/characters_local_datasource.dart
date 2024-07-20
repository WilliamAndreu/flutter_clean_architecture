import 'package:rickmorty/layers/data/datasource/characters/local/dbo/character_dbo.dart';

/// A constant variable that represents the key for caching the character list page.
const cachedCharacterListKey = 'CACHED_CHARACTER_LIST_PAGE';

/// An abstract class that defines the contract for local storage operations related to characters.
abstract class CharactersLocalDataSource {
  /// Saves the specified character list page to the local storage.
  ///
  /// @param page The page number of the character list.
  /// @param list The list of character data transfer objects to be saved.
  /// @return A Future that completes with a boolean value indicating whether the operation was successful.
  Future<bool> saveCharactersPage({
    required int page,
    required List<CharacterDBO> list,
  });

  /// Loads the character list page from the local storage.
  ///
  /// @param page The page number of the character list to be loaded.
  /// @return The list of character data transfer objects loaded from the local storage.
  List<CharacterDBO> loadCharactersPage({required int page});
}

