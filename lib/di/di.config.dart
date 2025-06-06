// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rickmorty/core/exceptions/handler/app_exception_handler.dart'
    as _i934;
import 'package:rickmorty/layers/data/datasource/characters/source/characters_local_datasource.dart'
    as _i766;
import 'package:rickmorty/layers/data/datasource/characters/source/characters_remote_datasource.dart'
    as _i908;
import 'package:rickmorty/layers/data/repositories/characters/character_repository_impl.dart'
    as _i411;
import 'package:rickmorty/layers/data/repositories/characters/mappers/character_mapper_dbo.dart'
    as _i311;
import 'package:rickmorty/layers/data/repositories/characters/mappers/character_mapper_dto.dart'
    as _i1064;
import 'package:rickmorty/layers/data/repositories/characters/mappers/location_mapper_dbo.dart'
    as _i1058;
import 'package:rickmorty/layers/data/repositories/characters/mappers/location_mapper_dto.dart'
    as _i948;
import 'package:rickmorty/layers/di/characters_datasource_module.dart' as _i518;
import 'package:rickmorty/layers/domain/exception/characters/handler/characters_exception_handler.dart'
    as _i35;
import 'package:rickmorty/layers/domain/repository/characters/character_repository.dart'
    as _i273;
import 'package:rickmorty/layers/domain/usecase/characters/filter_characters_by_name.dart'
    as _i1006;
import 'package:rickmorty/layers/domain/usecase/characters/get_all_characters.dart'
    as _i809;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final charactersDatasourceModule = _$CharactersDatasourceModule();
    gh.factory<_i934.AppExceptionHandler>(() => _i934.AppExceptionHandler());
    gh.factory<_i766.CharactersLocalDataSource>(
        () => charactersDatasourceModule.charactersLocalDataSource);
    gh.factory<_i908.CharactersRemoteDataSource>(
        () => charactersDatasourceModule.charactersRemoteDataSource);
    gh.factory<_i1058.LocationMapperDBO>(() => _i1058.LocationMapperDBO());
    gh.factory<_i948.LocationMapperDTO>(() => _i948.LocationMapperDTO());
    gh.factory<_i1006.FilterCharactersByName>(
        () => _i1006.FilterCharactersByName());
    gh.factory<_i35.CharactersExceptionHandler>(
        () => _i35.CharactersExceptionHandler());
    gh.factory<_i1064.CharacterMapperDTO>(() => _i1064.CharacterMapperDTO(
        locationMapperDTO: gh<_i948.LocationMapperDTO>()));
    gh.factory<_i311.CharacterMapperDBO>(() => _i311.CharacterMapperDBO(
        locationMapperDBO: gh<_i1058.LocationMapperDBO>()));
    gh.factory<_i273.CharacterRepository>(() => _i411.CharacterRepositoryImpl(
          api: gh<_i908.CharactersRemoteDataSource>(),
          localStorage: gh<_i766.CharactersLocalDataSource>(),
          characterMapperDTO: gh<_i1064.CharacterMapperDTO>(),
          characterMapperDBO: gh<_i311.CharacterMapperDBO>(),
          exceptionHandler: gh<_i934.AppExceptionHandler>(),
        ));
    gh.factory<_i809.GetAllCharacters>(() => _i809.GetAllCharacters(
          repository: gh<_i273.CharacterRepository>(),
          exceptionHandler: gh<_i35.CharactersExceptionHandler>(),
        ));
    return this;
  }
}

class _$CharactersDatasourceModule extends _i518.CharactersDatasourceModule {}
