import 'dart:convert';
import 'package:rickmorty/layers/data/datasource/characters/local/dbo/location_dbo.dart';

class CharacterDBO {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final LocationDBO? origin;
  final LocationDBO? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final DateTime? created;

  CharacterDBO({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });
  

  factory CharacterDBO.fromRawJson(String str) => CharacterDBO.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory CharacterDBO.fromMap(Map<String, dynamic> json) => CharacterDBO(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin'] == null ? null : LocationDBO.fromMap(json['origin']),
        location: json['location'] == null ? null : LocationDBO.fromMap(json['location']),
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
        'origin': origin != null ? LocationDBO.fromLocation(origin!).toMap() : null,
        'location': location != null ? LocationDBO.fromLocation(location!).toMap() : null,
        'image': image,
        'episode': episode == null ? <dynamic>[] : List<dynamic>.from(episode!.map((x) => x)),
        'url': url,
        'created': created?.toIso8601String(),
      };
}
