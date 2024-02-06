import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:etm_crm/app/domain/models/lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/resources.dart';
import '../../../../domain/services/visits_lesson_service.dart';
import '../../../../domain/states/student/student_schedule_state.dart';
import '../../../theme/text_styles.dart';
import '../../students/schedule/widgets/schedule_header.dart';
import '../profile/info/my_lessons_tab.dart';

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({Key? key}) : super(key: key);

  @override
  State<StudentScheduleScreen> createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentScheduleState>();
    final lessons = state.lessonsList?.lessons ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const ScheduleHeader(),
              if(state.isLoading) ...[
                const Expanded(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              ] else ...[
                if((state.lessonsList?.lessons?.length ?? 0) == 0) ... [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 113
                    ),
                    child: EmptyLesson(
                      title: "No classes today :("
                    ),
                  )
                ] else ...[
                  Expanded(
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Accordion(
                                onDelete: (index) {

                                },
                                onEdit: (index) {

                                },
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
                                          lessons: lessons[index],
                                          visits: () {
                                            DateTime now = DateTime.now();
                                            DateTime date = now.add(Duration(days: state.filterDateIndex - 5));
                                            showVisitsDialog(lessons[index], date);
                                          }
                                      ),
                                      contentBorderWidth: 0,
                                      contentHorizontalPadding: 0.0,
                                      contentBackgroundColor: const Color(0xFFF0F3F6),
                                      header: MyLessonHeader(
                                          lesson: lessons[index]
                                      ),
                                      onDelete: (index) {

                                      },
                                      onEdit: (service) {

                                      },
                                      content: LessonItem(
                                          lesson: lessons[index]
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showVisitsDialog(Lesson lesson, DateTime date) async {
    await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        content: const Text(
          "Are you sure you attended this lesson?",
          style: TextStyles.s17w600,
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("Yes"),
            onPressed: () {
              Navigator.pop(context);
              visits(lesson, date);
            },
          ),
          BasicDialogAction(
            title: const Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> visits(Lesson lesson, DateTime date) async {
    try{
      final result = await VisitsLessonService.visits(context, lesson.id, date);
      if(result == true){
        lesson.isVisitsExists = true;
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {});
    }
  }
}

class HeaderNameLesson extends StatelessWidget {
  const HeaderNameLesson({
    Key? key,
    required this.lesson
  }) : super(key: key);

  final Lesson? lesson;

  @override
  Widget build(BuildContext context) {
    String timeString = "${lesson?.lessonStart}";
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat('HH:mm');

    DateTime parsedTime = inputFormat.parse(timeString);
    String start = outputFormat.format(parsedTime);

    DateTime parseEnd = parsedTime.add(Duration(minutes: lesson?.service?.duration ?? 0));
    String end = outputFormat.format(parseEnd);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${lesson?.service?.name}',
          style: TextStyles.s14w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Start $start - End $end',
          style: TextStyles.s12w400.copyWith(
              color: const Color(0xFF848484)
          ),
        )
      ],
    );
  }
}


class HeaderEtm extends StatelessWidget {
  const HeaderEtm({
    Key? key,
    required this.visits,
    required this.lessons,
  }) : super(key: key);

  final Lesson lessons;
  final Function visits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Svgs.etmPlus,
              width: 24,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '+${lessons.service?.etm} ETM',
              style: TextStyles.s10w600.copyWith(
                  color: const Color(0xFF242424)
              ),
            )
          ],
        ),
        CupertinoButton(
          minSize: 0.0,
            padding: const EdgeInsets.only(left: 30, top: 3),
            onPressed: lessons.isVisitsExists == true ? null : () {
              visits();
            },
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: lessons.isVisitsExists == true ?
                const Color(0xFF27AE60) : const Color(0xFFFFC700)
              ),
              child: SvgPicture.asset(
                Svgs.boxCheck
              ),
            )
        )
      ],
    );
  }
}


class LessonItem extends StatefulWidget {
  const LessonItem({
    Key? key,
    required this.lesson
  }) : super(key: key);

  final Lesson? lesson;

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(
          top: 14,
          bottom: 10
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(int.parse('${widget.lesson?.service?.color}')).withOpacity(.4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentRowInfo(
            title: 'Teacher',
            value: '${widget.lesson?.service?.teacher?.firstName} '
                '${widget.lesson?.service?.teacher?.lastName}',
          ),
          const ContentRowInfo(
            title: 'Students',
            value: '0',
          ),
          ContentRowInfo(
            title: 'Adress',
            value: '${widget.lesson?.service?.school?.street} '
                '${widget.lesson?.service?.school?.house}',
          ),
          ContentRowInfo(
              title: 'Class number',
              value: '${widget.lesson?.schoolClass?.name}'
          ),
          const ContentRowInfo(
              title: 'Lesson links',
              value: ''
          ),
          ContentRowInfo(
            title: 'Description',
            content: CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              onPressed: () {

              },
              child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                    Svgs.open
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentRowInfo extends StatelessWidget {
  const ContentRowInfo({
    Key? key,
    required this.title,
    this.value,
    this.content,
  }) : super(key: key);

  final String? title;
  final String? value;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 11
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: TextStyles.s12w400.copyWith(
                color: const Color(0xFF848484)
            ),
          ),
          content ??
              Text(
                '$value',
                style: TextStyles.s12w400.copyWith(
                    color: const Color(0xFF242424)
                ),
              ),
        ],
      ),
    );
  }
}

