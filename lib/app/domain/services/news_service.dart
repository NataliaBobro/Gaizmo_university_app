import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/models/news.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';

class NewsService {
  static Future<NewsList?> fetchSchoolNews(
      BuildContext context
      ) async {

    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/school/news/fetch-news',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return NewsList.fromJson(data);
  }
}
