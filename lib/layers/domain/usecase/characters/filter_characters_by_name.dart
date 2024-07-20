import 'package:rickmorty/core/utils/mirai_wrapper.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

class FilterCharactersByName {
  FilterCharactersByName();

  Future<List<CharacterEntity>> call({
    required String textSearch,
    required List<CharacterEntity> charactersList,
  }) async {
    MiraiWrapper().logger.stackTrx(StackTrace.current);
    return charactersList.where((o) => o.name!.toLowerCase().contains(textSearch.toLowerCase())).toList();
  }
}
