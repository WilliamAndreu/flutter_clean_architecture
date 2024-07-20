import 'package:rickmorty/layers/data/datasource/characters/local/dbo/old/location_old_dto.dart';
import 'package:rickmorty/layers/data/datasource/characters/remote/dto/old/location_old_dto.dart';
import 'package:test/test.dart';

void main() {
  group('LocationDto', () {
    late String referenceRawJson;
    late LocationOldDto referenceDto;

    setUp(() {
      referenceDto = LocationOldDto(
        name: 'Rick Sanchez',
        url: 'https://example.com/character/1',
      );

      referenceRawJson = referenceDto.toRawJson();
    });

    test('should create LocationDto instance to/from JSON', () {
      final createdDto = LocationOldDto.fromRawJson(referenceRawJson);
      final json = createdDto.toRawJson();
      expect(createdDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}
