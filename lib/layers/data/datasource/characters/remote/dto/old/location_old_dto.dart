import 'dart:convert';

import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

/// This is an old exaple of a DTO. It is not used in the app.
/// For now use the new one with the Mapper class
class LocationOldDto extends LocationEntity {
  LocationOldDto({
    super.name,
    super.url,
  });
  factory LocationOldDto.fromRawJson(String str) => LocationOldDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory LocationOldDto.fromMap(Map<String, dynamic> json) => LocationOldDto(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };

  static LocationOldDto fromLocation(LocationEntity location) {
    return LocationOldDto(
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
