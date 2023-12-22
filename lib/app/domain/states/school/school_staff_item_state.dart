import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/staff_service.dart';

class SchoolStaffItemState with ChangeNotifier {
  BuildContext context;
  final UserData? _staff;

  SchoolStaffItemState(this.context, this._staff);

  UserData? get staff => _staff;

  Future<void> saveGeneralInfo(fullName, phone, email) async {
    try{
      final result = await StaffService.saveGeneralInfo(
          context,
          _staff?.id,
          {
            'full_name': fullName,
            'phone': phone,
            'email': email,
          }
      );
      if(result == true){
        final nameArray = fullName.split(' ');
        if(nameArray.isNotEmpty){
          _staff?.firstName = nameArray[0];
        }
        if(nameArray.length > 1){
          _staff?.lastName = nameArray[1];
        }
        if(nameArray.length > 2){
          _staff?.surname = nameArray[2];
        }
        _staff?.phone = phone;
        _staff?.email = email;
        notifyListeners();
        back();
      }
    }catch (e){
      print(e);
    }
  }

  void back(){
    Navigator.pop(context);
  }

}