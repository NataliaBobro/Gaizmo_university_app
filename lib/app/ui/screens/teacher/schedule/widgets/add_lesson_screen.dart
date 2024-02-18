import 'package:etm_crm/app/domain/models/lesson.dart';
import 'package:etm_crm/app/domain/states/teacher/teacher_schedule_state.dart';
import 'package:etm_crm/app/ui/screens/teacher/schedule/widgets/select_day_week.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../theme/text_styles.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/select_bottom_sheet_input.dart';
import '../../../../widgets/select_input_search.dart';

class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({
    Key? key,
    this.edit
  }) : super(key: key);

  final Lesson? edit;

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  DateTime date = DateTime(2016, 10, 26);
  DateTime time = DateTime(2016, 5, 10, 08, 00);

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
              const CenterHeaderWithAction(
                  title: 'Add lesson'
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24
                  ),
                  physics: const BottomBouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    SelectBottomSheetInput(
                        label: "Service name",
                        labelModal: "Service",
                        selected: state.selectService,
                        items: state.listTypeServices,
                        horizontalPadding: 0.0,
                        onSelect: (value) {
                          state.selectAddService(value);
                        },
                        error: state.validateError?.errors.service?.first,
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      'Lesson information',
                      style: TextStyles.s14w600.copyWith(
                          color: const Color(0xFFFFC700)
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SelectInputSearch(
                      errors: state.validateError?.errors.schoolClass?.first,
                      title: 'Class',
                      labelStyle: TextStyles.s14w600.copyWith(
                          color: const Color(0xFF242424)
                      ),
                      style: TextStyles.s14w400.copyWith(
                          color: Colors.black
                      ),
                      isSearch: true,
                      onSearch: (value) {
                        print(value);
                      },
                      items: state.listClass,
                      selected: state.selectClass,
                      onSelect: (value) {
                        state.changeClass(value);
                      },
                      hintText: '',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Lesson duration',
                      style: TextStyles.s14w600.copyWith(
                          color: const Color(0xFFFFC700)
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
                                label: 'Start',
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
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Repeats',
                      style: TextStyles.s14w600.copyWith(
                          color: const Color(0xFFFFC700)
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
                          label: 'Start',
                          controller: state.repeatsStart,
                          error: state.validateError?.errors.start?.first,
                        ),
                      ),
                      onPressed: () {
                        _showDialog(
                          CupertinoDatePicker(
                            initialDateTime: date,
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
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
                            label: 'End',
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
                    const SelectDayWeek(),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      title: state.editId != null ? 'Edit Lesson' : 'ADD Lesson',
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
