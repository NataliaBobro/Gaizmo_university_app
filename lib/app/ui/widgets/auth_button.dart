import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.horizontalPadding = 40.0,
    this.icon,
    this.disabled = false,
    this.buttonColor = AppColors.appButton
  }) : super(key: key);

  final Function onPressed;
  final String title;
  final String? icon;
  final Color? buttonColor;
  final double horizontalPadding;
  final bool disabled;


  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding
      ),
      child: CupertinoButton(
        minSize: 0.0,
        padding: EdgeInsets.zero,
        onPressed: widget.disabled ? null : () {
          widget.onPressed();
        },
        child: Container(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.disabled ?
              AppColors.appButtonDisable :
              widget.buttonColor,
            borderRadius: BorderRadius.circular(40)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(widget.icon != null) ... [
                SvgPicture.asset(
                  '${widget.icon}',
                  width: 32,
                ),
                const SizedBox(
                  width: 9,
                )
              ],
              Text(
                widget.title,
                style: TextStyles.s14w600.copyWith(
                    color: AppColors.appButtonText
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
