import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';


class VisitsLessonService {
  static Future<bool?> visits(
      BuildContext context,
      int? lessonId,
      DateTime? date,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/student/lesson/visits',
      data: {
        'lesson_id': lessonId,
        'date': date.toString()
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      )
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }



}
