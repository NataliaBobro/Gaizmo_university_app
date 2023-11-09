import 'package:flutter/material.dart';

class HomeState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HomeState(this.context);

}