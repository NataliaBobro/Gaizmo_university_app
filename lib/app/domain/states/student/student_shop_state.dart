import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/domain/services/shop_servcie.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui/utils/show_message.dart';
import '../../../ui/utils/url_launch.dart';
import '../../models/shop.dart';

class StudentShopState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  ListProducts? _listProducts;
  ListUserData? _schoolList;
  Map<String, dynamic>? _filterSchool;

  StudentShopState(this.context){
    Future.microtask(() {
      fetchListProduct();
      fetchMeta();
    });
  }

  bool get isLoading => _isLoading;
  ListProducts? get listProducts => _listProducts;
  ListUserData? get schoolList => _schoolList;
  Map<String, dynamic>? get filterSchool => _filterSchool;


  void changeFilter(value)
  {
    _filterSchool = value;
    notifyListeners();
    fetchListProduct();
  }

  Future<void> fetchMeta() async{
    _isLoading = true;
    notifyListeners();
    try{
      final result = await ShopService.fetchMeta(
          context
      );
      if(result != null){
        _schoolList = result;
      }

    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchListProduct() async{
    _isLoading = true;
    notifyListeners();
    try{
      final result = await ShopService.fetchListProduct(
          context,
          _filterSchool?['id']
      );
      if(result != null){
        _listProducts = result;
      }
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> payProduct(int? productId, String? paymentType) async {
    _isLoading = true;
    notifyListeners();
    try{
      if(paymentType == 'money'){
        final result = await ShopService.payProduct(
            context,
            productId
        );
        if(result != null && result['link'] != null){
          if(result['link'] == false){
            showMessage('Payment not possible. Please contact your school '
                'administrator to set up payment details.', color: const Color(0xFFFFC700));
          }else{
            openPayWeb(result['link'], result['order_reference'], productId);
          }
        }
      }else{
        final result = await ShopService.payProductEtm(
            context,
            productId
        );
        print(result);
        if(result != null && result == true){
          openPayed();
        }else{
          showMessage(getConstant('Error_etm_balance'));
        }
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> openPayWeb(String? link, orderReference,  serviceId) async {
    openWebView(context, link).whenComplete(() async {
      final resStatus = await ShopService.fetchPayStatus(
        context,
        serviceId,
        orderReference,
      );

      if(resStatus != null){
        _isLoading = false;
        notifyListeners();
        if(resStatus['pay_status'] == true){
          openPayed();
        }else{
          showMessage(getConstant('Error_pay'));
        }
      }
    });
  }

  void openPayed(){
    Navigator.pop(context);
  }

  void back(){
    Navigator.pop(context);
  }

  void updateUser(){
    context.read<AppState>().getUser();
  }

}