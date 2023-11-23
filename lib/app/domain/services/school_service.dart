import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:etm_crm/app/ui/utils/get_token.dart';

import '../../data/api_client.dart';

class SchoolService {
  static Future<bool?> changeSchoolSchedule(
      context,
      List<int>? workDay,
      String? from,
      String? to,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/change-schedule',
      data: {
        'work_day': json.encode(workDay),
        'from': from,
        'to': to,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

}
