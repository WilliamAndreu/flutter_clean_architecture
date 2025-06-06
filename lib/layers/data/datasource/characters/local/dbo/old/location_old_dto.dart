import 'dart:convert';

import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

/// This is an old exaple of a DTO. It is not used in the app.
/// For now use the new one with the Mapper class
class LocationOldDbo extends LocationEntity {
  LocationOldDbo({
    super.name,
    super.url,
  });
  factory LocationOldDbo.fromRawJson(String str) => LocationOldDbo.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory LocationOldDbo.fromMap(Map<String, dynamic> json) => LocationOldDbo(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };

  static LocationOldDbo fromLocation(LocationEntity location) {
    return LocationOldDbo(
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
