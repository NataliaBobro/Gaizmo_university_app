import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etm_crm/app/ui/utils/get_token.dart';

import '../../data/api_client.dart';
import '../models/user.dart';

class UserService {
  static Future<UserData?> getUser(context) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/user/me',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return UserData.fromJson(data['data']);
  }

  static Future<bool?> changeLanguage(context, int id) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/change-lang',
      data: {
        'id': id
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changeLanguageForUser(context, int? userId, int? langId) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/change-lang/$userId',
      data: {
        'lang_id': langId
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> saveSalary(context, int? userId, int? salary) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/change-salary/$userId',
      data: {
        'salary': salary
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changePassword(
      context,
      int? userId,
      String oldPassword,
      String newPassword,
      String confirmPassword,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/$userId/change-password',
      data: {
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changeGeneralInfo(
      context,
      int? userId,
      String? name,
      String? phone,
      String? email,
      String? siteName
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/school/change-general-info/$userId',
      data: {
        'school_name': name,
        'site_name': siteName,
        'phone': phone,
        'email': email,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changeSocialAccounts(
      context,
      int? userId,
      String? instagram,
      String? facebook,
      String? linkedin,
      String? twitter
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/user/change-social-account/$userId',
      data: {
        'instagram': instagram,
        'facebook': facebook,
        'linkedin': linkedin,
        'twitter': twitter,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<String?> uploadAvatar(
      context,
      int? userId,
      File file
      ) async {
    final token = getToken(context);
    if(token == null) return null;

    FormData formData = FormData();

    formData.files.add(
      MapEntry(
        'avatar',
        await MultipartFile.fromFile(file.path),
      ),
    );

    final response = await ApiClient().dio.post(
      '/user/upload-avatar/$userId',
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    if(data['success'] == true){
      return data['avatar'];
    }
    return null;
  }

  static Future<bool?> addDocument(
      context,
      int? userId,
      FormData formData
      ) async {
    final token = getToken(context);
    if(token == null) return null;

    final response = await ApiClient().dio.post(
      '/user/$userId/download-document',
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> deleteDocument(
      context,
      int? documentId,
      ) async {
    final token = getToken(context);
    if(token == null) return null;

    final response = await ApiClient().dio.delete(
      '/user/delete-document',
      data: {
        "document_id": documentId
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changeNotifications(
      context,
      bool hasOn,
      ) async {
    final token = getToken(context);
    if(token == null) return null;

    final response = await ApiClient().dio.post(
      '/user/change-notifications',
      data: {
        "notifications": hasOn
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> changeGeneralInfoStudent(
      context,
      int? userId,
      String? fullName,
      String? phone,
      String? email,
      String? about,
      String? country,
      String? city,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/student/setting/change-general-info/$userId',
      data: {
        'full_name': fullName,
        'phone': phone,
        'email': email,
        'about': about,
        'country': country,
        'city': city,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

}
