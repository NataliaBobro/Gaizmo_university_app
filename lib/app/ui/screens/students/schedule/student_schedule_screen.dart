import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:european_university_app/app/domain/models/lesson.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../app.dart';
import '../../../../domain/services/visits_lesson_service.dart';
import '../../../../domain/states/student/student_schedule_state.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/schedule/empty_lesson.dart';
import '../../../widgets/schedule/lesson_header.dart';
import '../../../widgets/schedule/shcedule_widgets.dart';
import '../../students/schedule/widgets/schedule_header.dart';

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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 113
                    ),
                    child: EmptyLesson(
                      title: getConstant('No_classes_today')
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
                                      Color(int.parse('${lessons[index].color}')).withOpacity(.6),
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
    DateTime dateNow  = DateTime.now();

    if(dateNow.isBefore(date)){
      await showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
          content: Text(
            getConstant('wait_day_come_yet'),
            style: TextStyles.s17w600,
          ),
          actions: <Widget>[
            BasicDialogAction(
              title: Text(getConstant('Close')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }else{
      await showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
          content: Text(
            getConstant('Are_you_sure_you_attended_this_lesson'),
            style: TextStyles.s17w600,
          ),
          actions: <Widget>[
            BasicDialogAction(
              title: Text(getConstant('Yes')),
              onPressed: () {
                Navigator.pop(context);
                visits(lesson, date);
              },
            ),
            BasicDialogAction(
              title: Text(getConstant('No')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> visits(Lesson lesson, DateTime date) async {
    try{
      final result = await VisitsLessonService.visits(context, lesson.id, date);
      if(result == true){
        lesson.isVisitsExists = true;
        updateUser();
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {});
    }
  }

  void updateUser() {
    context.read<AppState>().getUser();
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

    DateTime parseEnd = parsedTime.add(Duration(minutes: lesson?.services?.first?.duration ?? 0));
    String end = outputFormat.format(parseEnd);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${lesson?.services?.first?.name}',
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
