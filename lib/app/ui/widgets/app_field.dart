import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class AppField extends StatelessWidget {
  const AppField({
    Key? key,
    required this.label,
    this.placeholder,
    required this.controller,
    this.error,
    this.keyboardType,
    this.isPass = false,
    this.multiLine = null
  }) : super(key: key);

  final String label;
  final String? placeholder;
  final TextEditingController controller;
  final String? error;
  final bool isPass;
  final int? multiLine;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.s14w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        TextField(
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: isPass,
          controller: controller,
          maxLines: multiLine ?? 1,
          decoration: InputDecoration(
            constraints: BoxConstraints(
                maxHeight: multiLine != null ? 110 : 28
            ),
            hintText: placeholder,
            contentPadding: EdgeInsets.symmetric(
              horizontal: multiLine != null ? 8 : 0,
              vertical: multiLine != null ? 8 : 0,
            ),
            hintStyle: TextStyles.s16w400.copyWith(
              color: Colors.black,
            ),
            fillColor: multiLine != null ? Colors.white : Colors.transparent,
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: error != null ? AppColors.appButton : const Color(0xFF848484),
        ),
        if(error != null) ...[
          Container(
            padding: const EdgeInsets.only(top: 4),
            alignment: Alignment.centerRight,
            child: Text(
              '$error',
              style: TextStyles.s12w400.copyWith(
                  color: AppColors.appButton
              ),
            ),
          )
        ]
      ],
    );
  }
}
