part of 'character_details_bloc.dart';

class CharacterDetailsData {
  final CharacterEntity character;

  CharacterDetailsData({required this.character});
}

sealed class CharacterDetailsState {
  late final CharacterDetailsData data;

  CharacterDetailsState({required CharacterEntity character}) {
    data = CharacterDetailsData(character: character);
  }
}

final class CharacterDetailsInitial extends CharacterDetailsState {
  CharacterDetailsInitial({required super.character});
}
