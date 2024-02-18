import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:etm_crm/app/ui/utils/get_token.dart';

import '../../data/api_client.dart';
import '../models/lesson.dart';
import '../models/schedule.dart';
import '../models/services.dart';

class ScheduleService {
  static Future<ScheduleMeta?> fetchMeta(
      context,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/school/schedule/meta',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ScheduleMeta.fromJson(data);
  }

  static Future<ScheduleMeta?> fetchMetaTeacher(
      context,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/teacher/schedule/meta',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ScheduleMeta.fromJson(data);
  }

  static Future<LessonsList?> getLesson(
      context,
      String date,
      FilterSchedule filterSchedule,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/school/schedule/lesson',
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

  static Future<LessonsList?> getLessonTeacher(
      context,
      String date,
      FilterSchedule filterSchedule,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/teacher/schedule/lesson',
      queryParameters: {
        'date': date,
        'filter_type': json.encode(filterSchedule.type),
        'filter_class': json.encode(filterSchedule.selectClass),
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return LessonsList.fromJson(data);
  }

  static Future<bool?> deleteLesson(
      context, int? id, String date,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.delete(
      '/school/schedule/delete/$id',
      queryParameters: {
        'date': date
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }



  static Future<bool?> addLesson(
      context,
      Map<String, dynamic> dataBody,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        dataBody['id'] == null ? '/school/schedule/add-lesson' :
        '/school/schedule/edit-lesson',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: dataBody
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> addLessonTeacher(
      context,
      Map<String, dynamic> dataBody,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        dataBody['id'] == null ? '/teacher/schedule/add-lesson' :
        '/teacher/schedule/edit-lesson',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: dataBody
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<ListPayUsers?> fetchPayedUser(
      context,
      serviceId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/student/lesson/pay-users/$serviceId',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListPayUsers.fromJson(data);
  }
}
