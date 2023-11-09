import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/text_styles.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({
    Key? key,
    required this.title,
    required this.controller,
    this.hintText,
    this.isPass = false,
    this.isBottomPadding = true,
    this.maxWidth,
    this.errors,
    this.bottomLeftWidget,
  }) : super(key: key);

  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool isPass;
  final bool isBottomPadding;
  final double? maxWidth;
  final String? errors;
  final Widget? bottomLeftWidget;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.0,
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );

    Widget errorText = Container(
      padding: const EdgeInsets.only(
          top: 4
      ),
      alignment: Alignment.centerRight,
      child: Text(
        '$errors',
        style: TextStyles.s12w400.copyWith(
            color: const Color(0xFFFFC700)
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.s14w400.copyWith(
              color: const Color(0xFF848484)
          ),
        ),
        TextField(
          controller: controller,
          obscureText: isPass,
          style: TextStyles.s16w400.copyWith(
            color: Colors.white,
          ),
          onChanged: (val) {

          },
          cursorColor: const Color(0xFF1167C3),
          decoration: InputDecoration(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? SizerUtil.width
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 8,
            ),
            hintStyle: TextStyles.s16w400.copyWith(
              color: Colors.white,
            ),
            enabledBorder: border,
            border: border,
            errorBorder: border,
            focusedBorder: border,
            hintText: hintText,
            fillColor: Colors.transparent,
          ),
        ),
        Container(
          height: 1,
          width: maxWidth ?? double.infinity,
          color: errors == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
        ),
        if(bottomLeftWidget != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomLeftWidget!,
              if(errors != null) ...[
                errorText,
              ],
            ],
          ),

        ] else ...[
          if(errors != null) ...[
            errorText,
          ],
        ],
        if(isBottomPadding) ...[
          const SizedBox(
            height: 24,
          )
        ]
      ],
    );
  }
}