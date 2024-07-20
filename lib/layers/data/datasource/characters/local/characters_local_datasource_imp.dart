import 'package:flutter/foundation.dart';
import 'package:rickmorty/core/utils/mirai_wrapper.dart';
import 'package:rickmorty/layers/data/datasource/characters/local/dbo/character_dbo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../source/characters_local_datasource.dart';

/// A constant variable that represents the key for caching the character list page.
const cachedCharacterListKey = 'CACHED_CHARACTER_LIST_PAGE';


/// An implementation of the LocalStorage interface that uses SharedPreferences for local storage operations.
class CharactersLocalDataSourceImp implements CharactersLocalDataSource {
  final SharedPreferences _sharedPref;

  /// Constructs a LocalStorageImpl instance with the specified SharedPreferences.
  ///
  /// @param sharedPreferences The SharedPreferences instance to be used for local storage operations.
  CharactersLocalDataSourceImp({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;

  @override
  List<CharacterDBO> loadCharactersPage({required int page}) {
    MiraiWrapper().logger.stackTrx(StackTrace.current);

    final key = getKeyToPage(page);
    final jsonList = _sharedPref.getStringList(key);

    return jsonList != null ? jsonList.map((e) => CharacterDBO.fromRawJson(e)).toList() : [];
  }

  @override
  Future<bool> saveCharactersPage({
    required int page,
    required List<CharacterDBO> list,
  }) {
    final jsonList = list.map((e) => e.toRawJson()).toList();
    final key = getKeyToPage(page);
    return _sharedPref.setStringList(key, jsonList);
  }

  /// Returns the key for the specified character list page.
  ///
  /// @param page The page number of the character list.
  /// @return The key for the specified character list page.
  @visibleForTesting
  static String getKeyToPage(int page) {
    MiraiWrapper().logger.stackTrx(StackTrace.current);

    return '${cachedCharacterListKey}_$page';
  }
}
