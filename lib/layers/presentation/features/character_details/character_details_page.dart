import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/core/assets/translations/internationalize.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/layers/presentation/features/character_details/bloc/character_details_bloc.dart';
import 'package:rickmorty/core/styles/custom_text_styles.dart';

class CharacterDetailsPage extends StatelessWidget {
  final CharacterEntity character;
  const CharacterDetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterDetailsBloc(character: character),
      child: const CharacterDetailsView(),
    );
  }
}

class CharacterDetailsView extends StatelessWidget {
  const CharacterDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        title: const Text('Character Detail'),
      ),
      body: SingleChildScrollView(
        child: BlocSelector<CharacterDetailsBloc, CharacterDetailsState, CharacterEntity>(
          selector: (state) => state.data.character,
          bloc: context.read<CharacterDetailsBloc>(),
          builder: (context, character) => _body(character, context),
        ),
      ),
    );
  }

  Column _body(CharacterEntity character, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Hero(
          tag: character.id!,
          child: CachedNetworkImage(
            imageUrl: character.image!,
            fit: BoxFit.cover,
            height: 300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                character.name ?? '',
                style: CustomTextStyles().default26w700,
              ),
              Text(
                character.isAlive ? Internationalize.characterAlive : Internationalize.characterDead,
                style: CustomTextStyles().default16w500.copyWith(
                      color: character.isAlive ? const Color.fromARGB(255, 83, 122, 39) : Colors.redAccent,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '${Internationalize.characterSpecies}: ${character.species ?? ''}',
                style: CustomTextStyles().default14w500,
              ),
              const SizedBox(height: 8),
              Text(
                '${Internationalize.characterType}: ${character.type ?? '?'}',
                style: CustomTextStyles().default14w500,
              ),
              const SizedBox(height: 8),
              Text(
                '${Internationalize.characterOrigin}: ${character.origin?.name ?? ''}',
                style: CustomTextStyles().default14w500,
              ),
              const SizedBox(height: 8),
              Text(
                '${Internationalize.characterLastLocation}: ${character.location?.name ?? ''}',
                style: CustomTextStyles().default14w500,
              ),
              const SizedBox(height: 8),
              Text(
                '${Internationalize.characterGender}: ${character.gender ?? ''}',
                style: CustomTextStyles().default14w500,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Text(
            '${Internationalize.characterEpisodes}:',
            style: CustomTextStyles().default14w500,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: character.episode?.length ?? 0,
            itemBuilder: (context, index) {
              final ep = character.episode![index];
              final name = ep.split('/').last;
              return Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 8, right: 12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  height: 40,
                  width: 30,
                  child: Center(
                    child: Text(
                      name,
                      style: CustomTextStyles().default16w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
