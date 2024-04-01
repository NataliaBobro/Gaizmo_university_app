import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../resources/resources.dart';
import '../theme/app_colors.dart';

class EmptyWidget extends StatefulWidget {
  const EmptyWidget({
    Key? key,
    this.title,
    this.subtitle,
    required this.onPress,
    this.isEmpty = false,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final Function onPress;
  final bool isEmpty;

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(widget.isEmpty) ...[
          Text(
            '${widget.title}',
            style: TextStyles.s14w600.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${widget.subtitle}',
            style: TextStyles.s12w400.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
        ],
        CupertinoButton(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: AppColors.appButton,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: SvgPicture.asset(
                Svgs.plus,
                width: 32,
              ),
            ),
            onPressed: () {
              widget.onPress();
            }
        )
      ],
    );
  }
}
