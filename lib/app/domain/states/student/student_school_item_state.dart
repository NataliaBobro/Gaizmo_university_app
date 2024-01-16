import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/student_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/services.dart';


class StudentSchoolItemState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  UserData _userSchool;
  ServicesData? _servicesData;

  bool get isLoading => _isLoading;
  UserData get userSchool => _userSchool;
  ServicesData? get servicesData => _servicesData;


  StudentSchoolItemState(this.context, this._userSchool){
    Future.microtask(() {
      fetchService();
    });
  }

  Future<void> fetchService() async {
    try{
      final result = await StudentService.fetchService(context, _userSchool.id);
      if(result != null){
        _servicesData = result;
      }
    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
  }

  Future<void> openPage(Widget page) async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: page,
            )
        )
    );
  }

  void changeFilterCity(value) {
    notifyListeners();
  }

}