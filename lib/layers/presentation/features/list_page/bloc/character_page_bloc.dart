import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart';
import 'package:stream_transform/stream_transform.dart';
// ignore: always_use_package_imports
import '../../../../domain/usecase/characters/filter_characters_by_name.dart';
part 'character_page_event.dart';
part 'character_page_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterPageBloc extends Bloc<CharacterPageEvent, CharacterPageState> {
  final GetAllCharacters _getAllCharacters;
  final FilterCharactersByName _getCharactersByName;
  CharacterPageBloc({
    required GetAllCharacters getAllCharacters,
    required FilterCharactersByName getCharactersByName,
  })  : _getAllCharacters = getAllCharacters,
        _getCharactersByName = getCharactersByName,
        super(const CharacterPageState()) {
    on<FetchNextPageEvent>(
      _fetchNextPage,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<FilterCharactersByNameEvent>(
      _filterCharactersByName,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  Future<void> _fetchNextPage(
    dynamic event,
    Emitter<CharacterPageState> emit,
  ) async {
    if (state.hasReachedEnd) return;

    emit(state.copyWith(status: CharacterPageStatus.loading));

    final response = await _getAllCharacters(page: state.currentPage);

    response.fold(
      (exception) => emit(
        CharacterPageState.error(),
      ),
      (characters) => emit(
        state.copyWith(
          cacheCharacters: List.of(state.characters)..addAll(characters),
          status: CharacterPageStatus.success,
          characters: List.of(state.characters)..addAll(characters),
          hasReachedEnd: characters.isEmpty,
          currentPage: state.currentPage + 1,
          isFilteredList: false,
          searchText: '',
        ),
      ),
    );
  }

  Future<void> _filterCharactersByName(
    FilterCharactersByNameEvent event,
    Emitter<CharacterPageState> emit,
  ) async {
    emit(state.copyWith(status: CharacterPageStatus.loading));
    List<CharacterEntity> outputList = await _getCharactersByName(
      textSearch: event.textSearch,
      charactersList: state.cacheCharacters,
    );
    emit(
      state.copyWith(
        characters: outputList,
        status: CharacterPageStatus.success,
        isFilteredList: true,
        searchText: event.textSearch,
      ),
    );
  }
}
