import 'package:european_university_app/app/domain/services/student_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/services.dart';


class StudentGroupsState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  ServicesData? _servicesData;

  bool get isLoading => _isLoading;
  ServicesData? get servicesData => _servicesData;


  StudentGroupsState(this.context){
    Future.microtask(() {
      fetchService();
    });
  }

  Future<void> fetchService() async {
    _isLoading = true;
    notifyListeners();
    try{
      final result = await StudentService.fetchService(context);
      if(result != null){
        _servicesData = result;
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
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