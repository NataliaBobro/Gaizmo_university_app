import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static final _borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide.none,
  );

  static final appTheme = ThemeData(
    fontFamily: 'SfUiDisplay',
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      labelStyle: TextStyles.s15w400.copyWith(
        color: AppColors.grey605,
      ),
      floatingLabelStyle: TextStyles.s14w400.copyWith(
        color: AppColors.grey605,
        height: 4,
      ),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: _borderStyle,
      focusedBorder: _borderStyle,
      errorBorder: _borderStyle,
      focusedErrorBorder: _borderStyle,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.main,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.grey2),
    ),
  );
}
