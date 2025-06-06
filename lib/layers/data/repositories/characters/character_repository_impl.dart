import 'package:injectable/injectable.dart';
import 'package:rickmorty/core/exceptions/handler/app_exception_handler.dart';
import 'package:rickmorty/core/utils/hybrid_logger_wrapper.dart';
import 'package:rickmorty/layers/data/datasource/characters/source/characters_local_datasource.dart';
import 'package:rickmorty/layers/data/datasource/characters/source/characters_remote_datasource.dart';
import 'package:rickmorty/layers/data/repositories/characters/mappers/character_mapper_dbo.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/repository/characters/character_repository.dart';

import 'mappers/character_mapper_dto.dart';

@Injectable(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  final CharactersRemoteDataSource _api;
  final CharactersLocalDataSource _localStorage;

  final CharacterMapperDTO _characterMapperDTO;
  final CharacterMapperDBO _characterMapperDBO;

  final AppExceptionHandler _exceptionHandler;

  CharacterRepositoryImpl({
    required CharactersRemoteDataSource api,
    required CharactersLocalDataSource localStorage,
    required CharacterMapperDTO characterMapperDTO,
    required CharacterMapperDBO characterMapperDBO,
    required AppExceptionHandler exceptionHandler,
  })  : _api = api,
        _localStorage = localStorage,
        _characterMapperDTO = characterMapperDTO,
        _characterMapperDBO = characterMapperDBO,
        _exceptionHandler = exceptionHandler;

  @override
  Future<List<CharacterEntity>> getCharacters({int page = 0}) async {
    HybridLoggerWrapper().logger.stackTrx(StackTrace.current);

    try {
      final cachedList = _localStorage.loadCharactersPage(page: page);

      if (cachedList.isNotEmpty) {
        return cachedList.map((dto) => _characterMapperDBO.toEntity(dto)).toList();
      }

      final response = await _api.loadCharacters(page: page);
      final characters = response.map((dto) => _characterMapperDTO.toEntity(dto)).toList();
      final charactersDBO = characters.map((entity) => _characterMapperDBO.toDBO(entity)).toList();

      _localStorage.saveCharactersPage(page: page, list: charactersDBO);

      return characters;
    } catch (error) {
      throw _exceptionHandler.handle(exception: error, stackTrx: StackTrace.current);
    }
  }
}
