import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../theme/text_styles.dart';

class SelectBottomSheetInput extends StatefulWidget {
  const SelectBottomSheetInput({
    Key? key,
    required this.label,
    required this.labelModal,
    this.selected,
    this.placeholder,
    this.error,
    required this.items,
    required this.onSelect,
    this.horizontalPadding = 24
  }) : super(key: key);

  final String label;
  final double horizontalPadding;
  final String? placeholder;
  final String? error;
  final String labelModal;
  final Map<String, dynamic>? selected;
  final Function onSelect;
  final List<Map<String, dynamic>> items;

  @override
  State<SelectBottomSheetInput> createState() => _SelectBottomSheetInputState();
}

class _SelectBottomSheetInputState extends State<SelectBottomSheetInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyles.s14w600.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
          CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      getConstant(widget.selected != null ? getConstant(widget.selected?['name']) :
                      (widget.placeholder != null ? '${widget.placeholder}' : '')),
                      style: TextStyles.s14w400.copyWith(
                          color: Colors.black
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                      Svgs.openSelect,
                    width: 32,
                  )
                ],
              ),
              onPressed: () {
                openList();
              }
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: widget.error != null ? AppColors.appButton : const Color(0xFF848484),
          ),
          if(widget.error != null) ...[
            Container(
              padding: const EdgeInsets.only(top: 4),
              alignment: Alignment.centerRight,
              child: Text(
                '${widget.error}',
                style: TextStyles.s12w400.copyWith(
                    color: AppColors.appButton
                ),
              ),
            )
          ]
        ],
      ),
    );
  }

  void openList() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(.75),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        final heightItems = (widget.items.length * 48) + 68;
        final height = heightItems > 300 ? 300 : heightItems;
        return SizedBox(
          height: height.toDouble(),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                )
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14
                  ),
                  child: Text(
                    widget.labelModal,
                    style: TextStyles.s14w400.copyWith(
                        color: Colors.black
                    ),
                  ),
                ),
               Expanded(
                 child: ListView(
                   children: [
                     ...List.generate(
                         widget.items.length,
                             (index) => CupertinoButton(
                           minSize: 0.0,
                           padding: EdgeInsets.zero,
                           onPressed: () {
                             widget.onSelect(widget.items[index]);
                             Navigator.of(context).pop();
                           },
                           child: Container(
                             constraints: BoxConstraints(
                               maxWidth: SizerUtil.width - 50
                             ),
                             alignment: Alignment.center,
                             width: double.infinity,
                             padding: const EdgeInsets.symmetric(
                                 vertical: 14
                             ),
                             child: Text(
                               getConstant(widget.items[index]['name']),
                               style: TextStyles.s14w400.copyWith(
                                   color: Colors.black
                               ),
                             ),
                           ),
                         )
                     )
                   ],
                 ),
               )
              ],
            ),
          ),
        );
      },
    );
  }
}
