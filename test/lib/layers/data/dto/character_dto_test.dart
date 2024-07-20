import 'package:rickmorty/layers/data/datasource/characters/local/dbo/old/character_old_dto.dart';
import 'package:rickmorty/layers/data/datasource/characters/local/dbo/old/location_old_dto.dart';
import 'package:rickmorty/layers/data/datasource/characters/remote/dto/old/character_old_dto.dart';
import 'package:rickmorty/layers/data/datasource/characters/remote/dto/old/location_old_dto.dart';
import 'package:test/test.dart';

void main() {
  group('CharacterDto', () {
    late String referenceRawJson;
    late CharacterOldDto referenceDto;

    setUp(() {
      referenceDto = CharacterOldDto(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        type: 'Super genius',
        gender: 'Male',
        origin: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
        location: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
        image: 'https://example.com/rick.png',
        episode: [
          'https://example.com/episode1',
          'https://example.com/episode2',
        ],
        url: 'https://example.com/character/1',
        created: DateTime.parse('2022-01-01T12:00:00Z'),
      );

      referenceRawJson = referenceDto.toRawJson();
    });

    test('should create CharacterDto instance to/from JSON', () {
      final createdDto = CharacterOldDto.fromRawJson(referenceRawJson);
      final json = createdDto.toRawJson();
      expect(createdDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}
