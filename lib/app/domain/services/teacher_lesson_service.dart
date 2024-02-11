import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/lesson.dart';


class TeacherLessonService {
  static Future<LessonsList?> fetchToday(
      BuildContext context
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/teacher/lesson/fetch-today',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return LessonsList.fromJson(data);
  }
}
