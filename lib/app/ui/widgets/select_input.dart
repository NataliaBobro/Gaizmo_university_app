import 'package:etm_crm/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/text_styles.dart';
import '../utils/bottom_select.dart';

class SelectInput extends StatelessWidget {
  const SelectInput({
    Key? key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.onSelect,
    this.labelStyle,
    this.hintStyle,
    this.placeholder,
    this.selected = -1,
    this.errors
  }) : super(key: key);

  final String title;
  final String hintText;
  final List<String> items;
  final Function onSelect;
  final int selected;
  final String? errors;
  final String? placeholder;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: labelStyle ?? TextStyles.s14w400.copyWith(
              color: const Color(0xFF848484)
          ),
        ),
        CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selected != -1 ? items[selected - 1] : hintText,
                    style: hintStyle ?? TextStyles.s14w400.copyWith(
                        color: Colors.white
                    ),
                  ),
                ),
                SvgPicture.asset(
                    Svgs.openSelect
                )
              ],
            ),
            onPressed: () {
              openShowBottomSelect(
                context,
                title,
                items,
                onPress: (index) {
                  onSelect(index + 1);
                }
              );
            }
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: errors == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
        ),
        if(errors != null) ...[
          Container(
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
          ),
        ],
        const SizedBox(
          height: 24,
        )
      ],
    );
  }
}
