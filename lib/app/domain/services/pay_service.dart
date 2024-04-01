import 'package:dio/dio.dart';
import 'package:european_university_app/app/ui/utils/get_token.dart';

import '../../data/api_client.dart';
import '../models/meta.dart';
import '../models/services.dart';

class PayService {

  static Future<Map<String, dynamic>?> selectService(
      context,
      int? serviceId,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/student/school/$serviceId/select-service',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data;
  }


  static Future<Map<String, dynamic>?> fetchConnectStatus(
      context,
      String type,
      dataMap
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/payment/check-connect',
      data: {
        'type': type,
        'data': dataMap,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data;
  }


  static Future<PaymentSettings?> fetchPaymentSettings(
      context
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/payment/fetch-list',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return PaymentSettings.fromJson(data);
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
