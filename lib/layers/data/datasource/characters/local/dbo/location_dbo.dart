import 'dart:convert';
import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

class LocationDBO extends LocationEntity {
  LocationDBO({
    super.name,
    super.url,
  });
  factory LocationDBO.fromRawJson(String str) => LocationDBO.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory LocationDBO.fromMap(Map<String, dynamic> json) => LocationDBO(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };

  static LocationDBO fromLocation(LocationEntity location) {
    return LocationDBO(
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
