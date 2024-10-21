import 'package:european_university_app/app/domain/services/favorite_service.dart';
import 'package:european_university_app/app/domain/services/pay_service.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
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

  Future<void> deleteFavoriteConfirm(
      ServicesModel? service,
      {
        bool isPayed = false
      }) async {
    try{
      if(isPayed){
        final result = await FavoriteService.deletePayed(context, service?.id);
        if(result != null) {
          _payLessons?.services?.remove(service);
        }
      }else{
        final result = await FavoriteService.delete(context, service?.id);
        if(result != null) {
          _favoriteLessons?.services?.remove(service);
        }
      }
    }catch(e){
      print(e);
    }finally{
      notifyListeners();
    }
  }

  void deleteFavorite(BuildContext context, ServicesModel? service, bool isPayed) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(getConstant('Delete Confirmation')),
          content: Text(getConstant('Are you sure you want to delete?')),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(getConstant('Close')),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                deleteFavoriteConfirm(service, isPayed: isPayed);
              },
              child: Text(getConstant('Delete')),
            ),
          ],
        );
      },
    );
  }
}