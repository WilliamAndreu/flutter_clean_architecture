import 'dart:convert';

import 'package:rickmorty/layers/data/datasource/characters/remote/dto/old/location_old_dto.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

/// This is an old exaple of a DTO. It is not used in the app.
/// For now use the new one with the Mapper class
class CharacterOldDto extends CharacterEntity {
  CharacterOldDto({
    super.id,
    super.name,
    super.status,
    super.species,
    super.type,
    super.gender,
    super.origin,
    super.location,
    super.image,
    super.episode,
    super.url,
    super.created,
  });

  factory CharacterOldDto.fromRawJson(String str) => CharacterOldDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory CharacterOldDto.fromMap(Map<String, dynamic> json) => CharacterOldDto(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin'] == null ? null : LocationOldDto.fromMap(json['origin']),
        location: json['location'] == null ? null : LocationOldDto.fromMap(json['location']),
        image: json['image'],
        episode: json['episode'] == null ? [] : List<String>.from(json['episode']!.map((dynamic x) => x)),
        url: json['url'],
        created: json['created'] == null ? null : DateTime.parse(json['created']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin != null ? LocationOldDto.fromLocation(origin!).toMap() : null,
        'location': location != null ? LocationOldDto.fromLocation(location!).toMap() : null,
        'image': image,
        'episode': episode == null ? <dynamic>[] : List<dynamic>.from(episode!.map((x) => x)),
        'url': url,
        'created': created?.toIso8601String(),
      };
}
