import 'package:etm_crm/app/domain/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/staff_service.dart';

class SchoolStaffItemState with ChangeNotifier {
  BuildContext context;
  UserData? _staff;
  ValidateError? _validateError;

  SchoolStaffItemState(this.context, this._staff);

  UserData? get staff => _staff;
  ValidateError? get validateError => _validateError;

  Future<void> saveGeneralInfo(fullName, phone, email, about) async {
    try{
      final result = await StaffService.saveGeneralInfo(
          context,
          _staff?.id,
          {
            'full_name': fullName,
            'phone': phone,
            'email': email,
            'about': about,
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
        _staff?.about = about;
        notifyListeners();
        back();
      }
    }catch (e){
      print(e);
    }
  }

  Future<void> updateStaff() async {
    try{
      final result = await StaffService.getStaff(context, staff?.id);
      if(result != null){
        _staff = result;
        notifyListeners();
      }
    }catch(e){
      print(e);
    }
  }

  Future<void> saveDateBirth(String? value) async {
    try{
      final result = await StaffService.saveBirthDate(
          context,
          _staff?.id,
          {
            'date_birth': value,
          }
      );
      if(result == true){
        DateFormat inputFormat = DateFormat('d-MMMM-yyyy', 'en_US');
        DateTime parsedDate = inputFormat.parse('$value');
        DateFormat outputFormat = DateFormat('yyyy-MM-d', 'en_US');
        String formattedDate = outputFormat.format(parsedDate);
        _staff?.dateBirth = formattedDate;
        notifyListeners();
        back();
      }
    }catch (e){
      print(e);
    }
  }

  Future<void> saveGender(int? gender) async {
    try{
      final result = await StaffService.saveGender(
          context,
          _staff?.id,
          {
            'gender': gender,
          }
      );
      if(result == true){
        staff?.gender = gender;
        notifyListeners();
        back();
      }
    }catch (e){
      print(e);
    }
  }

  Future<void> saveAddress(
      String? country,
      String? city,
      String? street,
      String? house,
      ) async {
    try{
      final result = await StaffService.saveAddress(
          context,
          _staff?.id,
          {
            'country': country,
            'city': city,
            'street': street,
            'house': house,
          }
      );
      if(result == true){
        staff?.country = country;
        staff?.city = city;
        staff?.street = street;
        staff?.house = house;
        notifyListeners();
        back();
      }
    }catch (e){
      print(e);
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

  void back(){
    Navigator.pop(context);
  }

}