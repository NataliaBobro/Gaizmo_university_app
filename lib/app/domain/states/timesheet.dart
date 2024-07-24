import 'package:european_university_app/app/domain/services/timesheet_servcie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/timesheet.dart';

class TimesheetState with ChangeNotifier {
  BuildContext context;
  int? _user_id;
  bool _isLoading = true;
  TimesheetModel? _timesheetModel;

  TimesheetState(this.context, this._user_id){
    Future.microtask(() {
        fetchList();
    });
  }

  TimesheetModel? get timesheetModel => _timesheetModel;
  bool get isLoading => _isLoading;


  Future<void> fetchList()async {
    try{
      final result = await TimesheetService.fetchList(context, _user_id);
      if(result?.success == true){
        _timesheetModel = result;
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