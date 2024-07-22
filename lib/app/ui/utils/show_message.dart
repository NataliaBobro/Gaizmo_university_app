import 'package:flutter/material.dart';

import '../../app.dart';
import '../theme/text_styles.dart';

void showMessage(String text, {Color? color}) {
  String replaceText = text.replaceAll('(and 4 more errors)', '')
      .replaceAll('(and 3 more errors)', '')
      .replaceAll('(and 5 more errors)', '')
      .replaceAll('(and 2 more errors)', '')
      .replaceAll('(and 1 more error)', '');

  final snackbar = SnackBar(
      backgroundColor: color ?? Colors.red,
      content: Text(
        replaceText,
        style: TextStyles.s14w500.copyWith(color: Colors.white),
      ));
  scaffoldMessengerKey.currentState
    ?..removeCurrentSnackBar()
    ..showSnackBar(snackbar);
}
