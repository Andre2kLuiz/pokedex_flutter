
import 'package:dio/dio.dart';

import '../../../domain/exception/network_exception.dart';
import '../entity/http_paged_result.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()
    ..options.baseUrl = baseUrl
     //..options.headers
      ..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  Future<List<PokemonEntity>> getPokemons({int? page, int? limit}) async {  try {
      final response = await _dio.get(
        "/pokemons",
        queryParameters: {
          '_page':page,
          '_per_page': limit,
        }
      );
      print("Response: ${response.data}");

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
          statusCode: response.statusCode!,
          message: response.statusMessage,
        );
      } else if (response.statusCode != null) {
        final HttpPagedResult receivedData = HttpPagedResult.fromJson(response.data as Map<String, dynamic>);

        return receivedData.data;
      } else {
        throw Exception('Unknown error');
      }
    } catch (e) {
      print("Error: $e");
      rethrow; // Re-lançar o erro para que ele possa ser tratado em outro lugar
    }
  }
}