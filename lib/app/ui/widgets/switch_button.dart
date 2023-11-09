import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class SwitchButton extends StatelessWidget {
  final bool isActive;
  final String text;
  final VoidCallback? onTap;
  final double fontSize;
  final double height;
  const SwitchButton({
    Key? key,
    required this.text,
    this.isActive = false,
    this.fontSize = 15,
    this.height = 1.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        decoration: isActive
            ?  const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.navyBlue),
                ),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            text,
            style: TextStyles.s15w500.copyWith(
              fontSize: fontSize,
              height: height,
              color: isActive ? AppColors.navyBlue : AppColors.grey605,
            ),
          ),
        ),
      ),
    );
  }
}
