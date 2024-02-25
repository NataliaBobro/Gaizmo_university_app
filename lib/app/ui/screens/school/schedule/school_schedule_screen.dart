import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:etm_crm/app/domain/models/lesson.dart';
import 'package:etm_crm/app/domain/states/school/school_schedule_state.dart';
import 'package:etm_crm/app/ui/screens/school/schedule/widgets/schedule_header.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../theme/text_styles.dart';

class SchoolScheduleScreen extends StatefulWidget {
  const SchoolScheduleScreen({Key? key}) : super(key: key);

  @override
  State<SchoolScheduleScreen> createState() => _SchoolScheduleScreenState();
}

class _SchoolScheduleScreenState extends State<SchoolScheduleScreen> {
  int? viewOnDelete;


  void changeViewDelete(int? id){
    setState(() {
      viewOnDelete = id;
    });
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
              const ScheduleHeader(),
              if(state.isLoading) ...[
                const Expanded(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              ] else ...[
                if((state.lessonsList?.lessons?.length ?? 0) == 0) ... [
                  Expanded(
                    child: EmptyWidget(
                      isEmpty: true,
                      title: 'No classes today :(',
                      subtitle: 'Click the button below to add lessons',
                      onPress: () {
                        state.addLesson();
                      },
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Accordion(
                                onDelete: (index) {
                                  changeViewDelete(state.lessonsList?.lessons?[index].id);
                                },
                                onEdit: (index) {
                                  state.openEditLesson(state.lessonsList?.lessons?[index]);
                                },
                                isFullActionButton: true,
                                paddingListTop: 0.0,
                                disableScrolling: true,
                                headerBorderWidth: 0,
                                contentBorderWidth: 0,
                                headerBorderRadius: 15,
                                scaleWhenAnimating: false,
                                openAndCloseAnimation: true,
                                paddingListHorizontal: 16,
                                paddingListBottom: 0.0,
                                flipRightIconIfOpen: false,
                                headerPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16
                                ),
                                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                                children: List.generate(
                                    state.lessonsList?.lessons?.length ?? 0,
                                        (index) => AccordionSection(
                                      isOpen: false,
                                      headerBackgroundColor:
                                      Color(int.parse('${state.lessonsList?.lessons?[index].services?.first?.color}')).withOpacity(.6),
                                      contentVerticalPadding: 0,
                                      rightIcon: HeaderEtm(
                                          etm: state.lessonsList?.lessons?[index].services?.first?.etm
                                      ),
                                      contentBorderWidth: 0,
                                      contentHorizontalPadding: 0.0,
                                      contentBackgroundColor: const Color(0xFFF0F3F6),
                                      header: HeaderNameLesson(
                                          lesson: state.lessonsList?.lessons?[index]
                                      ),
                                      onDelete: (index) {

                                      },
                                      onEdit: (service) {

                                      },
                                      content: LessonItem(
                                          lesson: state.lessonsList?.lessons?[index]
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                        if(viewOnDelete != null) ...[
                          Positioned(
                            child: GestureDetector(
                              onTap: () {
                                changeViewDelete(null);
                              },
                              child: Container(
                                width: SizerUtil.width,
                                color: Colors.black.withOpacity(.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 55,
                                          vertical: 24
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 53
                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Are you sure you want\n to delete the lesson?',
                                            style: TextStyles.s14w600,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  minSize: 0.0,
                                                  onPressed: () {
                                                    state.deleteLesson(viewOnDelete);
                                                    changeViewDelete(null);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 4
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: const Color(0xFF242424)
                                                        )
                                                    ),
                                                    child: Text(
                                                      'YES',
                                                      style: TextStyles.s12w600.copyWith(
                                                          color: const Color(0xFF242424)
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  minSize: 0.0,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 4
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: const Color(0xFFFFC700),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: const Color(0xFFFFC700),
                                                        )
                                                    ),
                                                    child: Text(
                                                      'NO',
                                                      style: TextStyles.s12w600.copyWith(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    changeViewDelete(null);
                                                  }
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ]
              ]
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
    String timeString = lesson?.lessonStart ?? '00:00:00';
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat('HH:mm');

    DateTime parsedTime = inputFormat.parse(timeString);
    String start = outputFormat.format(parsedTime);

    DateTime parseEnd = parsedTime.add(Duration(minutes: lesson?.services?.first?.duration ?? 0));
    String end = outputFormat.format(parseEnd);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${lesson?.services?.first?.name}',
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
          color: Color(int.parse('${widget.lesson?.services?.first?.color}')).withOpacity(.4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentRowInfo(
            title: 'Teacher',
            value: '${widget.lesson?.services?.first?.teacher?.firstName} '
                '${widget.lesson?.services?.first?.teacher?.lastName}',
          ),
          const ContentRowInfo(
            title: 'Students',
            value: '0',
          ),
          ContentRowInfo(
            title: 'Adress',
            value: '${widget.lesson?.services?.first?.school?.street} '
                '${widget.lesson?.services?.first?.school?.house}',
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

