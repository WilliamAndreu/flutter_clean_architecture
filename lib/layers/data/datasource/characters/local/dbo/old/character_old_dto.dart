import 'dart:convert';

import 'package:rickmorty/layers/data/datasource/characters/local/dbo/old/location_old_dto.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

/// This is an old exaple of a DTO. It is not used in the app.
/// For now use the new one with the Mapper class
class CharacterOldDbo extends CharacterEntity {
  CharacterOldDbo({
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

  factory CharacterOldDbo.fromRawJson(String str) => CharacterOldDbo.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory CharacterOldDbo.fromMap(Map<String, dynamic> json) => CharacterOldDbo(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin'] == null ? null : LocationOldDbo.fromMap(json['origin']),
        location: json['location'] == null ? null : LocationOldDbo.fromMap(json['location']),
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
        'origin': origin != null ? LocationOldDbo.fromLocation(origin!).toMap() : null,
        'location': location != null ? LocationOldDbo.fromLocation(location!).toMap() : null,
        'image': image,
        'episode': episode == null ? <dynamic>[] : List<dynamic>.from(episode!.map((x) => x)),
        'url': url,
        'created': created?.toIso8601String(),
      };
}
