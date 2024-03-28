import 'package:etm_crm/app/ui/utils/get_constant.dart';
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
    final duration = lesson.duration;
    TimeOfDay startTime = TimeOfDay.fromDateTime(DateTime.parse("2022-01-18 ${lesson.startLesson}"));
    TimeOfDay endTime = startTime.replacing(
      hour: startTime.hour + ((startTime.minute + duration) ~/ 60),
      minute: (startTime.minute + duration) % 60,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${lesson.name}',
          style: TextStyles.s14w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '${getConstant('Start')} ${startTime.format(context)} - ${getConstant('End')} ${endTime.format(context)}',
          style: TextStyles.s13w400.copyWith(
              color: const Color(0xFF848484)
          ),
        ),
      ],
    );
  }
}
