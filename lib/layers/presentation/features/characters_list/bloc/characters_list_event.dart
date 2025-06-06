part of 'characters_list_bloc.dart';

sealed class CharactersListEvent {
  const CharactersListEvent();
}

final class CharactersListFetchNextPage extends CharactersListEvent {
  const CharactersListFetchNextPage();
}

final class CharactersListSearchPerformed extends CharactersListEvent {
  final String textSearch;

  const CharactersListSearchPerformed(this.textSearch);
}

final class CharactersListItemPressed extends CharactersListEvent {
  final CharacterEntity character;

  const CharactersListItemPressed(this.character);
}
