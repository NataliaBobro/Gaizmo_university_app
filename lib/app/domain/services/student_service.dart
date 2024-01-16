import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/meta.dart';
import '../models/services.dart';


class StudentService {
  static Future<ListUserData?> fetchList(
      BuildContext context,
      List<String> listCity,
      {String? search}
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        '/student/school/list',
        data: {
          'city': listCity,
          'search': search
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListUserData.fromJson(data);
  }

  static Future<FilterDataString?> fetchDataFilterSchool(BuildContext context) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
        '/student/school/filter-data',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
    );
    final data = response.data as Map<String, dynamic>;
    return FilterDataString.fromJson(data);
  }

  static Future<ServicesData?> fetchService(
      BuildContext context,
      int? schoolId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
        '/student/school/$schoolId/category-lesson',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
    );
    final data = response.data as Map<String, dynamic>;
    return ServicesData.fromJson(data);
  }

}
