import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 16
      ),
      child: Text(
        title,
        style: TextStyles.s14w600.copyWith(
            color: AppColors.appButton
        ),
      ),
    );
  }
}
