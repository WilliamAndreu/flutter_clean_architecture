import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rickmorty/core/assets/translations/internationalize.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';
import 'package:rickmorty/core/styles/custom_text_styles.dart';

typedef OnCharacterListItemTap = void Function(CharacterEntity character);

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({
    super.key,
    required this.item,
    this.onTap,
  });

  final CharacterEntity item;
  final OnCharacterListItemTap? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(item),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 124,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _ItemPhoto(item: item),
              _ItemDescription(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription({super.key, required this.item});

  final CharacterEntity item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                item.name ?? '',
                style: CustomTextStyles().default16w700,
              ),
              const SizedBox(height: 4),
              Text(
                item.isAlive ? Internationalize.characterAlive : Internationalize.characterDead,
                style: CustomTextStyles().default14w500.copyWith(
                      color: item.isAlive ? const Color.fromARGB(255, 111, 172, 43) : Colors.redAccent,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${Internationalize.characterLastLocation}: ${item.location?.name ?? ''}',
                style: CustomTextStyles().default14w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemPhoto extends StatelessWidget {
  const _ItemPhoto({super.key, required this.item});

  final CharacterEntity item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: SizedBox(
        height: 124,
        child: Hero(
          tag: item.id!,
          child: CachedNetworkImage(
            height: 122,
            width: 122,
            imageUrl: item.image!,
            fit: BoxFit.cover,
            errorWidget: (ctx, url, err) => const Icon(Icons.error),
            placeholder: (ctx, url) => const Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}
