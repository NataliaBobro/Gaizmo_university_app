import 'package:flutter/material.dart';


class ChatsState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;


  ChatsState(this.context);

  bool get isLoading => _isLoading;


}