import 'package:flutter/material.dart';

class TeacherHomeState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  TeacherHomeState(this.context);

}