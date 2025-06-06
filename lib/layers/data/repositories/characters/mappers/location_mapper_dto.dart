import 'package:injectable/injectable.dart';
import 'package:rickmorty/layers/data/datasource/characters/remote/dto/location_dto.dart';
import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

import '../../../datasource/characters/local/dbo/location_dbo.dart';

@Injectable()
class LocationMapperDTO {
  LocationDTO toDTO(LocationEntity location) {
    return LocationDTO(
      name: location.name,
      url: location.url,
    );
  }

  LocationDBO toDBO(LocationDTO locationDTO) {
    return LocationDBO(
      name: locationDTO.name,
      url: locationDTO.url,
    );
  }

  LocationEntity toEntity(LocationDTO locationDTO) {
    return LocationEntity(
      name: locationDTO.name,
      url: locationDTO.url,
    );
  }
}
