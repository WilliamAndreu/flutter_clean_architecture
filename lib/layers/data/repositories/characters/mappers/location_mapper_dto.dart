import 'package:rickmorty/layers/data/datasource/characters/remote/dto/location_dto.dart';
import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

import '../../../datasource/characters/local/dbo/location_dbo.dart';

class LocationMapperDTO {
  static LocationDTO toDTO(LocationEntity location) {
    return LocationDTO(
      name: location.name,
      url: location.url,
    );
  }

    static LocationDBO toDBO(LocationDTO locationDTO) {
    return LocationDBO(
      name: locationDTO.name,
      url: locationDTO.url,
    );
  }

  static LocationEntity toEntity(LocationDTO locationDTO) {
    return LocationEntity(
      name: locationDTO.name,
      url: locationDTO.url,
    );
  }
}
