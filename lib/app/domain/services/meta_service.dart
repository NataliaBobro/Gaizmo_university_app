import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/meta.dart';

class MetaService {
  static Future<MetaAppData?> fetchMeta() async {
    final response = await ApiClient().dio.get(
          '/auth/meta',
        );
    final data = response.data as Map<String, dynamic>;
    return MetaAppData.fromJson(data);
  }

  static Future<ConstantsList?> fetchConstant(languageId) async {
    final response = await ApiClient().dio.get(
      '/fetch-language-constant',
      queryParameters: {
        'language_id': languageId
      }
    );
    final data = response.data as Map<String, dynamic>;
    return ConstantsList.fromJson(data);
  }

  static Future<MetaAppData?> getAddServiceMeta(BuildContext context) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
          '/services/meta',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return MetaAppData.fromJson(data);
  }

  static Future<DocumentTypeList?> fetchTypeDocument(BuildContext context, int? userId) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/user/$userId/type-document',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return DocumentTypeList.fromJson(data);
  }

}
