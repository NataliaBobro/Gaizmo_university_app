import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/services/student_lesson_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/lesson.dart';

class StudentHomeState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  LessonsList? _lessonsListToday;

  bool get isLoading => _isLoading;

  StudentHomeState(this.context){
    Future.microtask(() {
      updateUser();
      fetchLessonToday();
    });
  }

  LessonsList? get lessonsListToday => _lessonsListToday;

  void updateUser() {
    context.read<AppState>().getUser();
  }

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
      if(context.mounted){
        notifyListeners();
      }
    }
  }

}