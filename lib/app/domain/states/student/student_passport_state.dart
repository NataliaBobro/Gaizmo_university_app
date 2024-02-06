import 'package:etm_crm/app/app.dart';
import 'package:flutter/material.dart';

class StudentPassportState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;

  StudentPassportState(this.context);

  bool get isLoading => _isLoading;

  void close() {
    routemaster.pop('close');
    Navigator.pop(context);
  }
}