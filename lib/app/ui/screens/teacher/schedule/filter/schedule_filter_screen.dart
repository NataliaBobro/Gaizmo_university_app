import 'package:european_university_app/app/ui/screens/teacher/schedule/filter/filter_class.dart';
import 'package:european_university_app/app/ui/screens/teacher/schedule/filter/type_lesson.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/states/teacher/teacher_schedule_state.dart';
import '../../../../utils/get_constant.dart';
import '../../../../widgets/center_header.dart';

class ScheduleFilterScreen extends StatefulWidget {
  const ScheduleFilterScreen({
    Key? key
  }) : super(key: key);

  @override
  State<ScheduleFilterScreen> createState() => _ScheduleFilterScreenState();
}

class _ScheduleFilterScreenState extends State<ScheduleFilterScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TeacherScheduleState>();
    final read = context.read<TeacherScheduleState>();
    final selectedType = state.filterSchedule.type;
    final selectedTeacher = state.filterSchedule.teacher;
    final selectClass = state.filterSchedule.selectClass;
    String type = '';
    if(selectedType.isNotEmpty){
      for(var a = 0; a < selectedType.length; a++){
        final name = state.listTypeServices.firstWhere((element) => element['id'] == selectedType[a]);
        type = '$type ${name['name']}';
      }
    }

    String teachers = '';
    if(selectedTeacher.isNotEmpty){
      for(var a = 0; a < selectedTeacher.length; a++){
        final name = state.listTeacher.firstWhere((element) => element['id'] == selectedTeacher[a]);
        teachers = '$teachers ${name['name']}';
      }
    }
    String selectedClass = '';
    if(selectClass.isNotEmpty){
      for(var a = 0; a < selectClass.length; a++){
        final name = state.listClass.firstWhere((element) => element['id'] == selectClass[a]);
        selectedClass = '$selectedClass ${name['name']}';
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('Filter')
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        CupertinoButton(
                          minSize: 0.0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getConstant('Type_of_lesson'),
                                style: TextStyles.s14w400.copyWith(
                                  color: const Color(0xFF242424)
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 179
                                ),
                                child: Text(
                                  type.isNotEmpty ? type : getConstant('All'),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF848484)
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ChangeNotifierProvider.value(
                                      value: read,
                                      child: const TypeLesson(),
                                    )
                                )
                            );
                          }
                        ),
                        CupertinoButton(
                            minSize: 0.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 18
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getConstant('Class'),
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF242424)
                                  ),
                                ),
                                Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 179
                                  ),
                                  child: Text(
                                    selectedClass.isNotEmpty ? selectedClass : getConstant('All'),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.s14w400.copyWith(
                                        color: const Color(0xFF848484)
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => ChangeNotifierProvider.value(
                                        value: read,
                                        child: const FilterClass(),
                                      )
                                  )
                              );
                            }
                        )
                      ],
                    )
                ),
                AppButton(
                    title: getConstant('APPLY_FILTER'),
                    onPressed: () {
                      state.getLesson();
                      Navigator.pop(context);
                    }
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          )
      ),
    );
  }
}
