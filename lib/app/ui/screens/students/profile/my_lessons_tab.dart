import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:etm_crm/app/domain/models/lesson.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/states/student/student_home_state.dart';
import '../../../widgets/custom_scroll_physics.dart';
import '../../school/schedule/school_schedule_screen.dart';

class MyLessonsTab extends StatefulWidget {
  const MyLessonsTab({Key? key}) : super(key: key);

  @override
  State<MyLessonsTab> createState() => _MyLessonsTabState();
}

class _MyLessonsTabState extends State<MyLessonsTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentHomeState>();
    final lessons = state.lessonsListToday?.lessons ?? [];
    return ListView(
      physics: const BottomBouncingScrollPhysics(),
      children: [
        state.isLoading ?
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: CupertinoActivityIndicator(),
          )
          : Column(
          children: [
            if(lessons.isEmpty) ...[
              const EmptyLesson(),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24
                ),
                child: Text(
                  "Today",
                  style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                ),
              ),
              Accordion(
                  isFullActionButton: true,
                  paddingListTop: 0.0,
                  disableScrolling: true,
                  headerBorderWidth: 0,
                  contentBorderWidth: 0,
                  headerBorderRadius: 15,
                  scaleWhenAnimating: false,
                  openAndCloseAnimation: true,
                  paddingListHorizontal: 16,
                  paddingListBottom: 0.0,
                  flipRightIconIfOpen: false,
                  headerPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16
                  ),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: List.generate(
                      lessons.length,
                        (index) => AccordionSection(
                        isOpen: false,
                        headerBackgroundColor:
                        Color(int.parse('${lessons[index].service?.color}')).withOpacity(.6),
                        contentVerticalPadding: 0,
                        rightIcon: HeaderEtm(
                            etm: lessons[index].service?.etm
                        ),
                        contentBorderWidth: 0,
                        contentHorizontalPadding: 0.0,
                        contentBackgroundColor: const Color(0xFFF0F3F6),
                        header: MyLessonHeader(
                            lesson: lessons[index]
                        ),
                        content: LessonItem(
                            lesson: lessons[index]
                        ),
                      )
                  )
              )
            ]
          ],
        )
      ],
    );
  }
}


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


class EmptyLesson extends StatelessWidget {
  const EmptyLesson({
    Key? key,
    this.title
  }) : super(key: key);

  final String? title;

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
          "Explore the schools to find\nthe lessons for you!",
          style: TextStyles.s12w400.copyWith(
            color: const Color(0xFF242424)
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
