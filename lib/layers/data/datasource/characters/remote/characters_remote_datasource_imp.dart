import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rickmorty/core/config/moshi_wrapper.dart';
import 'package:rickmorty/core/env/enviroment_constants.dart';
import 'package:rickmorty/core/utils/custom_exceptions.dart';
import 'package:rickmorty/core/utils/mirai_wrapper.dart';

import '../source/characters_remote_datasource.dart';
import 'dto/character_dto.dart';

class ApiImpl implements CharactersRemoteDataSource {
  final moshi = MoshiWrapper();

  @override
  Future<Either<CustomException, List<CharacterDTO>>> loadCharacters({int page = 0}) async {
    MiraiWrapper().logger.stackTrx(StackTrace.current);

    try {
      Response<dynamic> response = await moshi.moshi.call.get('${Enviroment.baseUrl}/character/?page=$page');
      final characters = (response.data['results'] as List).map((e) => CharacterDTO.fromMap(e)).toList();
      return right(characters);
    } catch (error) {
      return left(
        CustomException(error.toString()),
      );
    }
  }
}
