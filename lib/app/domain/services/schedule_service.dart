import 'package:dio/dio.dart';
import 'package:etm_crm/app/ui/utils/get_token.dart';

import '../../data/api_client.dart';
import '../models/lesson.dart';
import '../models/schedule.dart';

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

  static Future<LessonsList?> getLesson(
      context, String date,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/school/schedule/lesson',
      queryParameters: {
        'date': date
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
}
