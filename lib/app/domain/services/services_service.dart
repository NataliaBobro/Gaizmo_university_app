import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/services.dart';
import 'dart:io';

class ServicesService {
  static Future<ServicesCategory?> addCategory(
      BuildContext context,
      String? name,
      String? color
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/services/add-category',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: {
        'name': name,
        'color': color,
      }
    );
    final data = response.data as Map<String, dynamic>;
    return ServicesCategory.fromJson(data);
  }

  static Future<ServicesCategory?> editCategory(
      BuildContext context,
      int? id,
      String? name,
      String? color
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/services/edit-category',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: {
        'id': id,
        'name': name,
        'color': color,
      }
    );
    final data = response.data as Map<String, dynamic>;
    return ServicesCategory.fromJson(data);
  }

  static Future<ServicesModel?> addOrEditService(
      BuildContext context,
      int? id,
      String? name,
      String? desc,
      String? color,
      int? branchId,
      int? serviceCategory,
      int? teacher,
      int? validity,
      String? validityType,
      int? duration,
      String? numberVisits,
      String? cost,
      int? currency,
      String? etm,
      File? image,
      ) async {
    final token = getToken(context);
    if(token == null) return null;

    FormData formData = FormData();

    if(image != null){
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(image.path),
        ),
      );
    }

    formData.fields.addAll({
      MapEntry('id', '$id'),
      MapEntry('name', '$name'),
      MapEntry('desc', '$desc'),
      MapEntry('color', '$color'),
      MapEntry('branch_id', '$branchId'),
      MapEntry('service_category', '$serviceCategory'),
      MapEntry('teacher', '$teacher'),
      MapEntry('validity', '$validity'),
      MapEntry('validity_type', '$validityType'),
      MapEntry('duration', '$duration'),
      MapEntry('number_visits', '$numberVisits'),
      MapEntry('cost', '$cost'),
      MapEntry('currency', '$currency'),
      MapEntry('etm', '$etm'),
    });

    final response = await ApiClient().dio.post(
      '/services/${id != null ? 'edit-service' : 'add-service'}',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: formData
    );
    final data = response.data as Map<String, dynamic>;
    return ServicesModel.fromJson(data);
  }

  static Future<bool?> deleteService(
      BuildContext context,
      int id,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.delete(
      '/services/delete-service/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> deleteCategory(
      BuildContext context,
      int id,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.delete(
      '/services/delete-category/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<ServicesData?> fetchService(
      BuildContext context,
      String? search,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/services/fetch-service',
      queryParameters: {
        "search": search
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      )
    );
    final data = response.data as Map<String, dynamic>;
    return ServicesData.fromJson(data);
  }

}
