import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/services/staff_service.dart';
import 'package:european_university_app/app/domain/states/school/school_staff_item_state.dart';
import 'package:european_university_app/app/ui/screens/school/staff/item/staff_item_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/screens/school/staff/add_staff_screen.dart';
import '../../../ui/utils/show_message.dart';
import '../../../ui/widgets/snackbars.dart';
import '../../models/meta.dart';
import '../../models/user.dart';

class SchoolStaffState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  ValidateError? _validateError;
  ListUserData? _staffList;

  SchoolStaffState(this.context){
    Future.microtask(() {
      getStaff();
    });
  }

  ValidateError? get validateError => _validateError;
  bool get isLoading => _isLoading;
  ListUserData? get staffList => _staffList;

  Future<void> openAddStaff() async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: const AddStaffScreen(),
            )
        )
    );
  }
  Future<void> openStaff(UserData? staff) async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => SchoolStaffItemState(context, staff),
              child: const StaffItemScreen(),
            )
        )
    );
  }

  Future<void> getStaff() async{
    _isLoading = true;
    notifyListeners();
    try{
      final result = await StaffService.fetchStaff(context);
      if(result != null){
        _staffList = result;
      }
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOrEditStaff(
      String? firstName,
      String? lastName,
      int? genderId,
      String? dateBirth,
      String? phone,
      String? email,
      String? country,
      String? city,
      String? street,
      String? house,
      String? salary,
      ) async {
    _validateError = null;
    notifyListeners();
    Map<String, dynamic> data = {
      'first_name': firstName,
      'last_name': lastName,
      'gender': genderId,
      'date_birth': dateBirth,
      'phone': phone,
      'email': email,
      'country': country,
      'city': city,
      'street': street,
      'house': house,
      'salary': salary,
    };
    try {
      final result = await StaffService.addStaff(
          context,
          data
      );
      if(result != null){
        back();
        getStaff();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void back(){
    Navigator.pop(context);
  }

}