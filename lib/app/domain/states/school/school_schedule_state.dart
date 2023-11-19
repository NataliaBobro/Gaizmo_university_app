import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchoolScheduleState with ChangeNotifier {
  BuildContext context;
  int _filterDateIndex = 0;

  SchoolScheduleState(this.context);

  int get filterDateIndex => _filterDateIndex;

  void changeDateFilter(index) {
    _filterDateIndex = index;
    notifyListeners();
  }
}