import 'package:european_university_app/app/domain/models/lesson.dart';
import 'package:european_university_app/app/domain/states/teacher/teacher_schedule_state.dart';
import 'package:european_university_app/app/ui/screens/teacher/schedule/widgets/select_day_week.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../../../../theme/text_styles.dart';
import '../../../../utils/get_constant.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/select_color.dart';

class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({
    Key? key,
    this.edit,
  }) : super(key: key);

  final Lesson? edit;

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();

  @override
  void initState() {
    Future.microtask(() {
      context.read<TeacherScheduleState>().fetchMeta().then((value) {
        if(widget.edit != null){
          context.read<TeacherScheduleState>().initEditData(widget.edit);
        }
      });
    });
    super.initState();
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
              CenterHeaderWithAction(
                  title: getConstant('Add_lesson')
              ),
              Expanded(
                child: state.isLoading ?
                  const Center(
                    child: CupertinoActivityIndicator(),
                  ) :
                ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24
                  ),
                  physics: const BottomBouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                        label: '   ${getConstant('Lesson_name')}',
                        controller: state.lessonName
                    ),
                    const SizedBox(
                      height: 16,
                    ),


                    MultiSelectDialogField(
                      backgroundColor: Colors.white,
                      cancelText: Text(
                          getConstant('Close')
                      ),
                      confirmText: Text(
                          getConstant('Select')
                      ),
                      initialValue: state.selectService ?? [],
                      buttonText: Text(
                        getConstant('Service'),
                        style: TextStyles.s14w600.copyWith(
                            color: const Color(0xFF242424)
                        ),
                      ),
                      title: Text(
                        getConstant('Service'),
                        style: TextStyles.s14w600.copyWith(
                            color: const Color(0xFF242424)
                        ),
                      ),
                      items: state.listTypeServices.map((e) => MultiSelectItem(e, e['name'])).toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        state.selectAddService(values);
                      },
                    ),
                    if(state.validateError?.errors.service?.first != null) ...[
                      Container(
                        padding: const EdgeInsets.only(
                            top: 4
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${state.validateError?.errors.service?.first}',
                          style: TextStyles.s12w400.copyWith(
                              color: AppColors.appButton
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(
                      height: 34,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      getConstant('Lesson_duration'),
                      style: TextStyles.s14w600.copyWith(
                          color: AppColors.appButton
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        CupertinoButton(
                            minSize: 0.0,
                            padding: EdgeInsets.zero,
                            child: IgnorePointer(
                              child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 150
                                ),
                                child: AppField(
                                  label: getConstant('Start'),
                                  controller: state.lessonStart,
                                  placeholder: '_ _ : _ _',
                                  error: state.validateError?.errors.startLesson?.first,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: time,
                                  mode: CupertinoDatePickerMode.time,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime newTime) {
                                    setState(() {
                                      time = newTime;
                                      state.changeLessonStart(DateFormat('HH:mm').format(newTime));
                                    });
                                  },
                                ),
                              );
                            }
                        ),
                        const Spacer(),
                        CupertinoButton(
                            minSize: 0.0,
                            padding: EdgeInsets.zero,
                            child: IgnorePointer(
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 150
                                  ),
                                  child: AppField(
                                    label: getConstant('duration'),
                                    controller: state.duration,
                                    placeholder: '_ _ : _ _',
                                  ),
                                )
                            ),
                            onPressed: () {
                              _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: state.duration.text.isNotEmpty ? DateFormat('dd.MM.yyyy HH:mm').parse('01.01.2024 ${(state.duration.text).replaceAll(' ', '')}:00') :
                                  DateFormat('dd.MM.yyyy HH:mm').parse('01.01.2024 00:00:00'),
                                  mode: CupertinoDatePickerMode.time,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime newTime) {
                                    setState(() {
                                      state.duration.text = DateFormat('HH:mm').format(newTime);
                                    });
                                  },
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      getConstant('Repeats'),
                      style: TextStyles.s14w600.copyWith(
                          color: AppColors.appButton
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CupertinoButton(
                        minSize: 0.0,
                        padding: EdgeInsets.zero,
                        child: IgnorePointer(
                          child: AppField(
                            label: getConstant('Start'),
                            controller: state.repeatsStart,
                            error: state.validateError?.errors.start?.first,
                          ),
                        ),
                        onPressed: () {
                          _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: state.repeatsEnd.text.isNotEmpty ? null : date,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              minimumDate: DateTime.now().add(const Duration(hours: -1)),
                              maximumDate: state.repeatsEnd.text.isNotEmpty ?
                              DateFormat('dd.MM.yyyy HH:mm').parse('${state.repeatsEnd.text} 23:00')
                                  : null,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() {
                                  date = newDate;
                                  state.changeRepeatsStart(DateFormat('dd.MM.yyyy').format(newDate));
                                });
                              },
                            ),
                          );
                        }
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CupertinoButton(
                        minSize: 0.0,
                        padding: EdgeInsets.zero,
                        child: IgnorePointer(
                          child: AppField(
                            label: getConstant('End_Lov'),
                            controller: state.repeatsEnd,
                            error: state.validateError?.errors.end?.first,
                          ),
                        ),
                        onPressed: () {
                          _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: date,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              minimumDate: state.repeatsStart.text.isNotEmpty ?
                              DateFormat('dd.MM.yyyy HH:mm').parse('${state.repeatsStart.text} 00:00')
                                  : null,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() {
                                  date = newDate;
                                  state.changeRepeatsEnd(DateFormat('dd.MM.yyyy').format(newDate));
                                });
                              },
                            ),
                          );
                        }
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SelectColor(
                        selected: state.selectColor,
                        label: getConstant('Color'),
                        onSelect: (value) {
                          state.selectServiceColor(value);
                        }
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const SelectDayWeek(),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      title: state.editId != null ? getConstant('EDIT_Lesson') : getConstant('Add_lesson'),
                      onPressed: () {
                        state.addOrEditLesson();
                      },
                      horizontalPadding: 17.0,
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
