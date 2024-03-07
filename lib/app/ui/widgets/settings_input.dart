import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../theme/text_styles.dart';


class SettingsInput extends StatefulWidget {
  const SettingsInput({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final Function onPress;

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
              maxWidth: SizerUtil.width - 100
            ),
            child: Text(
              widget.title,
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF848484)
              ),
            ),
          ),
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
