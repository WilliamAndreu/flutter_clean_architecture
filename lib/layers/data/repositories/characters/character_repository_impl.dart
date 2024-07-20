import 'package:dartz/dartz.dart';
import 'package:rickmorty/core/utils/connectivity_service.dart';
import 'package:rickmorty/core/utils/custom_exceptions.dart';
import 'package:rickmorty/core/utils/mirai_wrapper.dart';
import 'package:rickmorty/layers/data/datasource/characters/local/dbo/character_dbo.dart';
import 'package:rickmorty/layers/data/datasource/characters/source/characters_local_datasource.dart';
import 'package:rickmorty/layers/data/datasource/characters/source/characters_remote_datasource.dart';
import 'package:rickmorty/layers/data/repositories/characters/mappers/character_mapper_dbo.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/repository/characters/character_repository.dart';

import 'mappers/character_mapper_dto.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharactersRemoteDataSource _api;
  final CharactersLocalDataSource _localStorage;

  CharacterRepositoryImpl({
    required CharactersRemoteDataSource api,
    required CharactersLocalDataSource localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  @override
  Future<Either<CustomException, List<CharacterEntity>>> getCharacters({int page = 0}) async {
    MiraiWrapper().logger.stackTrx(StackTrace.current);

    final cachedList = _localStorage.loadCharactersPage(page: page);
    if (cachedList.isNotEmpty) {
      return right(cachedList.map((dto) => CharacterMapperDBO.toEntity(dto)).toList());
    }

    if (await ConnectivityServiceImpl().isDisconnected()) return left(NetworkException());

    final response = await _api.loadCharacters(page: page);
    return response.fold(
      (exception) => left(exception),
      (charactersDTO) async {
         List<CharacterDBO> dataDBO = 
          charactersDTO.map((dto) => CharacterMapperDTO.toDBO(dto)).toList();
        await _localStorage.saveCharactersPage(page: page, list: dataDBO);
        return right(charactersDTO.map((dto) => CharacterMapperDTO.toEntity(dto)).toList());
      },
    );
  }
}
