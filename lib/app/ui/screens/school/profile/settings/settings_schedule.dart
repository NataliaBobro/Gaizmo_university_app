import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../domain/states/school/school_profile_state.dart';


class SettingSchedule extends StatefulWidget {
  const SettingSchedule({Key? key}) : super(key: key);

  @override
  State<SettingSchedule> createState() => _SettingScheduleState();
}

class _SettingScheduleState extends State<SettingSchedule> {
  List<String> listDay = [
    'MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU',
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolProfileState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'Settings'
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose working days',
                                    style: TextStyles.s14w600.copyWith(
                                        color: const Color(0xFF242424)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        listDay.length,
                                        (index) {
                                          bool isWork = state.listWorkDay.contains(index);
                                          return Container(
                                            padding: EdgeInsets.only(left: index == 0 ? 0 : 16),
                                            child: CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                minSize: 0.0,
                                                child: Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),
                                                      color: isWork ?
                                                        const Color(0xFFFFC700) : Colors.white
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      listDay[index],
                                                      style: TextStyles.s12w600.copyWith(
                                                          color: isWork ?
                                                            Colors.white : Colors.black
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  state.changeWorkDay(index);
                                                }
                                            ),
                                          );
                                        }
                                    )
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'Choose working hours',
                                    style: TextStyles.s14w600.copyWith(
                                        color: const Color(0xFF242424)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: SizerUtil.width / 2
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'From',
                                          style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF727272)
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 11,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: state.scheduleFrom,
                                            style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF242424),
                                            ),
                                            decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 28
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 0,
                                                vertical: 0,
                                              ),
                                              hintStyle: TextStyles.s14w300.copyWith(
                                                color: const Color(0xFF242424),
                                              ),
                                              hintText: '__ : __',
                                              fillColor: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'to',
                                          style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF727272)
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 11,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: state.scheduleTo,
                                            style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF242424),
                                            ),
                                            decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 28
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 0,
                                                vertical: 0,
                                              ),
                                              hintStyle: TextStyles.s14w300.copyWith(
                                                color: const Color(0xFF242424),
                                              ),
                                              hintText: '__ : __',
                                              fillColor: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: 'Save changes',
                              onPressed: () {
                                state.saveSchoolSchedule();
                              }
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
