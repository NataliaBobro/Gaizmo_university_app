import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/student_service.dart';
import 'package:flutter/material.dart';

class StudentSchoolState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  ListUserData? _listSchool;

  bool get isLoading => _isLoading;
  ListUserData? get listSchool => _listSchool;

  StudentSchoolState(this.context){
    Future.microtask(() {
        fetchList();
    });
  }

  Future<void> fetchList() async {
    _isLoading = true;
    notifyListeners();

    try{
      final result = await StudentService.fetchList(context);
      if(result != null){
        _listSchool = result;
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }

  }

}