import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/resources.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';


class DropdownInput extends StatelessWidget {
  const DropdownInput({
    super.key,
    required this.title,
    this.hintStyle,
    this.dropdownColor,
    this.select,
    required this.items,
  });

  final String title;
  final TextStyle? hintStyle;
  final Color? dropdownColor;
  final List<dynamic> items;
  final dynamic select;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          // style: widget.hintStyle,
          icon: SvgPicture.asset(
            Svgs.openSelect,
            width: 20,
          ),
          hint: Text(
            title,
            style: hintStyle ?? TextStyles.s14w400.copyWith(
                color: AppColors.appTitle
            ),
          ),
          dropdownColor: dropdownColor,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            constraints: BoxConstraints(
                maxHeight: 25
            ),
            fillColor: Colors.transparent,

          ),
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          items: items
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(
                '$e',
                style: hintStyle ?? TextStyles.s14w400.copyWith(
                    color: AppColors.appTitle
                ),
              ),
            ),
          ).toList(),
          value: select,
          onChanged: (value) {

          },
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.black.withOpacity(.4),
        )
      ],
    );
  }
}
