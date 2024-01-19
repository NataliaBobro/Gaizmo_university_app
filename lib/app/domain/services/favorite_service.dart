import 'package:dio/dio.dart';
import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';
import '../models/services.dart';


class FavoriteService {
  static Future<ListServicesModel?> fetchFavoriteLessons(
      context,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/student/favorite/list',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListServicesModel.fromJson(data);
  }

  static Future<bool?> add(
      context,
      int? serviceId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/student/favorite/add',
      data: {
        'service_id': serviceId
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<bool?> delete(
      context,
      int? serviceId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.delete(
      '/student/favorite/delete',
      data: {
        'service_id': serviceId
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

}
