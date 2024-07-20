import 'package:rickmorty/layers/data/repositories/characters/mappers/location_mapper_dbo.dart';
import 'package:rickmorty/layers/domain/entities/characters/character_entity.dart';

import '../../../datasource/characters/local/dbo/character_dbo.dart';

class CharacterMapperDBO {
  static CharacterDBO toDBO(CharacterEntity entity) {
    return CharacterDBO(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      species: entity.species,
      type: entity.type,
      gender: entity.gender,
      origin: entity.origin != null ? LocationMapperDBO.toDTO(entity.origin!) : null,
      location: entity.location != null ? LocationMapperDBO.toDTO(entity.location!) : null,
      image: entity.image,
      episode: entity.episode,
      url: entity.url,
      created: entity.created,
    );
  }

  static CharacterEntity toEntity(CharacterDBO dto) {
    return CharacterEntity(
      id: dto.id,
      name: dto.name,
      status: dto.status,
      species: dto.species,
      type: dto.type,
      gender: dto.gender,
      origin: dto.origin != null ? LocationMapperDBO.toDTO(dto.origin!) : null,
      location: dto.location != null ? LocationMapperDBO.toDTO(dto.location!) : null,
      image: dto.image,
      episode: dto.episode,
      url: dto.url,
      created: dto.created,
    );
  }
}
