import 'package:etm_crm/app/domain/states/school/school_schedule_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../../resources/resources.dart';

class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<SchoolScheduleState>();
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 24,
                    top: 16,
                    bottom: 24
                ),
                child: Text(
                  'Schedule',
                  style: TextStyles.s24w700.copyWith(
                      color: const Color(0xFF242424)
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 4,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFC700),
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: SvgPicture.asset(
                          Svgs.plus,
                          width: 24,
                        ),
                      ),
                      onPressed: () {
                        state.addLesson();
                      }
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 12,
                        right: 24
                    ),
                    child: SvgPicture.asset(
                        Svgs.menu
                    ),
                    onPressed: () {
                      state.openFilter();
                    },
                  )
                ],
              )
            ],
          ),
          const ScheduleFilter()
        ],
      ),
    );
  }
}


class ScheduleFilter extends StatefulWidget {
  const ScheduleFilter({Key? key}) : super(key: key);

  @override
  State<ScheduleFilter> createState() => _ScheduleFilterState();
}

class _ScheduleFilterState extends State<ScheduleFilter> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  List<Map<String, String>> generateDates() {
    List<Map<String, String>> dateList = [];
    DateTime now = DateTime.now();

    for (int i = -5; i <= 15; i++) {
      DateTime date = now.add(Duration(days: i));
      dateList.add({
        'day': DateFormat('d').format(date),
        'name': DateFormat('E').format(date),
      });
    }

    return dateList;
  }

  String getWeekday(DateTime date) {
    return DateFormat('E').format(date);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> dates = generateDates();
    final state = context.watch<SchoolScheduleState>();
    final activeIndex = state.filterDateIndex;

    return SizedBox(
      height: 84,
      child: ScrollablePositionedList.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemScrollController: _itemScrollController,
          itemCount: dates.length,
          shrinkWrap: true,
          initialScrollIndex: 5,
          itemBuilder: (context, index) => CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    '${dates[index]['name']}',
                    style: TextStyles.s14w600.copyWith(
                        color: activeIndex == index ?
                        const Color(0xFF242424) : const Color(0xFFACACAC)
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: activeIndex == index ?
                        const Color(0xFFFFC700) : const Color(0xFFE9EEF2)
                    ),
                    child: Center(
                      child: Text(
                        '${dates[index]['day']}',
                        style: TextStyles.s14w600.copyWith(
                            color: activeIndex == index ? Colors.white : const Color(0xFFACACAC)
                        ),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {
                state.changeDateFilter(index);
              }
          )
      ),
    );
  }
}
