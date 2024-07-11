import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/services/shop_servcie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shop.dart';

class OrderState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  ListProducts? _listProducts;
  bool isSchool = false;

  OrderState(this.context, {this.isSchool = false}){
    Future.microtask(() {
      fetchListOrders();
    });
  }

  bool get isLoading => _isLoading;
  ListProducts? get listProducts => _listProducts;


  Future<void> fetchListOrders() async{
    _isLoading = true;
    notifyListeners();

    final userData = context.read<AppState>().userData;
    try{
      if(isSchool){
        final result = await ShopService.fetchListOrders(
            context,
            schoolId: userData?.school?.id
        );
        if(result != null){
          _listProducts = result;
        }
      }else{
        final result = await ShopService.fetchListOrders(
            context,
            userId: userData?.id
        );
        if(result != null){
          _listProducts = result;
        }
      }
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> onUpdateStatus(Products product) async{
    _isLoading = true;
    notifyListeners();

    try{
      final result = await ShopService.updateOrderStatus(
          context,
          product.orderId
      );
      if(result != null){
        _listProducts?.data.firstWhere((element) => element.orderId == product.orderId).deliveryStatus = 'SUCCESS';
      }
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void back(){
    Navigator.pop(context);
  }

  void updateUser(){
    context.read<AppState>().getUser();
  }

}