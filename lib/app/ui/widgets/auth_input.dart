import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/text_styles.dart';

class AuthInput extends StatefulWidget {
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
    this.keyboardType,
    this.focusNode,
  }) : super(key: key);

  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool isPass;
  final bool isBottomPadding;
  final double? maxWidth;
  final String? errors;
  final Widget? bottomLeftWidget;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
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
        '${widget.errors}',
        style: TextStyles.s12w400.copyWith(
            color: const Color(0xFFFFC700)
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyles.s14w400.copyWith(
              color: const Color(0xFF848484)
          ),
        ),
        TextField(
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          controller: widget.controller,
          obscureText: widget.isPass,
          style: TextStyles.s16w400.copyWith(
            color: Colors.white,
          ),
          cursorColor: const Color(0xFF1167C3),
          decoration: InputDecoration(
            constraints: BoxConstraints(
              maxWidth: widget.maxWidth ?? SizerUtil.width
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
            hintText: widget.hintText,
            fillColor: Colors.transparent,
          ),
        ),
        Container(
          height: 1,
          width: widget.maxWidth ?? double.infinity,
          color: widget.errors == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
        ),
        if(widget.bottomLeftWidget != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.bottomLeftWidget!,
              if(widget.errors != null) ...[
                errorText,
              ],
            ],
          ),

        ] else ...[
          if(widget.errors != null) ...[
            errorText,
          ],
        ],
        if(widget.isBottomPadding) ...[
          const SizedBox(
            height: 24,
          )
        ]
      ],
    );
  }
}