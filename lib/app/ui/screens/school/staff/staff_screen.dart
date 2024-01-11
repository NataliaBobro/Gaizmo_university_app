import 'package:etm_crm/app/domain/models/lesson.dart';
import 'package:etm_crm/app/domain/states/school/school_staff_state.dart';
import 'package:etm_crm/app/ui/screens/school/staff/widgets/staff_header.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/resources.dart';
import '../../../../domain/models/user.dart';
import '../../../theme/text_styles.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolStaffState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const StaffHeader(),
              if(state.isLoading) ...[
                const CupertinoActivityIndicator(),
              ]else ...[
                Expanded(
                  flex: (state.staffList?.users.length ?? 0) == 0 ? 1 : 0,
                  child: EmptyWidget(
                    isEmpty: (state.staffList?.users.length ?? 0) == 0,
                    title: 'No any employee yet :(',
                    subtitle: 'Click the button below to add staff!',
                    onPress: () {
                      state.openAddStaff();
                    },
                  ),
                ),
                if((state.staffList?.users.length ?? 0) > 0) ...[
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16
                          ),
                          child: Column(
                            children: [
                              ...List.generate(
                                  state.staffList?.users.length ?? 0,
                                      (index) => StaffItem(
                                      index: index,
                                      staff: state.staffList?.users[index]
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class StaffItem extends StatefulWidget {
  const StaffItem({
    Key? key,
    this.staff,
    required this.index
  }) : super(key: key);

  final UserData? staff;
  final int index;

  @override
  State<StaffItem> createState() => _StaffItemState();
}

class _StaffItemState extends State<StaffItem> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SchoolStaffState>();
    return Container(
      margin: const EdgeInsets.only(
          bottom: 8
      ),
      child: CupertinoButton(
        minSize: 0.0,
        padding: EdgeInsets.zero,
        onPressed: () {
          read.openStaff(
              widget.staff
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE9EEF2),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              Text(
                '${widget.index + 1}.',
                style: TextStyles.s14w600.copyWith(
                  color: Colors.black
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFDFE3E9)
                  )
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '${widget.staff?.firstName} ${widget.staff?.lastName}',
                style: TextStyles.s14w600.copyWith(
                  color: const Color(0xFF242424)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class HeaderNameLesson extends StatelessWidget {
  const HeaderNameLesson({
    Key? key,
    required this.lesson
  }) : super(key: key);

  final Lesson? lesson;

  @override
  Widget build(BuildContext context) {
    String timeString = "${lesson?.lessonStart}";
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat('HH:mm');

    DateTime parsedTime = inputFormat.parse(timeString);
    String start = outputFormat.format(parsedTime);

    DateTime parseEnd = parsedTime.add(Duration(minutes: lesson?.service?.duration ?? 0));
    String end = outputFormat.format(parseEnd);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${lesson?.service?.name}',
          style: TextStyles.s14w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Start $start - End $end',
          style: TextStyles.s12w400.copyWith(
              color: const Color(0xFF848484)
          ),
        )
      ],
    );
  }
}


class HeaderEtm extends StatelessWidget {
  const HeaderEtm({
    Key? key,
    required this.etm
  }) : super(key: key);

  final int? etm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 27
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Svgs.etmPlus,
            width: 24,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            '+$etm ETM',
            style: TextStyles.s10w600.copyWith(
                color: const Color(0xFF242424)
            ),
          )
        ],
      ),
    );
  }
}


class LessonItem extends StatefulWidget {
  const LessonItem({
    Key? key,
    required this.lesson
  }) : super(key: key);

  final Lesson? lesson;

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(
          top: 14,
          bottom: 10
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(int.parse('${widget.lesson?.service?.color}')).withOpacity(.4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentRowInfo(
            title: 'Teacher',
            value: '${widget.lesson?.service?.teacher?.firstName} '
                '${widget.lesson?.service?.teacher?.lastName}',
          ),
          const ContentRowInfo(
            title: 'Students',
            value: '0',
          ),
          ContentRowInfo(
            title: 'Adress',
            value: '${widget.lesson?.service?.school?.street} '
                '${widget.lesson?.service?.school?.house}',
          ),
          ContentRowInfo(
              title: 'Class number',
              value: '${widget.lesson?.schoolClass?.name}'
          ),
          const ContentRowInfo(
              title: 'Lesson links',
              value: ''
          ),
          ContentRowInfo(
            title: 'Description',
            content: CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              onPressed: () {

              },
              child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                    Svgs.open
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentRowInfo extends StatelessWidget {
  const ContentRowInfo({
    Key? key,
    required this.title,
    this.value,
    this.content,
  }) : super(key: key);

  final String? title;
  final String? value;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 11
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: TextStyles.s12w400.copyWith(
                color: const Color(0xFF848484)
            ),
          ),
          content ??
              Text(
                '$value',
                style: TextStyles.s12w400.copyWith(
                    color: const Color(0xFF242424)
                ),
              ),
        ],
      ),
    );
  }
}

