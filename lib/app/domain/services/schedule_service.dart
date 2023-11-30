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



  static Future<bool?> addLesson(
      context,
      int? selectServiceId,
      int? selectClassId,
      String? startLesson,
      String? repeatsStart,
      String? repeatsEnd,
      List<Map<String, String>> dayListSelected,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/school/schedule/add-lesson',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: {
        'service': selectServiceId,
        'school_class': selectClassId,
        'start_lesson': startLesson?.replaceAll(' ', ''),
        'start': repeatsStart,
        'end': repeatsEnd,
        'day': dayListSelected,
      }
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }
}
