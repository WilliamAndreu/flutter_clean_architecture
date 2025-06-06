import 'package:injectable/injectable.dart';
import 'package:rickmorty/layers/data/datasource/characters/local/dbo/location_dbo.dart';
import 'package:rickmorty/layers/domain/entities/characters/location_entity.dart';

@Injectable()
class LocationMapperDBO {
  LocationDBO toDTO(LocationEntity location) {
    return LocationDBO(
      name: location.name,
      url: location.url,
    );
  }

  LocationEntity toEntity(LocationDBO locationDTO) {
    return LocationEntity(
      name: locationDTO.name,
      url: locationDTO.url,
    );
  }
}
