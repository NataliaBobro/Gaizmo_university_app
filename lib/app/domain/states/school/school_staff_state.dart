import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/services/staff_service.dart';
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
  bool _isLoading = false;
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

  Future<void> getStaff() async{
    try{
      final result = await StaffService.fetchStaff(context);
      if(result != null){
        _staffList = result;
        notifyListeners();
      }
    }catch (e){
      print(e);
    }
  }

  Future<void> addOrEditStaff(
      String? firstName,
      String? lastName,
      String? surName,
      int? genderId,
      String? dateBirth,
      String? phone,
      String? email,
      String? country,
      String? city,
      String? street,
      String? house,
      ) async {
    _validateError = null;
    notifyListeners();
    Map<String, dynamic> data = {
      'first_name': firstName,
      'last_name': lastName,
      'surname': surName,
      'gender': genderId,
      'date_birth': dateBirth,
      'phone': phone,
      'email': email,
      'country': country,
      'city': city,
      'street': street,
      'house': house,
    };
    try {
      final result = await StaffService.addStaff(
          context,
          data
      );
      if(result != null){
        back();
        // getStaff();
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