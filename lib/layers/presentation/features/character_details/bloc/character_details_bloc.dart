import 'package:bloc/bloc.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

part 'character_details_event.dart';

part 'character_details_state.dart';

class CharacterDetailsBloc extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc({required CharacterEntity character}) : super(CharacterDetailsInitial(character: character));
}
