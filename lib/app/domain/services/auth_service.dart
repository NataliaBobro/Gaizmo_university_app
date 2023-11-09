
import '../../data/api_client.dart';
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
      String? paymentNumber,
      String? paymentDate,
      String? paymentCode,
      bool? privacy,
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
            "payment_number": paymentNumber,
            "payment_date": paymentDate,
            "payment_code": paymentCode,
            "privacy": privacy,
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
          }
        );
    final data = response.data as Map<String, dynamic>;
    return UserDataWithToken.fromJson(data['data']);
  }

  static Future<UserDataWithToken?> login(
      String? phone,
      String? password,
      ) async {
    final response = await ApiClient().dio.post(
          '/auth/login',
          data: {
            "phone": phone,
            "password": password,
          }
        );
    final data = response.data as Map<String, dynamic>;
    return UserDataWithToken.fromJson(data['data']);
  }

}
