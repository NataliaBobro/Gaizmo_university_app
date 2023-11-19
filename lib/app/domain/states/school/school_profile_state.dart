import 'package:flutter/material.dart';

class SchoolProfileState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  SchoolProfileState(this.context);

}