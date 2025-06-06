import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters({int page = 0});
}
