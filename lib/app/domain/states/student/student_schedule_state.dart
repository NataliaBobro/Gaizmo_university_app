import 'package:european_university_app/app/domain/services/student_lesson_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/screens/students/schedule/filter/schedule_filter_screen.dart';
import '../../models/lesson.dart';
import '../../models/schedule.dart';

class StudentScheduleState with ChangeNotifier {
  BuildContext context;
  int _filterDateIndex = 5;
  int? _editId;
  bool _isLoading = true;
  LessonsList? _lessonsList;
  List<Map<String, dynamic>> _listServices = [];
  List<Map<String, dynamic>> _listClass = [];
  List<Map<String, dynamic>> _listTeacher = [];
  final FilterSchedule _filterSchedule = FilterSchedule(
      type: [],
      teacher: [],
      selectClass: []
  );

  StudentScheduleState(this.context){
    Future.microtask(() async {
      await getLesson();
      fetchMeta();
    });
  }

  int get filterDateIndex => _filterDateIndex;
  int? get editId => _editId;
  bool get isLoading => _isLoading;
  FilterSchedule get filterSchedule => _filterSchedule;
  LessonsList? get lessonsList => _lessonsList;
  List<Map<String, dynamic>> get listTypeServices => _listServices;
  List<Map<String, dynamic>> get listTeacher => _listTeacher;
  List<Map<String, dynamic>> get listClass => _listClass;


  void changeDateFilter(index) {
    _filterDateIndex = index;
    notifyListeners();
    getLesson();
  }


  void changeFilterType(List<int>value) {
    _filterSchedule.type = value;
    notifyListeners();
  }

  void changeFilterTeacher(List<int>value) {
    _filterSchedule.teacher = value;
    notifyListeners();
  }

  void changeFilterClass(List<int>value) {
    _filterSchedule.selectClass = value;
    notifyListeners();
  }



  Future<void> openFilter() async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: const ScheduleFilterScreen(),
            )
        )
    );
  }

  Future<void> getLesson() async {
    DateTime now = DateTime.now();
    DateTime date = now.add(Duration(days: _filterDateIndex - 5));
    try{
      _lessonsList = await StudentLessonService.getLessonForDay(
          context,
          date.toString(),
          filterSchedule
      );
    }catch (e) {
      if(kDebugMode){
        print(e);
      }
    } finally {
      _isLoading = false;
      if(context.mounted){
        notifyListeners();
      }
    }
  }

  Future<void> fetchMeta() async {
    _isLoading = true;
   if(context.mounted){
     notifyListeners();
   }
    try {
      final result = await StudentLessonService.fetchMeta(context);
      if(result != null){
        _listServices = [];
        if(result.services != null){
          for(var a = 0; a < (result.services?.length ?? 0); a++){
            _listServices.add({
              "id": result.services?[a]?.id,
              "name": result.services?[a]?.name,
            });
          }
        }
        if(result.teacher != null) {
          for(var a = 0; a < (result.teacher?.length ?? 0); a++){
            _listTeacher.add({
              "id": result.teacher?[a].id,
              "name": '${result.teacher?[a].firstName} ${result.teacher?[a].lastName}',
            });
          }
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
     if(context.mounted){
       notifyListeners();
     }
    }
  }

  void back(){
    Navigator.pop(context);
  }
}