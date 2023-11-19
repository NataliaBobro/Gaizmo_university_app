import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class AppField extends StatelessWidget {
  const AppField({
    Key? key,
    required this.label,
    this.placeholder,
    required this.controller,
    this.error
  }) : super(key: key);

  final String label;
  final String? placeholder;
  final TextEditingController controller;
  final String? error;

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
          controller: controller,
          decoration: InputDecoration(
            constraints: const BoxConstraints(
                maxHeight: 28
            ),
            hintText: placeholder,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
            hintStyle: TextStyles.s16w400.copyWith(
              color: Colors.black,
            ),
            fillColor: Colors.transparent,
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: error != null ? const Color(0xFFFFC700) : const Color(0xFF848484),
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
    );
  }
}
