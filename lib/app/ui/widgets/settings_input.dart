import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';


class SettingsInput extends StatefulWidget {
  const SettingsInput({
    Key? key,
    required this.title,
    required this.onPress,
    this.value,
  }) : super(key: key);

  final String title;
  final Function onPress;
  final Widget? value;

  @override
  State<SettingsInput> createState() => _SettingsInputState();
}

class _SettingsInputState extends State<SettingsInput> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0.0,
      padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: SizerUtil.width - 100,
              minWidth: 136
            ),
            child: Text(
              widget.title,
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF848484)
              ),
            ),
          ),
          if(widget.value != null) ...[
            Container(
              constraints: const BoxConstraints(
                maxWidth: 110
              ),
              child: widget.value,
            ),
            const Spacer()
          ],
          SvgPicture.asset(
            Svgs.next,
            width: 32,
          )
        ],
      ),
      onPressed: () {
        widget.onPress();
      },
    );
  }
}



class SettingsInputButton extends StatefulWidget {
  const SettingsInputButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.value,
  }) : super(key: key);

  final String title;
  final Function onPress;
  final Widget? value;

  @override
  State<SettingsInputButton> createState() => _SettingsInputButtonState();
}

class _SettingsInputButtonState extends State<SettingsInputButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 4
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CupertinoButton(
        minSize: 0.0,
        padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: AppColors.appButton,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: SvgPicture.asset(
                Svgs.profesor,
                width: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: SizerUtil.width - 160,
                  minWidth: 110
              ),
              child: Text(
                widget.title,
                style: TextStyles.s14w600.copyWith(
                    color: AppColors.fgDefault
                ),
              ),
            ),
            if(widget.value != null) ...[
              Container(
                constraints: const BoxConstraints(
                    maxWidth: 90
                ),
                child: widget.value,
              ),
              const Spacer()
            ],
            const Spacer(),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.appButton,
                borderRadius: BorderRadius.circular(100)
              ),
              child: SvgPicture.asset(
                Svgs.next,
                width: 32,
                color: Colors.white,
              ),
            )
          ],
        ),
        onPressed: () {
          widget.onPress();
        },
      ),
    );
  }
}
