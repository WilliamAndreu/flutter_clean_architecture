import '../remote/dto/character_dto.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterDTO>> loadCharacters({int page = 0});
}
