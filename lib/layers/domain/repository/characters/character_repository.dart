import 'package:dartz/dartz.dart';
import 'package:rickmorty/core/utils/custom_exceptions.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<CustomException, List<CharacterEntity>>> getCharacters({int page = 0});
}
