import 'package:flutter/material.dart';

import '../../app.dart';
import '../theme/text_styles.dart';

void showMessage(String text, {Color? color}) {
  final snackbar = SnackBar(
      backgroundColor: color ?? Colors.red,
      content: Text(
        text,
        style: TextStyles.s14w500.copyWith(color: Colors.white),
      ));
  scaffoldMessengerKey.currentState
    ?..removeCurrentSnackBar()
    ..showSnackBar(snackbar);
}
