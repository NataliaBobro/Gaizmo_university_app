import 'package:european_university_app/app/domain/models/timesheet.dart';
import 'package:european_university_app/app/domain/states/timesheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
          ...List.generate(
              state.timesheetModel?.timesheet.length ?? 0,
              (index) => TimesheetLessonItem(
                item: state.timesheetModel?.timesheet[index]
              )
          )
        ],
      ],
    );
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
                '${item?.lesson?.name}'
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

