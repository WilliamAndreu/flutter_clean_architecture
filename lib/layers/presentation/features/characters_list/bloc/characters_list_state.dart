part of 'characters_list_bloc.dart';

class CharactersListData {
  final List<CharacterEntity> characters;
  final List<CharacterEntity> cacheCharacters;
  final bool hasReachedEnd;
  final bool isFilteredList;
  final int currentPage;
  final String searchText;

  const CharactersListData({
    required this.characters,
    required this.cacheCharacters,
    required this.hasReachedEnd,
    required this.isFilteredList,
    required this.currentPage,
    required this.searchText,
  });

  CharactersListData copyWith({
    List<CharacterEntity>? characters,
    List<CharacterEntity>? cacheCharacters,
    bool? hasReachedEnd,
    bool? isFilteredList,
    int? currentPage,
    String? searchText,
  }) {
    return CharactersListData(
      characters: characters ?? this.characters,
      cacheCharacters: cacheCharacters ?? this.cacheCharacters,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      isFilteredList: isFilteredList ?? this.isFilteredList,
      currentPage: currentPage ?? this.currentPage,
      searchText: searchText ?? this.searchText,
    );
  }
}

sealed class CharactersListState {
  late final CharactersListData data;

  CharactersListState({CharactersListData? stateData}) {
    data = stateData ??
        CharactersListData(
          characters: [],
          cacheCharacters: [],
          hasReachedEnd: false,
          isFilteredList: false,
          currentPage: 1,
          searchText: '',
        );
  }
}

final class CharactersListInitial extends CharactersListState {
  CharactersListInitial();
}

final class CharactersListLoading extends CharactersListState {
  final bool isFullScreenLoading;

  CharactersListLoading({super.stateData, this.isFullScreenLoading = false});
}

final class CharactersListSuccess extends CharactersListState {
  CharactersListSuccess({required super.stateData});
}

final class CharactersListFailure extends CharactersListState {
  final CustomException error;

  CharactersListFailure({required super.stateData, required this.error});
}
