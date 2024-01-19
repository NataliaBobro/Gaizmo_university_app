import 'package:etm_crm/app/domain/services/student_lesson_service.dart';
import 'package:flutter/material.dart';

import '../../models/lesson.dart';

class StudentHomeState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  LessonsList? _lessonsListToday;

  bool get isLoading => _isLoading;

  StudentHomeState(this.context){
    Future.microtask(() {
      fetchLessonToday();
    });
  }

  LessonsList? get lessonsListToday => _lessonsListToday;

  Future<void> fetchLessonToday()async {
    _isLoading = true;
    notifyListeners();
    try{
      final result = await StudentLessonService.fetchToday(context);
      if(result != null) {
        _lessonsListToday = result;
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

}