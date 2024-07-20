part of 'character_page_bloc.dart';

enum CharacterPageStatus { initial, loading, success, failure }

class CharacterPageState extends Equatable {
  const CharacterPageState({
    this.status = CharacterPageStatus.initial,
    this.characters = const [],
    this.cacheCharacters = const [],
    this.hasReachedEnd = false,
    this.isFilteredList = false,
    this.currentPage = 1,
    this.searchText = '',
  });

  final CharacterPageStatus status;
  final List<CharacterEntity> characters;
  final List<CharacterEntity> cacheCharacters;
  final bool hasReachedEnd;
  final bool isFilteredList;
  final int currentPage;
  final String searchText;

  factory CharacterPageState.error() {
    return const CharacterPageState(
      cacheCharacters: [],
      status: CharacterPageStatus.failure,
      characters: [],
      hasReachedEnd: true,
      currentPage: 0,
      isFilteredList: false,
      searchText: '',
    );
  }

  CharacterPageState copyWith({
    CharacterPageStatus? status,
    List<CharacterEntity>? cacheCharacters,
    List<CharacterEntity>? characters,
    bool? hasReachedEnd,
    bool? isFilteredList,
    int? currentPage,
    String? searchText,
  }) {
    return CharacterPageState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      cacheCharacters: cacheCharacters ?? this.cacheCharacters,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      isFilteredList: isFilteredList ?? this.isFilteredList,
      currentPage: currentPage ?? this.currentPage,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object> get props => [
        status,
        characters,
        cacheCharacters,
        hasReachedEnd,
        isFilteredList,
        currentPage,
        searchText,
      ];
}
