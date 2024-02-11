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
          title ?? "There is no schedule for today :(",
          style: TextStyles.s14w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          subtitle ?? "Explore the schools to find\nthe lessons for you!",
          style: TextStyles.s12w400.copyWith(
              color: const Color(0xFF242424)
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
