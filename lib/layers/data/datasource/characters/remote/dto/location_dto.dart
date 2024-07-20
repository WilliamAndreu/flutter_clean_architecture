import 'dart:convert';
import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

class LocationDTO extends LocationEntity {
  LocationDTO({
    super.name,
    super.url,
  });
  factory LocationDTO.fromRawJson(String str) => LocationDTO.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory LocationDTO.fromMap(Map<String, dynamic> json) => LocationDTO(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };

  static LocationDTO fromLocation(LocationEntity location) {
    return LocationDTO(
      name: location.name,
      url: location.url,
    );
  }

  LocationEntity toLocation() {
    return LocationEntity(
      name: name,
      url: url,
    );
  }
}
