import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/lesson.dart';
import '../models/schedule.dart';


class StudentLessonService {
  static Future<LessonsList?> fetchToday(
      BuildContext context
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/student/lesson/fetch-today',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return LessonsList.fromJson(data);
  }

  static Future<LessonsList?> getLessonForDay(
      context,
      String date,
      FilterSchedule filterSchedule,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/student/lesson/fetch',
      queryParameters: {
        'date': date,
        'filter_type': json.encode(filterSchedule.type),
        'filter_teacher': json.encode(filterSchedule.teacher),
        'filter_class': json.encode(filterSchedule.selectClass),
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return LessonsList.fromJson(data);
  }

  static Future<ScheduleMeta?> fetchMeta(
      context,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/student/lesson/meta',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ScheduleMeta.fromJson(data);
  }
}
