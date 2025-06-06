import 'package:injectable/injectable.dart';
import 'package:rickmorty/layers/data/datasource/characters/remote/dto/character_dto.dart';
import 'package:rickmorty/layers/data/repositories/characters/mappers/location_mapper_dto.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

import '../../../datasource/characters/local/dbo/character_dbo.dart';

@Injectable()
class CharacterMapperDTO {
  final LocationMapperDTO _locationMapperDTO;

  CharacterMapperDTO({
    required LocationMapperDTO locationMapperDTO,
  }) : _locationMapperDTO = locationMapperDTO;

  CharacterDTO toDTO(CharacterEntity entity) {
    return CharacterDTO(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      species: entity.species,
      type: entity.type,
      gender: entity.gender,
      origin: entity.origin != null ? _locationMapperDTO.toDTO(entity.origin!) : null,
      location: entity.location != null ? _locationMapperDTO.toDTO(entity.location!) : null,
      image: entity.image,
      episode: entity.episode,
      url: entity.url,
      created: entity.created,
    );
  }

  CharacterDBO toDBO(CharacterDTO dto) {
    return CharacterDBO(
      id: dto.id,
      name: dto.name,
      status: dto.status,
      species: dto.species,
      type: dto.type,
      gender: dto.gender,
      origin: dto.origin != null ? _locationMapperDTO.toDBO(dto.origin!) : null,
      location: dto.location != null ? _locationMapperDTO.toDBO(dto.location!) : null,
      image: dto.image,
      episode: dto.episode,
      url: dto.url,
      created: dto.created,
    );
  }

  CharacterEntity toEntity(CharacterDTO dto) {
    return CharacterEntity(
      id: dto.id,
      name: dto.name,
      status: dto.status,
      species: dto.species,
      type: dto.type,
      gender: dto.gender,
      origin: dto.origin != null ? _locationMapperDTO.toDTO(dto.origin!) : null,
      location: dto.location != null ? _locationMapperDTO.toDTO(dto.location!) : null,
      image: dto.image,
      episode: dto.episode,
      url: dto.url,
      created: dto.created,
    );
  }
}
