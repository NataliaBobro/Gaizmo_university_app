import 'package:flutter/material.dart';

class ProgressState with ChangeNotifier {
  BuildContext context;
  final bool _isLoading = false;


  ProgressState(this.context);

  bool get isLoading => _isLoading;


}