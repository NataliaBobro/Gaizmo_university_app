import 'package:etm_crm/app/domain/states/school/school_schedule_state.dart';
import 'package:etm_crm/app/ui/screens/school/schedule/filter/type_lesson.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/center_header.dart';

class ScheduleFilterScreen extends StatefulWidget {
  const ScheduleFilterScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleFilterScreen> createState() => _ScheduleFilterScreenState();
}

class _ScheduleFilterScreenState extends State<ScheduleFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'Filter'
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
                                'Type of lesson',
                                style: TextStyles.s14w400.copyWith(
                                  color: const Color(0xFF242424)
                                ),
                              ),
                              Text(
                                'All',
                                style: TextStyles.s14w400.copyWith(
                                  color: const Color(0xFF242424)
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            final read = context.read<SchoolScheduleState>();
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
                                  'Teacher',
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF242424)
                                  ),
                                ),
                                Text(
                                  'All',
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF242424)
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {}
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
                                  'Class',
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF242424)
                                  ),
                                ),
                                Text(
                                  'All',
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF242424)
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {}
                        )
                      ],
                    )
                ),
                AppButton(
                    title: 'Apply filter',
                    onPressed: () {

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
