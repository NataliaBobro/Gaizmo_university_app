import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/teacher/teacher_schedule_state.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/text_styles.dart';

class SelectDayWeek extends StatefulWidget {
  const SelectDayWeek({Key? key}) : super(key: key);

  @override
  State<SelectDayWeek> createState() => _SelectDayWeekState();
}

class _SelectDayWeekState extends State<SelectDayWeek> {
  List<Map<String, String>> dateList = [
    {'define': 'MO', 'name': 'Monday',},
    {'define': 'TU', 'name': 'Tuesday',},
    {'define': 'WE', 'name': 'Wednesday',},
    {'define': 'TH', 'name': 'Thursday',},
    {'define': 'FR', 'name': 'Friday',},
    {'define': 'SA', 'name': 'Saturday',},
    {'define': 'SU', 'name': 'Sunday',},
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TeacherScheduleState>();
    final dayListSelected = state.dayListSelected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              dateList.length,
              (index) {
                bool isSelected = false;
                for(var a = 0; a < dayListSelected.length; a++){
                  if(dateList[index]['define'] == dayListSelected[a]['define']){
                    isSelected = true;
                    break;
                  }
                }
                return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isSelected ?
                          AppColors.appButton : Colors.white
                      ),
                      child: Center(
                        child: Text(
                          getConstant('${dateList[index]['define']}'),
                          style: TextStyles.s12w600.copyWith(
                              color: isSelected ? Colors.white : Colors.black
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      state.changeSelectDay(dateList[index]);
                    }
                );
              }
          ),
        ),

        const SizedBox(
          height: 24,
        ),
        if(dayListSelected.isNotEmpty) ...[
          RichText(
            text: TextSpan(
                text: 'It takes place every week on ',
                style: TextStyles.s12w300.copyWith(
                    color: const Color(0xFF242424)
                ),
                children: [
                  ...List.generate(
                    dayListSelected.length,
                        (index) => TextSpan(
                      text: '${dayListSelected[index]['name']} ',
                      style: TextStyles.s12w300.copyWith(
                          color: const Color(0xFF242424)
                      ),
                    ),
                  ),
                  if(state.repeatsEnd.text.isNotEmpty) ...[
                    TextSpan(
                      text: 'until ',
                      style: TextStyles.s12w300.copyWith(
                          color: const Color(0xFF242424)
                      ),
                    ),
                    TextSpan(
                      text: '${state.repeatsEnd.text}.\n',
                      style: TextStyles.s12w300.copyWith(
                          color: const Color(0xFF2F80ED)
                      ),
                    ),
                    TextSpan(
                      text: 'Delete end date.',
                      style: TextStyles.s12w300.copyWith(
                          color: const Color(0xFF2F80ED)
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          state.clearEndDate();
                        },
                    ),
                  ]
                ]
            ),
          ),
        ],
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
