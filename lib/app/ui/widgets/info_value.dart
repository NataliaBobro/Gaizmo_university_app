import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/text_styles.dart';


class InfoValue extends StatelessWidget {
  const InfoValue({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18
      ),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            child: Text(
              '$title',
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF848484)
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: SizerUtil.width / 2,
            ),
            child: Text(
              "$value",
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
          )
        ],
      ),
    );
  }
}
