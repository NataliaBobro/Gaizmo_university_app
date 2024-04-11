import 'package:flutter/material.dart';


class ProgressState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;


  ProgressState(this.context);

  bool get isLoading => _isLoading;


}