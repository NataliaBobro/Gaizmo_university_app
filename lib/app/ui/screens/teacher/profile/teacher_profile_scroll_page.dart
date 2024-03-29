import 'package:european_university_app/app/domain/states/student/student_passport_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/states/student/student_home_state.dart';
import '../../../widgets/profile/passport/passport_screen.dart';
import '../../../widgets/profile/passport/widgets/passport_view.dart';
import 'info/teacher_profile_screen.dart';

class TeacherProfileScrollPage extends StatefulWidget {
  const TeacherProfileScrollPage({Key? key}) : super(key: key);

  @override
  State<TeacherProfileScrollPage> createState() => _TeacherProfileScrollPageState();
}

class _TeacherProfileScrollPageState extends State<TeacherProfileScrollPage> {
  PageController? pageController = PageController();
  double offset = 0;

  @override
  void initState() {
    pageController?.addListener(() {
      changeScroll();
    });
    super.initState();
  }

  void changeTab(int? index) {
    pageController?.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void changeScroll() {
    setState(() {
      offset = pageController?.offset ?? 0;
    });
  }

  @override
  void dispose() {
    pageController?.removeListener(() { });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const ClampingScrollPhysics(),
          controller: pageController,
          children: [
            ChangeNotifierProvider(
              create: (context) => StudentHomeState(context),
              child: const TeacherProfileScreen(),
            ),
            ChangeNotifierProvider(
              create: (context) => StudentPassportState(context),
              child: PassportScreen(
                  changeTab: () {
                    changeTab(0);
                  }
              ),
            ),
          ],
        ),
        Positioned(
          top: 124,
          left: (SizerUtil.width - 40) - (offset / 1.2),
          child: const IgnorePointer(
            child: PassportView(),
          ),
        ),
        Positioned(
          top: 335,
          right: 0,
          left: 0,
          child:  IgnorePointer(
            child: DoteIndicator(
              activeIndex: pageController?.positions.isNotEmpty == true ?
              pageController?.page : 0,
            ),
          ),
        )
      ],
    );
  }
}


class DoteIndicator extends StatefulWidget {
  const DoteIndicator({
    Key? key,
    required this.activeIndex
  }) : super(key: key);

  final double? activeIndex;

  @override
  State<DoteIndicator> createState() => _DoteIndicatorState();
}

class _DoteIndicatorState extends State<DoteIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
          2,
              (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: widget.activeIndex?.round() == index ? Colors.grey : Colors.grey.withOpacity(.5),
                borderRadius: BorderRadius.circular(100)
            ),
          )
      ),
    );
  }
}
