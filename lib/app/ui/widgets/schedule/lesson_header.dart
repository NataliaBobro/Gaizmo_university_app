import 'package:flutter/material.dart';

import '../../../domain/models/lesson.dart';
import '../../theme/text_styles.dart';

class MyLessonHeader extends StatelessWidget {
  const MyLessonHeader({
    Key? key,
    required this.lesson
  }) : super(key: key);

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final duration = lesson.service?.duration;
    TimeOfDay startTime = TimeOfDay.fromDateTime(DateTime.parse("2022-01-18 ${lesson.startLesson}"));
    TimeOfDay endTime = startTime.replacing(
      hour: startTime.hour + (duration ?? 0) ~/ 60,
      minute: startTime.minute + (duration ?? 0) % 60,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${lesson.service?.name}',
          style: TextStyles.s14w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Start ${startTime.format(context)} - End ${endTime.format(context)}',
          style: TextStyles.s12w400.copyWith(
              color: const Color(0xFF848484)
          ),
        ),
      ],
    );
  }
}
