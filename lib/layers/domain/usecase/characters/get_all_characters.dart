import 'package:dartz/dartz.dart';
import 'package:rickmorty/core/utils/custom_exceptions.dart';
import 'package:rickmorty/core/utils/mirai_wrapper.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/repository/characters/character_repository.dart';

class GetAllCharacters {
  GetAllCharacters({
    required CharacterRepository repository,
  }) : _repository = repository;

  final CharacterRepository _repository;

  Future<Either<CustomException, List<CharacterEntity>>> call({int page = 0}) async {
    MiraiWrapper().logger.stackTrx(StackTrace.current);
    return await _repository.getCharacters(page: page);
  }
}
