import 'package:dio/dio.dart';

import 'app_interceptor.dart';

class ApiClient {
  // static const _baseUrl = 'https://etm-api.lux-center.com.ua/api/v1';
  static const _baseUrl = 'http://localhost:8888/api/v1';

  final dio = createDio();

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
            'Accept' : "application/json",
            'Content-Type' : "application/json",
        }
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;
}
