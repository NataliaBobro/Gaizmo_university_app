import 'package:flutter/material.dart';

import '../../models/lesson.dart';
import '../../services/teacher_lesson_service.dart';

class TeacherHomeState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  LessonsList? _lessonsListToday;

  bool get isLoading => _isLoading;

  TeacherHomeState(this.context){
    Future.microtask(() {
      fetchLessonToday();
    });
  }

  LessonsList? get lessonsListToday => _lessonsListToday;

  Future<void> fetchLessonToday()async {
    _isLoading = true;
    notifyListeners();
    try{
      final result = await TeacherLessonService.fetchToday(context);
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