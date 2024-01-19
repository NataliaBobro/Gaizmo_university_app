import 'package:etm_crm/app/domain/services/favorite_service.dart';
import 'package:etm_crm/app/domain/services/pay_service.dart';
import 'package:flutter/material.dart';

import '../../models/services.dart';

class FavoriteState with ChangeNotifier {
  BuildContext context;
  final bool _isLoading = false;
  ListServicesModel? _favoriteLessons;
  ListServicesModel? _payLessons;

  FavoriteState(this.context){
    Future.microtask(() async {
      await fetchFavoriteLessons();
      await fetchPayList();
    });
  }

  bool get isLoading => _isLoading;
  ListServicesModel? get favoriteLessons => _favoriteLessons;
  ListServicesModel? get payLessons => _payLessons;

  void close() {
    Navigator.pop(context);
  }

  Future<void> fetchFavoriteLessons() async {
    try{
      final result = await FavoriteService.fetchFavoriteLessons(context);
      if(result != null) {
        _favoriteLessons = result;
      }
    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
  }

  Future<void> fetchPayList() async {
    try{
      final result = await PayService.fetchListPayService(context);
      if(result != null) {
        _payLessons = result;
      }
    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
  }

  Future<void> deleteFavorite(ServicesModel? service) async {
    try{
      final result = await FavoriteService.delete(context, service?.id);
      if(result != null) {
        _favoriteLessons?.services?.remove(service);
      }
    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
  }
}