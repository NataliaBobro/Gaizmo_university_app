import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';

import '../../theme/text_styles.dart';

class EmptyLesson extends StatelessWidget {
  const EmptyLesson({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 115,
        ),
        Text(
          title ?? getConstant('There_is_no_schedule_for_today'),
          style: TextStyles.s14w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          subtitle ?? getConstant('Explore_the_schools_to_find_the_lessons_for_you'),
          style: TextStyles.s12w400.copyWith(
              color: const Color(0xFF242424)
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
