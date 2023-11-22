import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/services.dart';

class ServicesService {
  static Future<ServicesCategory?> addCategory(
      BuildContext context,
      String? name,
      String? color
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/school/services/add-category',
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
      '/school/services/edit-category',
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
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/school/services/${id != null ? 'edit-service' : 'add-service'}',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: {
        'id': id,
        'name': name,
        'color': color,
        'branch_id': branchId,
        'service_category': serviceCategory,
        'teacher': teacher,
        'validity': validity,
        'validity_type': validityType,
        'duration': duration,
        'number_visits': numberVisits,
        'cost': cost,
        'currency': currency,
        'etm': etm,
      }
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
      '/school/services/delete-service/$id',
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
      '/school/services/delete-category/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<ServicesData?> fetchService(
      BuildContext context
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/school/services/fetch-service',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      )
    );
    final data = response.data as Map<String, dynamic>;
    return ServicesData.fromJson(data);
  }

}
