import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/layers/presentation/features/characters_list/bloc/characters_list_bloc.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class CharactersListSearchbar extends StatelessWidget {
  final TextEditingController textController;

  const CharactersListSearchbar({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return SearchBarAnimation(
      durationInMilliSeconds: 300,
      textEditingController: textController,
      isOriginalAnimation: false,
      enableKeyboardFocus: true,
      onExpansionComplete: () {},
      onCollapseComplete: () {},
      onPressButton: (isSearchBarOpens) {},
      onChanged: (String searchText) {
        if (searchText.isNotEmpty) {
          context.read<CharactersListBloc>().add(CharactersListSearchPerformed(searchText));
        } else {
          context.read<CharactersListBloc>().add(const CharactersListFetchNextPage());
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
    );
  }
}
