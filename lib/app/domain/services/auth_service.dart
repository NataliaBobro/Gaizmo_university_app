
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/user.dart';

class AuthService {
  static Future<UserDataWithToken?> registerStudent(
      int? selectLang,
      int? userType,
      String? firstName,
      String? lastName,
      String? surname,
      int? gender,
      String? dateBirth,
      String? phone,
      String? email,
      String? password,
      String? passwordConfirmation,
      bool? privacy,
      String? code,
      ) async {
    final response = await ApiClient().dio.post(
          '/auth/register/student',
          data: {
            "language_id": selectLang,
            "user_type": userType,
            "first_name": firstName,
            "last_name": lastName,
            "surname": surname,
            "gender": gender,
            "date_birth": dateBirth,
            "phone": phone,
            "email": email,
            "password": password,
            "password_confirmation": passwordConfirmation,
            "privacy": privacy,
            "code": code,
          }
        );
    final data = response.data as Map<String, dynamic>;
    return UserDataWithToken.fromJson(data['data']);
  }

  static Future<UserDataWithToken?> registerTeacher(
      int? selectLang,
      int? userType,
      String? firstName,
      String? lastName,
      String? surname,
      int? gender,
      String? dateBirth,
      String? email,
      String? password,
      String? passwordConfirmation,
      bool? privacy,
      String? code
      ) async {
    final response = await ApiClient().dio.post(
          '/auth/register/teacher',
          data: {
            "language_id": selectLang,
            "user_type": userType,
            "first_name": firstName,
            "last_name": lastName,
            "surname": surname,
            "gender": gender,
            "date_birth": dateBirth,
            "email": email,
            "password": password,
            "password_confirmation": passwordConfirmation,
            "privacy": privacy,
            "code": code,
          }
        );
    final data = response.data as Map<String, dynamic>;
    return UserDataWithToken.fromJson(data['data']);
  }

  static Future<UserDataWithToken?> registerSchool(
      int? selectLang,
      int? userType,
      String? phone,
      String? email,
      String? password,
      String? passwordConfirmation,
      String? schoolName,
      int? schoolCategory,
      String? country,
      String? city,
      String? street,
      String? house,
      bool? privacy,
      String? code,
      ) async {
    final response = await ApiClient().dio.post(
        '/auth/register/school',
        data: {
          "language_id": selectLang,
          "user_type": userType,
          "phone": phone,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "school_name": schoolName,
          "school_category": schoolCategory,
          "country": country,
          "city": city,
          "street": street,
          "house": house,
          "privacy": privacy,
          "code": code,
        }
    );
    final data = response.data as Map<String, dynamic>;
    return UserDataWithToken.fromJson(data['data']);
  }

  static Future<bool?> sendCode(
      String? email,
      ) async {
    final response = await ApiClient().dio.post(
          '/auth/register/send-code',
          data: {
            "email": email,
          }
        );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<UserDataWithToken?> login(
      String? email,
      String? password,
      ) async {
    final response = await ApiClient().dio.post(
          '/auth/login',
          data: {
            "email": email,
            "password": password,
          }
        );
    final data = response.data as Map<String, dynamic>;
    return UserDataWithToken.fromJson(data['data']);
  }

  static Future<bool?> sendRecoveryCode(
      String? email,
      ) async {
    final response = await ApiClient().dio.post(
        '/auth/send-recovery-code',
        data: {
          "email": email,
        }
      );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> confirmCode(
      String? email,
      String? code,
      ) async {
    final response = await ApiClient().dio.post(
        '/auth/confirm-code',
        data: {
          "email": email,
          "code": code,
        }
      );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> setNewPassword(
      String? email,
      String? code,
      String? password,
      String? confirmPassword,
      ) async {
    final response = await ApiClient().dio.post(
        '/auth/set-new-password',
        data: {
          "email": email,
          "code": code,
          "password": password,
          "password_confirmation": confirmPassword,
        }
      );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> saveFcmToken(BuildContext context, String? fcmToken) async {
    final token = getToken(context);
    if (token == null) return null;
    final response = await ApiClient().dio.post(
      '/push/save-token',
      data: {
        'token': fcmToken,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }
}
