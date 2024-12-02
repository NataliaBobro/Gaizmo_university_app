import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';


class StaffService {
  static Future<bool?> addStaff(
      BuildContext context,
      Map<String, dynamic> dataStaff
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        '/school/staff/add',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: dataStaff
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> saveGeneralInfo(
      BuildContext context,
      int? id,
      Map<String, dynamic> dataStaff
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        '/school/staff/$id/change-general-info',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: dataStaff
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> saveBirthDate(
      BuildContext context,
      int? id,
      Map<String, dynamic> dataStaff
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        '/school/staff/$id/change-date-birth',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: dataStaff
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> saveAddress(
      BuildContext context,
      int? id,
      Map<String, dynamic> dataStaff
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        '/school/staff/$id/change-address',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: dataStaff
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> saveGender(
      BuildContext context,
      int? id,
      Map<String, dynamic> dataStaff
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
        '/school/staff/$id/change-gender',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: dataStaff
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<ListUserData?> fetchStaff(
      BuildContext context
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
        '/school/staff/list',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
    );
    final data = response.data as Map<String, dynamic>;
    return ListUserData.fromJson(data);
  }

  static Future<UserData?> getStaff(
      BuildContext context,
      int? staffId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
        '/school/staff/fetch/$staffId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
    );
    final data = response.data as Map<String, dynamic>;
    return UserData.fromJson(data['user']);
  }
}
