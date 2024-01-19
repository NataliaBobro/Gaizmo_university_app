import 'package:etm_crm/app/domain/models/services.dart';
import 'package:flutter/material.dart';

import '../../services/pay_service.dart';


class PayLessonState with ChangeNotifier {
  BuildContext context;
  final bool _isLoading = false;

  ServicesModel? _servicesModel;

  PayLessonState(this.context, this._servicesModel);

  ServicesModel? get servicesModel => _servicesModel;
  bool get isLoading => _isLoading;

  Future<void> payService(int count) async {
    try{
      final result = await PayService.payStudentCountService(
          context,
          servicesModel?.id,
          count
      );
      if(result == true) {
        close();
      }
    }catch(e) {
      print(e);
    }
  }

  void close() {
    Navigator.pop(context);
  }
}