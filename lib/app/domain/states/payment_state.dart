import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/services/pay_service.dart';
import 'package:flutter/material.dart';

import '../models/meta.dart';


class PaymentState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  int? _userId;
  PaymentSettings? _paymentSettings;

  PaymentState(this.context, this._userId){
    Future.microtask(() {
      fetchPaymentSettings();
    });
  }

  bool get isLoading => _isLoading;
  int? get userId => _userId;
  PaymentSettings? get paymentSettings => _paymentSettings;


  Future<void> checkWayForPayConnectStatus(String account, String secret)async {
    _isLoading = true;
    notifyListeners();

    try{
      final result = await PayService.fetchConnectStatus(
          context,
          'wayforpay',
          {
            'account': account,
            'secret': secret,
          }
      );
      if(result != null){
        close();
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPaymentSettings()async {
    _isLoading = true;
    notifyListeners();

    try{
      final result = await PayService.fetchPaymentSettings(
          context
      );
      if(result != null){
        _paymentSettings = result;
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void close() {
    routemaster.pop('close');
    Navigator.pop(context);
  }
}