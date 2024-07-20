import 'package:rickmorty/core/env/enviroment_constants.dart';
import 'package:rickmorty/core/interceptors/dio_interceptor.dart';
import 'package:test/test.dart';
import 'package:dio/dio.dart';

void main() {
  group('CustomInterceptor tests', () {
    late Dio dio;

    setUp(() {
      dio = Dio();
    });

    test('Error response', () async {
      // Simulamos un fallo en la primera solicitud
      dio.interceptors.clear(); // Limpiamos cualquier interceptor existente
      dio.interceptors.add(CustomInterceptor());

      try {
        await dio.get<Response<dynamic>>(
          '${Enviroment.baseUrl}/characters/?page=1',
        ); // Ajusta la URL según tus necesidades
        fail('Should not reach here');
      } on DioException catch (e) {
        // Aseguramos que el interceptor haya realizado los intentos de reintento
        //expect(e.error is Object, true);
        expect(e is! DioExceptionType, true);
        expect(e.requestOptions, isA<RequestOptions>());
        expect(e.response, isA<Response<dynamic>>());
        expect(e.response?.statusCode, 404);
      }
    });

    test('Successful request', () async {
      // Simulamos una solicitud exitosa
      dio.interceptors.clear(); // Limpiamos cualquier interceptor existente
      dio.interceptors.add(CustomInterceptor());

      final Response<dynamic> response = await dio.get(
        '${Enviroment.baseUrl}/character/?page=1',
      ); // Ajusta la URL según tus necesidades

      // Verificamos que la respuesta sea exitosa
      expect(response.statusCode, 200);
    });
    test('New  test ', () async {
      // Simulamos un fallo en la primera solicitud
      dio.interceptors.clear(); // Limpiamos cualquier interceptor existente
      dio.interceptors.add(CustomInterceptor());

      try {
        await dio.get<Response<dynamic>>('https://mock.httpstatus.io/205'); // Ajusta la URL según tus necesidades
        fail('Should not reach here');
      } on DioException catch (e) {
        // Aseguramos que el interceptor haya realizado los intentos de reintento
        //expect(e.error is Object, true);
        expect(e is! DioExceptionType, true);
        expect(e.requestOptions, isA<RequestOptions>());
        expect(e.response, null);
        expect(e.response?.statusCode, null);
      }
    });
  });
}
