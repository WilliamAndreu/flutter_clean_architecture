import 'package:rickmorty/layers/data/datasource/characters/local/dbo/old/character_old_dto.dart';
import 'package:rickmorty/layers/data/datasource/characters/local/dbo/old/location_old_dto.dart';

final characterDto = CharacterOldDto(
  id: 1,
  name: 'Rick Sanchez',
  status: Internationalize.characterAlive,
  species: 'Human',
  type: 'Super genius',
  gender: 'Male',
  origin: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
  location: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
  image: 'https://example.com/rick.png',
  episode: ['https://example.com/episode1', 'https://example.com/episode2'],
  url: 'https://example.com/character/1',
  created: DateTime.parse('2022-01-01T12:00:00Z'),
);

final characterList1 = [
  CharacterOldDto(
    id: 1,
    name: 'Rick Sanchez',
    status: Internationalize.characterAlive,
    species: 'Human',
    type: 'Super genius',
    gender: 'Male',
    origin: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    location: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    image: 'https://example.com/rick.png',
    episode: ['https://example.com/episode1', 'https://example.com/episode2'],
    url: 'https://example.com/character/1',
    created: DateTime.parse('2022-01-01T12:00:00Z'),
  ),
  CharacterOldDto(
    id: 2,
    name: 'Morty Smith',
    status: Internationalize.characterAlive,
    species: 'Human',
    type: 'Sidekick',
    gender: 'Male',
    origin: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    location: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    image: 'https://example.com/morty.png',
    episode: ['https://example.com/episode1', 'https://example.com/episode3'],
    url: 'https://example.com/character/2',
    created: DateTime.parse('2022-01-02T12:00:00Z'),
  ),
];

final characterList2 = [
  CharacterOldDto(
    id: 3,
    name: 'Summer Smith',
    status: Internationalize.characterAlive,
    species: 'Human',
    type: 'Teenager',
    gender: 'Female',
    origin: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    location: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    image: 'https://example.com/summer.png',
    episode: ['https://example.com/episode1', 'https://example.com/episode4'],
    url: 'https://example.com/character/3',
    created: DateTime.parse('2022-01-03T12:00:00Z'),
  ),
  CharacterOldDto(
    id: 4,
    name: 'Jerry Smith',
    status: Internationalize.characterAlive,
    species: 'Human',
    type: 'Father',
    gender: 'Male',
    origin: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    location: LocationOldDto(name: 'Earth', url: 'https://example.com/earth'),
    image: 'https://example.com/jerry.png',
    episode: ['https://example.com/episode1', 'https://example.com/episode5'],
    url: 'https://example.com/character/4',
    created: DateTime.parse('2022-01-04T12:00:00Z'),
  ),
];
