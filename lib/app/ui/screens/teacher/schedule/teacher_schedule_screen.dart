import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:european_university_app/app/domain/models/lesson.dart';
import 'package:european_university_app/app/ui/screens/teacher/schedule/widgets/schedule_header.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/services/visits_lesson_service.dart';
import '../../../../domain/states/teacher/teacher_schedule_state.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/schedule/lesson_header.dart';
import '../../../widgets/schedule/shcedule_widgets.dart';

class TeacherScheduleScreen extends StatefulWidget {
  const TeacherScheduleScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScheduleScreen> createState() => _TeacherScheduleScreenState();
}

class _TeacherScheduleScreenState extends State<TeacherScheduleScreen> {
  int? viewOnDelete;


  void changeViewDelete(int? id){
    setState(() {
      viewOnDelete = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TeacherScheduleState>();
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
                  Expanded(
                    child: EmptyWidget(
                      isEmpty: true,
                      title: getConstant('No_classes_today'),
                      subtitle: getConstant('Click_the_button_below_to_add_lessons'),
                      onPress: () {
                        state.addLesson();
                      },
                    ),
                  ),
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
                                  changeViewDelete(state.lessonsList?.lessons?[index].id);
                                },
                                onEdit: (index) {
                                  state.openEditLesson(state.lessonsList?.lessons?[index]);
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
                                    state.lessonsList?.lessons?.length ?? 0,
                                    (index) => AccordionSection(
                                      isOpen: false,
                                      headerBackgroundColor:
                                      Color(int.parse('${state.lessonsList?.lessons?[index].color}')).withOpacity(.6),
                                      contentVerticalPadding: 0,
                                      rightIcon: HeaderEtm(
                                          lessons: state.lessonsList!.lessons![index],
                                          visits: () {
                                            DateTime now = DateTime.now();
                                            showVisitsDialog(state.lessonsList!.lessons![index], now);
                                          }
                                      ),
                                      contentBorderWidth: 0,
                                      contentHorizontalPadding: 0.0,
                                      contentBackgroundColor: const Color(0xFFF0F3F6),
                                      header: MyLessonHeader(
                                          lesson: state.lessonsList!.lessons![index]
                                      ),
                                      content: LessonItem(
                                          lesson: state.lessonsList!.lessons![index],
                                          isTeacher: true,
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                        if(viewOnDelete != null) ...[
                          Positioned(
                            child: GestureDetector(
                              onTap: () {
                                changeViewDelete(null);
                              },
                              child: Container(
                                width: SizerUtil.width,
                                color: Colors.black.withOpacity(.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 55,
                                          vertical: 24
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 53
                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Are you sure you want\n to delete the lesson?',
                                            style: TextStyles.s14w600,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  minSize: 0.0,
                                                  onPressed: () {
                                                    state.deleteLesson(viewOnDelete);
                                                    changeViewDelete(null);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 4
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: const Color(0xFF242424)
                                                        )
                                                    ),
                                                    child: Text(
                                                      'YES',
                                                      style: TextStyles.s12w600.copyWith(
                                                          color: const Color(0xFF242424)
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  minSize: 0.0,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 4
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: const Color(0xFFFFC700),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: const Color(0xFFFFC700),
                                                        )
                                                    ),
                                                    child: Text(
                                                      'NO',
                                                      style: TextStyles.s12w600.copyWith(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    changeViewDelete(null);
                                                  }
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]
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
