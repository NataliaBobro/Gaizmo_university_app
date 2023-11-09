import 'package:dio/dio.dart';

import '../../data/app_interceptor.dart';

class AppNinjasService {

  static Future<List<dynamic>?> getCountry(String? search) async {
    final response = await ApiClientNinjas().dio.get(
      '/country',
      queryParameters: {
        'name': search,
        'limit': 5
      }
    );
    return response.data;
  }

  static Future<List<dynamic>?> getCity(String? search, Map<String, dynamic>? country) async {
    final selectCountry = country != null ? country['iso2'] : '';
    final response = await ApiClientNinjas().dio.get(
        '/city',
        queryParameters: {
          'name': search,
          'limit': 5,
          'country': selectCountry
        }
    );
    return response.data;
  }

}

class ApiClientNinjas {
  static const _baseUrl = 'https://api.api-ninjas.com/v1';

  final dio = createDio();

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
          baseUrl: _baseUrl,
          headers: {
            'X-Api-Key' : "llgSGDOU7GVWFN5fbb6AVw==XwlGxU9R4warHj2t",
            'Accept' : "application/json",
          }
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  ApiClientNinjas._internal();

  static final _singleton = ApiClientNinjas._internal();

  factory ApiClientNinjas() => _singleton;
}
