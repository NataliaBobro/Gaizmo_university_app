import 'package:flutter/material.dart';

class StudentHomeState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  StudentHomeState(this.context);

}