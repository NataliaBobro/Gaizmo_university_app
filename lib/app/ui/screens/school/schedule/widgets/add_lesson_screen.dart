import 'package:etm_crm/app/domain/states/school/school_schedule_state.dart';
import 'package:etm_crm/app/ui/screens/school/schedule/widgets/select_day_week.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../theme/text_styles.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/select_bottom_sheet_input.dart';
import '../../../../widgets/select_input_search.dart';

class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({Key? key}) : super(key: key);

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<SchoolScheduleState>().fetchMeta();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolScheduleState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const CenterHeader(
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
                        Container(
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
                    AppField(
                      label: 'Start',
                      controller: state.repeatsStart,
                      error: state.validateError?.errors.start?.first,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      label: 'End',
                      controller: state.repeatsEnd,
                      error: state.validateError?.errors.end?.first,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const SelectDayWeek(),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      title: 'ADD Lesson',
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
}
