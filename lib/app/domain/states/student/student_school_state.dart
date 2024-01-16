import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/student_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/meta.dart';

class StudentSchoolState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  ListUserData? _listSchool;
  FilterDataString? _filterDataString;
  List<Map<String, dynamic>>? _selectedFilterCity;

  bool get isLoading => _isLoading;
  ListUserData? get listSchool => _listSchool;
  FilterDataString? get filterDataString => _filterDataString;
  List<Map<String, dynamic>>? get selectedFilterCity => _selectedFilterCity;

  StudentSchoolState(this.context){
    Future.microtask(() {
        fetchList();
    });
  }

  Future<void> fetchList({String? search}) async {
    _isLoading = true;
    notifyListeners();

    List<String> filterCity = [];

    if((_selectedFilterCity?.length ?? 0) > 0){
      for(var a = 0; a < (_selectedFilterCity?.length ?? 0); a++){
        filterCity.add(_selectedFilterCity![a]['name']);
      }
    }

    try{
      final result = await StudentService.fetchList(
          context,
          filterCity,
          search: search
      );
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

  Future<void> fetchDataFilter() async {
    try{
      final result = await StudentService.fetchDataFilterSchool(context);
      if(result != null){
        _filterDataString = result;
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
    _selectedFilterCity = value;
    notifyListeners();
  }

}