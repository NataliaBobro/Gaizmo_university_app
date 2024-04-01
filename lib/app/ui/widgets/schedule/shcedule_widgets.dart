import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/resources.dart';
import '../../../domain/models/lesson.dart';
import '../../screens/students/schedule/widgets/preview_list_student.dart';
import '../../theme/text_styles.dart';
import '../../utils/url_launch.dart';


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
        if(lessons.services?.first?.etm != null && lessons.isVisitsExists == true) ...[
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
                '+${lessons.services?.first?.etm} EU',
                style: TextStyles.s10w600.copyWith(
                    color: const Color(0xFF242424)
                ),
              )
            ],
          ),
        ],
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
                  const Color(0xFF27AE60) : AppColors.appButton
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
    required this.lesson,
    this.isTeacher = false
  }) : super(key: key);

  final Lesson? lesson;
  final bool isTeacher;

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  bool viewDesc = false;

  @override
  void initState() {
    super.initState();
  }

  void changeDesc(){
    setState(() {
      viewDesc = !viewDesc;
    });
  }

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
          color: Color(int.parse('${widget.lesson?.color}')).withOpacity(.4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.lesson?.teacher != null) ...[
            ContentRowInfo(
              title: getConstant('Teacher'),
              value: '${widget.lesson?.teacher?.firstName} '
                  '${widget.lesson?.teacher?.lastName}',
            )
          ],
          ContentRowInfo(
            title: getConstant('Students'),
            content: PreviewListStudent(
                serviceId: widget.lesson?.services?.first?.id,
                users: widget.lesson?.services?.first?.payUsers
            ),
          ),
          ContentRowInfo(
            title: getConstant('Adress'),
            value: '${widget.lesson?.services?.first?.school?.street} '
                '${widget.lesson?.services?.first?.school?.house}',
          ),
          if(widget.lesson?.schoolClass != null) ...[
            ContentRowInfo(
                title: getConstant('Class_number'),
                value: '${widget.lesson?.schoolClass?.name}'
            )
          ],
          if(widget.lesson?.zoomMeeting != null) ...[
            ContentRowInfo(
              title: getConstant('Lesson_links'),
              content: CupertinoButton(
                minSize: 0.0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  launchUrlParse(
                      widget.isTeacher ?
                        widget.lesson?.zoomMeeting?.startUrl :
                        widget.lesson?.zoomMeeting?.joinUrl
                  );
                },
                child: SvgPicture.asset(
                  Svgs.zoom,
                  width: 65,
                ),
              ),
            ),
          ],
          if(widget.lesson?.services?.first?.desc != null) ...[
            ContentRowInfo(
              title: getConstant('Description'),
              content: CupertinoButton(
                minSize: 0.0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  changeDesc();
                },
                child: RotatedBox(
                  quarterTurns: 2,
                  child: SvgPicture.asset(
                      Svgs.open
                  ),
                ),
              ),
            ),

            if(viewDesc) ...[
              Text(
                "${widget.lesson?.services?.first?.desc}",
                style: TextStyles.s13w400.copyWith(
                    color: const Color(0xFF848484)
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              )
            ]
          ]
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
            style: TextStyles.s13w400.copyWith(
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
