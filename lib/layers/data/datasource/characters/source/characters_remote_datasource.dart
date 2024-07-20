import 'package:dartz/dartz.dart';
import 'package:rickmorty/core/utils/custom_exceptions.dart';
import '../remote/dto/character_dto.dart';

abstract class CharactersRemoteDataSource {
  Future<Either<CustomException, List<CharacterDTO>>> loadCharacters(
      {int page = 0});
}
