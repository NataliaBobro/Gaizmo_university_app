import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.horizontalPadding = 40.0,
    this.icon
  }) : super(key: key);

  final Function onPressed;
  final String title;
  final String? icon;
  final double horizontalPadding;


  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding
      ),
      child: CupertinoButton(
        minSize: 0.0,
        padding: EdgeInsets.zero,
        onPressed: () {
          widget.onPressed();
        },
        child: Container(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFFC700),
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
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
