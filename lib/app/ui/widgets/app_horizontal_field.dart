import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/resources.dart';
import '../theme/text_styles.dart';

class AppHorizontalField extends StatelessWidget {
  const AppHorizontalField({
    Key? key,
    required this.label,
    this.placeholder,
    required this.controller,
    this.error,
    required this.changeClear
  }) : super(key: key);

  final String label;
  final String? placeholder;
  final TextEditingController controller;
  final String? error;
  final Function changeClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 16,
        top: 18,
        bottom: 18
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 115,
                child: Text(
                  label,
                  style: TextStyles.s14w400.copyWith(
                      color: const Color(0xFF848484)
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyles.s14w400.copyWith(
                    color: const Color(0xFF242424),
                  ),
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(
                        maxHeight: 28
                    ),
                    hintText: placeholder,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    hintStyle: TextStyles.s14w400.copyWith(
                      color: const Color(0xFF242424),
                    ),
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              CupertinoButton(
                minSize: 0.0,
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(
                  Svgs.close,
                  width: 32,
                  color: const Color(0xFFACACAC),
                ),
                onPressed: () {
                  changeClear();
                }
              )
            ],
          ),
          if(error != null) ...[
            Container(
              padding: const EdgeInsets.only(top: 4),
              alignment: Alignment.centerRight,
              child: Text(
                '$error',
                style: TextStyles.s12w400.copyWith(
                    color: const Color(0xFFFFC700)
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
