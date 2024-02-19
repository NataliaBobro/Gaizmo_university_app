import 'dart:io';
import 'package:dio/dio.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/results.dart';
import '../models/schedule.dart';

class ResultService {
  static Future<ScheduleMeta?> fetchMeta(
      context,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/my-result/meta',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ScheduleMeta.fromJson(data);
  }

  static Future<ResultsModel?> fetchList(
      context,
      int? filterService,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/my-result/list',
      queryParameters: {
        'service_id': filterService
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ResultsModel.fromJson(data);
  }

  static Future<bool?> addResult(
      context,
      int? serviceId,
      File fileUpload
      ) async {
    final token = getToken(context);

    FormData formData = FormData();

    formData.files.add(
      MapEntry(
        'image',
        await MultipartFile.fromFile(fileUpload.path),
      ),
    );

    formData.fields.add(
      MapEntry('service_id', '$serviceId'),
    );

    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/my-result/add',
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

}
