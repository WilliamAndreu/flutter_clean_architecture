import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/core/utils/navigator_util.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart';
import 'package:rickmorty/layers/presentation/widgets/character_list_item.dart';
import 'package:rickmorty/layers/presentation/widgets/character_list_item_loading.dart';
import 'package:rickmorty/layers/presentation/features/details_page/character_details_page.dart';
import 'package:rickmorty/layers/presentation/features/list_page/bloc/character_page_bloc.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:rickmorty/layers/domain/usecase/characters/filter_characters_by_name.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterPageBloc(
        getAllCharacters: context.read<GetAllCharacters>(),
        getCharactersByName: context.read<FilterCharactersByName>(),
      )..add(const FetchNextPageEvent()),
      child: const CharacterView(),
    );
  }
}

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CharacterPageBloc, CharacterPageState, CharacterPageStatus>(
      selector: (state) => state.status,
      bloc: context.read<CharacterPageBloc>(),
      builder: (context, status) {
        if (status == CharacterPageStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }

        return const _Content();
      },
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  final _scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  CharacterPageBloc get pageBloc => context.read<CharacterPageBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<CharacterPageBloc, CharacterPageState>(
      bloc: pageBloc,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: SearchBarAnimation(
                durationInMilliSeconds: 300,
                textEditingController: textController,
                isOriginalAnimation: false,
                enableKeyboardFocus: true,
                onExpansionComplete: () {},
                onCollapseComplete: () {},
                onPressButton: (isSearchBarOpens) {},
                onChanged: (String searchText) {
                  if (searchText.isNotEmpty) {
                    pageBloc.add(FilterCharactersByNameEvent(searchText));
                  } else {
                    pageBloc.add(const FetchNextPageEvent());
                  }
                },
                trailingWidget: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black,
                ),
                secondaryButtonWidget: const Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.black,
                ),
                buttonWidget: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                key: const ValueKey('character_page_list_key'),
                controller: _scrollController,
                itemCount: state.hasReachedEnd ? state.characters.length : state.characters.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.characters.length) {
                    return (!state.hasReachedEnd && !state.isFilteredList)
                        ? const CharacterListItemLoading()
                        : const SizedBox();
                  }
                  final item = state.characters[index];
                  return index == 0
                      ? Column(
                          children: [
                            CharacterListItem(item: item, onTap: _goToDetails),
                          ],
                        )
                      : CharacterListItem(item: item, onTap: _goToDetails);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToDetails(CharacterEntity character) {
    Navify().navigateTo(CharacterDetailsPage(character: character));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    var fireEvent = pageBloc.state.isFilteredList;
    if (_isBottom && !fireEvent) {
      pageBloc.add(const FetchNextPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
