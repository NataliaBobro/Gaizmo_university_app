import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/resources.dart';
import '../../../domain/models/lesson.dart';
import '../../screens/students/schedule/widgets/preview_list_student.dart';
import '../../theme/text_styles.dart';


class HeaderEtm extends StatelessWidget {
  const HeaderEtm({
    Key? key,
    required this.visits,
    required this.lessons,
  }) : super(key: key);

  final Lesson lessons;
  final Function visits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
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
              '+${lessons.services?.first?.etm} ETM',
              style: TextStyles.s10w600.copyWith(
                  color: const Color(0xFF242424)
              ),
            )
          ],
        ),
        CupertinoButton(
            minSize: 0.0,
            padding: const EdgeInsets.only(left: 30, top: 3),
            onPressed: lessons.isVisitsExists == true ? null : () {
              visits();
            },
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: lessons.isVisitsExists == true ?
                  const Color(0xFF27AE60) : const Color(0xFFFFC700)
              ),
              child: SvgPicture.asset(
                  Svgs.boxCheck
              ),
            )
        )
      ],
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
          ContentRowInfo(
            title: 'Students',
            content: PreviewListStudent(
                serviceId: widget.lesson?.services?.first?.id,
                users: widget.lesson?.services?.first?.payUsers
            ),
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
