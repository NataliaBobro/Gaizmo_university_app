import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/lesson.dart';
import 'package:european_university_app/app/domain/states/teacher/teacher_home_state.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/services/visits_lesson_service.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/schedule/empty_lesson.dart';
import '../../../../widgets/schedule/lesson_header.dart';
import '../../../../widgets/schedule/shcedule_widgets.dart';

class MyLessonsTab extends StatefulWidget {
  const MyLessonsTab({Key? key}) : super(key: key);

  @override
  State<MyLessonsTab> createState() => _MyLessonsTabState();
}

class _MyLessonsTabState extends State<MyLessonsTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TeacherHomeState>();
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
              EmptyLesson(
                subtitle: getConstant('Add_a_service_to_create_a_schedule')
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24
                ),
                child: Text(
                  getConstant('Today'),
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
                        Color(int.parse('${lessons[index].color}')).withOpacity(.6),
                        contentVerticalPadding: 0,
                          rightIcon: HeaderEtm(
                              lessons: lessons[index],
                              visits: () {
                                DateTime now = DateTime.now();
                                showVisitsDialog(lessons[index], now);
                              }
                          ),
                        contentBorderWidth: 0,
                        contentHorizontalPadding: 0.0,
                        contentBackgroundColor: const Color(0xFFF0F3F6),
                        header: MyLessonHeader(
                            lesson: lessons[index]
                        ),
                        content: LessonItem(
                          lesson: lessons[index],
                          isTeacher: true,
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

  Future<void> showVisitsDialog(Lesson lesson, DateTime date) async {
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
