import 'package:dio/dio.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/services/shop_servcie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../../ui/utils/show_message.dart';
import '../../models/shop.dart';

class SchoolShopState with ChangeNotifier {
  BuildContext context;
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescription = TextEditingController();
  String? _imageUrl;
  final MaskedTextController  _priceEtm = MaskedTextController(
      mask: '0000'
  );
  final MaskedTextController  _priceMoney = MaskedTextController(
      mask: '0000'
  );
  ValidateError? _validateError;
  File? _uploadsFile;
  bool _isLoading = true;
  ListProducts? _listProducts;
  Products? _editProduct;

  SchoolShopState(this.context){
    Future.microtask(() {
      fetchListProduct();
    });
  }

  bool get isLoading => _isLoading;
  TextEditingController get productName => _productName;
  TextEditingController get productDescription => _productDescription;
  File? get uploadsFile => _uploadsFile;
  String? get imageUrl => _imageUrl;
  TextEditingController get priceEtm => _priceEtm;
  TextEditingController get priceMoney => _priceMoney;
  ValidateError? get validateError => _validateError;
  ListProducts? get listProducts => _listProducts;
  Products? get editProduct => _editProduct;

  void selectImage(value){
    if(value == null){
      _imageUrl = null;
    }
    _uploadsFile = value;
    notifyListeners();
  }

  void initDataEditProduct(Products? product) {
    if(product != null){
      _editProduct = product;
      _productName.text = product.name ?? '';
      _productDescription.text = product.desc ?? '';
      _priceEtm.text = '${product.priceEtm ?? ''}';
      _priceMoney.text = '${product.priceMoney ?? ''}';
      _imageUrl = product.image ?? '';
    }else{
      clear();
    }
    notifyListeners();
  }

  Future<void> fetchListProduct() async{
    _isLoading = true;
    notifyListeners();

    final school = context.read<AppState>().userData?.school;
    try{
      final result = await ShopService.fetchListProduct(
          context,
          school?.id
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

  Future<void> saveProduct() async{
    _isLoading = true;
    notifyListeners();
    try{
      final result = await ShopService.addOrEditProduct(
          context,
          _editProduct?.id,
          _productName.text,
          _productDescription.text,
          _priceEtm.text,
          _priceMoney.text,
          _imageUrl,
          _uploadsFile,
      );
      if(result != null){
        fetchListProduct();
        back();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> onDeleteProduct(int? productId) async{
    _isLoading = true;
    notifyListeners();
    try{
      final result = await ShopService.deleteProduct(
          context,
          productId
      );
      if(result != null){
        fetchListProduct();
      }
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _editProduct = null;
    _productName.clear();
    _productDescription.clear();
    _priceEtm.clear();
    _priceMoney.clear();
    _priceMoney.clear();
    _imageUrl = null;
    _uploadsFile = null;
  }

  void back(){
    Navigator.pop(context);
  }

  void updateUser(){
    context.read<AppState>().getUser();
  }

}