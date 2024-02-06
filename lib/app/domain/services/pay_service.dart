import 'package:dio/dio.dart';
import 'package:etm_crm/app/ui/utils/get_token.dart';

import '../../data/api_client.dart';
import '../models/services.dart';

class PayService {
  static Future<bool?> payStudentPackageService(
      context,
      int? serviceId,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/student/school/$serviceId/pay',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<ListServicesModel?> fetchListPayService(
      context
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/student/pay/list',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListServicesModel.fromJson(data);
  }

}
