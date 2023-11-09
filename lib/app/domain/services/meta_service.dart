import '../../data/api_client.dart';
import '../models/meta.dart';

class MetaService {
  static Future<MetaAppData?> fetchMeta() async {
    final response = await ApiClient().dio.get(
          '/auth/meta',
        );
    final data = response.data as Map<String, dynamic>;
    return MetaAppData.fromJson(data);
  }

}
