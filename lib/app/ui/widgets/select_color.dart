import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SelectColor extends StatefulWidget {
  const SelectColor({
    Key? key,
    required this.label,
    required this.onSelect,
    this.selected
  }) : super(key: key);

  final String label;
  final Function onSelect;
  final String? selected;

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  List<String> listColor = [
    '0xFFEB5757',
    '0xFFF2994A',
    '0xFFF2C94C',
    '0xFF219653',
    '0xFF27AE60',
    '0xFF2F80ED',
    '0xFF2D9CDB',
    '0xFF56CCF2',
    '0xFF9B51E0',
    '0xFFBB6BD9',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyles.s14w600.copyWith(
            color: AppColors.appButton
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            listColor.length,
            (index) => CupertinoButton(
              minSize: 0.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ).copyWith(
                  bottom: 3
                ),
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(int.parse(listColor[index])),
                    border: widget.selected == listColor[index] ?
                        Border.all(
                          width: 2,
                          color: Colors.black
                        )
                        : null
                  ),
                ),
                onPressed: () {
                  widget.onSelect(listColor[index]);
                }
            )
          ),
        )
      ],
    );
  }
}
