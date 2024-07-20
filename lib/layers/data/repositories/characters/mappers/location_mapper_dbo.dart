import 'package:rickmorty/layers/data/datasource/characters/local/dbo/location_dbo.dart';
import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

class LocationMapperDBO {
  static LocationDBO toDTO(LocationEntity location) {
    return LocationDBO(
      name: location.name,
      url: location.url,
    );
  }

  static LocationEntity toEntity(LocationDBO locationDTO) {
    return LocationEntity(
      name: locationDTO.name,
      url: locationDTO.url,
    );
  }
}
