import 'package:european_university_app/app/domain/models/timesheet.dart';
import 'package:european_university_app/app/domain/states/timesheet.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/text_styles.dart';


class TimesheetTab extends StatefulWidget {
  const TimesheetTab({
    Key? key
  }) : super(key: key);


  @override
  State<TimesheetTab> createState() => _TimesheetTabState();
}

class _TimesheetTabState extends State<TimesheetTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TimesheetState>();

    return  ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24
      ),
      children: [
        if(state.isLoading) ...[
          const SizedBox(
            height: 233,
          ),
          const CupertinoActivityIndicator()
        ] else ...[
          if((state.timesheetModel?.timesheet.length ?? 0) > 0) ...[
            ...List.generate(
                state.timesheetModel?.timesheet.length ?? 0,
                    (index) => TimesheetLessonItem(
                    item: state.timesheetModel?.timesheet[index]
                )
            ),
            TimesheetLessonItem(
                item: TimesheetItem(
                  rating: getAverageScore(state.timesheetModel?.timesheet),
                  serviceName: getConstant('Average score')
                )
            )
          ]else ...[
            const SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Text(
                  getConstant('Timesheet'),
                  style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  getConstant('Functionality in development'),
                  style: TextStyles.s12w400.copyWith(
                      color: const Color(0xFF242424)
                  ),
                ),
              ],
            )
          ]
        ],
      ],
    );
  }

  double getAverageScore(List<TimesheetItem>? items) {
    if(items == null) return 0;
    double total = 0;
    for(int a = 0; a < items.length; a++){
      if(items[a].rating != null){
        total = total + items[a].rating!;
      }
    }
    return total / items.length;
  }
}

class TimesheetLessonItem extends StatelessWidget {
  const TimesheetLessonItem({
    super.key,
    required this.item
  });

  final TimesheetItem? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
                '${item?.serviceName}'
            ),
          ),
          Text(
              '${item?.rating}'
          )
        ],
      ),
    );
  }
}

