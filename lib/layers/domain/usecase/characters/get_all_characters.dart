import 'package:injectable/injectable.dart';
import 'package:rickmorty/core/exceptions/app_exceptions.dart';
import 'package:rickmorty/core/utils/hybrid_logger_wrapper.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/exception/characters/handler/characters_exception_handler.dart';
import 'package:rickmorty/layers/domain/repository/characters/character_repository.dart';

@Injectable()
class GetAllCharacters {
  final CharacterRepository _repository;
  final CharactersExceptionHandler _exceptionHandler;

  GetAllCharacters({
    required CharacterRepository repository,
    required CharactersExceptionHandler exceptionHandler,
  })  : _repository = repository,
        _exceptionHandler = exceptionHandler;

  Future<List<CharacterEntity>> call({int page = 0}) async {
    HybridLoggerWrapper().logger.stackTrx(StackTrace.current);
    try {
      return await _repository.getCharacters(page: page);
    } on AppException catch (error) {
      throw _exceptionHandler.handle(error);
    }
  }
}
