import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';


class StudentService {
  static Future<ListUserData?> fetchList(BuildContext context) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
        '/student/school/list',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListUserData.fromJson(data);
  }

}
