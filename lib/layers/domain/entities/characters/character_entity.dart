import 'package:equatable/equatable.dart';
import 'package:rickmorty/core/assets/translations/internationalize.dart';
import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

class CharacterEntity with EquatableMixin {
  CharacterEntity({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final LocationEntity? origin;
  final LocationEntity? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final DateTime? created;

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
        created,
      ];

  bool get isAlive => status == Internationalize.characterAlive;
}
