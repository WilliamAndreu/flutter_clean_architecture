import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rickmorty/core/exceptions/app_exceptions.dart';
import 'package:rickmorty/core/utils/navigator_util.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/exception/characters/characters_exceptions.dart';
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart';
import 'package:rickmorty/layers/presentation/features/characters_list/widgets/characters_list_searchbar.dart';
import 'package:rickmorty/layers/presentation/widgets/character_list_item.dart';
import 'package:rickmorty/layers/presentation/widgets/character_list_item_loading.dart';
import 'package:rickmorty/layers/presentation/features/characters_list/bloc/characters_list_bloc.dart';
import 'package:rickmorty/layers/domain/usecase/characters/filter_characters_by_name.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersListBloc(
        getAllCharacters: GetIt.instance.get<GetAllCharacters>(),
        getCharactersByName: GetIt.instance.get<FilterCharactersByName>(),
        navify: Navify(),
      )..add(const CharactersListFetchNextPage()),
      child: const CharactersListView(),
    );
  }
}

class CharactersListView extends StatefulWidget {
  const CharactersListView({super.key});

  @override
  State<CharactersListView> createState() => _CharactersListViewState();
}

class _CharactersListViewState extends State<CharactersListView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  CharactersListBloc get _bloc => context.read<CharactersListBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: CharactersListSearchbar(
                textController: textController,
              ),
            ),
            Expanded(
              child: BlocBuilder<CharactersListBloc, CharactersListState>(
                builder: (context, state) => _bodyByState(state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyByState(CharactersListState state) {
    return switch (state) {
      CharactersListInitial() => _loadingBody(),
      CharactersListLoading loading => loading.isFullScreenLoading ? _loadingBody() : _loadedBody(state),
      CharactersListSuccess() => _loadedBody(state),
      CharactersListFailure failure => _errorBody(failure),
    };
  }

  Widget _loadingBody() {
    return Padding(
      padding: EdgeInsets.only(bottom: kToolbarHeight),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _loadedBody(CharactersListState state) {
    final characters = state.data.characters;
    return ListView.builder(
      key: const ValueKey('character_page_list_key'),
      controller: _scrollController,
      itemCount: state.data.hasReachedEnd ? characters.length : characters.length + 1,
      itemBuilder: (context, index) {
        if (index >= characters.length) {
          return (!state.data.hasReachedEnd && !state.data.isFilteredList)
              ? const CharacterListItemLoading()
              : const SizedBox();
        }
        final item = characters[index];
        return index == 0
            ? Column(
                children: [
                  CharacterListItem(item: item, onTap: _goToDetails),
                ],
              )
            : CharacterListItem(item: item, onTap: _goToDetails);
      },
    );
  }

  Widget _errorBody(CharactersListFailure state) {
    if (state.error is CharactersEndpointGoneException || state.error is NoInternetException) {
      return Center(
        child: Text(
          state.error.message,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return _loadedBody(state);
  }

  void _goToDetails(CharacterEntity character) {
    _bloc.add(CharactersListItemPressed(character));
  }

  void _onScroll() {
    var fireEvent = _bloc.state.data.isFilteredList;
    if (_isBottom && !fireEvent) {
      _bloc.add(const CharactersListFetchNextPage());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
