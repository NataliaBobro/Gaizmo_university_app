import 'package:etm_crm/app/domain/services/school_service.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class SchoolBranchState with ChangeNotifier {
  BuildContext context;
  ListUserData? _listUserData;
  bool _isLoading = true;

  SchoolBranchState(this.context){
    Future.microtask(() {
      getBranch();
    });
  }

  ListUserData? get listUserData => _listUserData;
  bool get isLoading => _isLoading;

  Future<void> getBranch() async {
    try{
      final result = await SchoolService.fetchBranchList(context);
      if(result != null){
        _listUserData = result;
        _isLoading = false;
      }
    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
  }

  Future<UserData?> updateBranch(int? branchId) async {
    try{
      final result = await SchoolService.fetchBranchItem(context, branchId);
      if(result != null){
        UserData? branch = _listUserData?.users.firstWhere((element) => element.id == branchId);
        if(branch != null){
          branch = result;
          notifyListeners();
          return result;
        }
      }
    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
    return null;
  }

  Future<void> openPage(BuildContext context, Widget page) async {
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

  void back(){
    Navigator.pop(context);
  }

}