import 'package:injectable/injectable.dart';
import 'package:rickmorty/core/exceptions/app_exceptions.dart';
import 'package:rickmorty/layers/domain/exception/characters/characters_exceptions.dart';

@Injectable()
class CharactersExceptionHandler {
  CharactersException handle(AppException exception) {
    if (exception is ServerException && exception.data?.response?.statusCode == 410) {
      return const CharactersEndpointGoneException();
    }

    return CharactersGenericException();
  }
}
