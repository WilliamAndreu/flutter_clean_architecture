import 'package:dio/dio.dart';
import 'package:rickmorty/core/config/moshi_wrapper.dart';
import 'package:rickmorty/core/env/enviroment_constants.dart';
import 'package:rickmorty/core/utils/hybrid_logger_wrapper.dart';

import '../source/characters_remote_datasource.dart';
import 'dto/character_dto.dart';

class ApiImpl implements CharactersRemoteDataSource {
  final MoshiWrapper _moshi;

  ApiImpl({required MoshiWrapper moshi}) : _moshi = moshi;

  @override
  Future<List<CharacterDTO>> loadCharacters({int page = 0}) async {
    HybridLoggerWrapper().logger.stackTrx(StackTrace.current);

    Response<dynamic> response = await _moshi.moshi.call.get('${Enviroment.baseUrl}/character/?page=$page');

    final characters = (response.data['results'] as List).map((e) => CharacterDTO.fromMap(e)).toList();

    return characters;
  }
}
