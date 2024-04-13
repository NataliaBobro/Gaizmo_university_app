import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/timesheet.dart';


class TimesheetService {
  static Future<TimesheetModel?> fetchList(
      BuildContext context,
      int? userId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
        '/timesheet/fetch-list/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
    );
    final data = response.data as Map<String, dynamic>;
    return TimesheetModel.fromJson(data);
  }
}
