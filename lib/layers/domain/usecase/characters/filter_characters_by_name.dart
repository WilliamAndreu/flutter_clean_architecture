import 'package:injectable/injectable.dart';
import 'package:rickmorty/core/utils/hybrid_logger_wrapper.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

@Injectable()
class FilterCharactersByName {
  FilterCharactersByName();

  Future<List<CharacterEntity>> call({
    required String textSearch,
    required List<CharacterEntity> charactersList,
  }) async {
    HybridLoggerWrapper().logger.stackTrx(StackTrace.current);
    return charactersList.where((o) => o.name!.toLowerCase().contains(textSearch.toLowerCase())).toList();
  }
}
