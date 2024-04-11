import 'package:european_university_app/app/domain/models/news.dart';
import 'package:european_university_app/app/domain/services/news_service.dart';
import 'package:flutter/material.dart';


class NewsState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  NewsList? _newsList;

  NewsState(this.context){
    Future.microtask(() {
      fetchSchoolNews();
    });
  }

  NewsList? get newsList => _newsList;
  bool get isLoading => _isLoading;

  Future<void> fetchSchoolNews() async {
    _isLoading = true;
    notifyListeners();
    try{
      final result = await NewsService.fetchSchoolNews(context);
      if(result != null){
        _newsList = result;
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}