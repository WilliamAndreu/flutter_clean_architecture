import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rickmorty/core/exceptions/app_exceptions.dart';
import 'package:rickmorty/core/exceptions/custom_exception.dart';
import 'package:rickmorty/core/utils/navigator_util.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart';
import 'package:rickmorty/layers/presentation/features/character_details/character_details_page.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../../domain/usecase/characters/filter_characters_by_name.dart';
part 'characters_list_event.dart';
part 'characters_list_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharactersListBloc extends Bloc<CharactersListEvent, CharactersListState> {
  final GetAllCharacters _getAllCharacters;
  final FilterCharactersByName _getCharactersByName;

  final Navify _navify;

  CharactersListBloc({
    required GetAllCharacters getAllCharacters,
    required FilterCharactersByName getCharactersByName,
    required Navify navify,
  })  : _getAllCharacters = getAllCharacters,
        _getCharactersByName = getCharactersByName,
        _navify = navify,
        super(CharactersListInitial()) {
    on<CharactersListFetchNextPage>(
      _onCharactersListFetchNextPage,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<CharactersListSearchPerformed>(
      _onCharactersListSearchPerformed,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<CharactersListItemPressed>(
      _onCharactersListItemPressed,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  FutureOr<void> _onCharactersListFetchNextPage(
    dynamic event,
    Emitter<CharactersListState> emit,
  ) async {
    if (state.data.hasReachedEnd) return;

    emit(CharactersListLoading(stateData: state.data, isFullScreenLoading: state.data.currentPage == 1));
    try {
      final characters = await _getAllCharacters(page: state.data.currentPage);

      emit(
        CharactersListSuccess(
          stateData: state.data.copyWith(
            cacheCharacters: List.of(state.data.characters)..addAll(characters),
            characters: List.of(state.data.characters)..addAll(characters),
            hasReachedEnd: characters.isEmpty,
            currentPage: state.data.currentPage + 1,
            isFilteredList: false,
            searchText: '',
          ),
        ),
      );
    } catch (e) {
      final error = e is CustomException ? e : GenericException();
      emit(CharactersListFailure(stateData: state.data, error: error));
    }
  }

  FutureOr<void> _onCharactersListSearchPerformed(
    CharactersListSearchPerformed event,
    Emitter<CharactersListState> emit,
  ) async {
    emit(CharactersListLoading(stateData: state.data));
    List<CharacterEntity> outputList = await _getCharactersByName(
      textSearch: event.textSearch,
      charactersList: state.data.cacheCharacters,
    );
    emit(
      CharactersListSuccess(
        stateData: state.data.copyWith(
          characters: outputList,
          isFilteredList: true,
          searchText: event.textSearch,
        ),
      ),
    );
  }

  FutureOr<void> _onCharactersListItemPressed(CharactersListItemPressed event, Emitter<CharactersListState> emit) {
    _navify.navigateTo(CharacterDetailsPage(character: event.character));
  }
}
