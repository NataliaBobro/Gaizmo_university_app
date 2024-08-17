import 'package:european_university_app/app/domain/services/student_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/services.dart';


class StudentGroupsState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  bool _openClear = false;
  ServicesData? _servicesData;
  final TextEditingController _search = TextEditingController();

  bool get isLoading => _isLoading;
  bool get openClear => _openClear;
  ServicesData? get servicesData => _servicesData;
  TextEditingController get search => _search;


  StudentGroupsState(this.context){
    Future.microtask(() {
      fetchService();
    });
  }

  Future<void> fetchService({String? search}) async {
    _isLoading = true;
    notifyListeners();
    try{
      final result = await StudentService.fetchService(context, search);
      if(result != null){
        _servicesData = result;
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


  void openClearButton() {
    if (!_openClear) {
      _openClear = !_openClear;
      notifyListeners();
    }
  }

  void clearTextField() {
    _search.clear();
    fetchService();
    notifyListeners();
  }

  void closeClearButton() {
    if (openClear) {
      _openClear = !_openClear;
      _search.clear();
      fetchService();
      FocusScope.of(context).unfocus();
      notifyListeners();
    }
  }

}