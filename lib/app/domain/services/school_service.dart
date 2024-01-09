import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:etm_crm/app/ui/utils/get_token.dart';

import '../../data/api_client.dart';
import '../models/user.dart';

class SchoolService {
  static Future<bool?> changeSchoolSchedule(
      context,
      List<int>? workDay,
      String? from,
      String? to,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/change-schedule',
      data: {
        'work_day': json.encode(workDay),
        'from': from,
        'to': to,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changeCategory(
      context,
      int? categoryId,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/school/settings/change-category',
      data: {
        'category_id': categoryId,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changeAddress(
      context,
      String? country,
      String? city,
      String? street,
      String? house,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/school/settings/change-address',
      data: {
        'country': country,
        'city': city,
        'street': street,
        'house': house,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> addBranch(
      context,
      Map<String, dynamic> map,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/school/branch/add',
      data: map,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  } 
  
  static Future<ListUserData?> fetchBranchList(
      context,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/school/branch/list',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListUserData.fromJson(data);
  }

  static Future<UserData?> fetchBranchItem(
      context,
      int? branchId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/school/branch/item/$branchId',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return UserData.fromJson(data['user']);
  }

}
