import 'package:european_university_app/app/domain/states/progress/ProgressState.dart';
import 'package:european_university_app/app/domain/states/student/student_passport_state.dart';
import 'package:european_university_app/app/ui/screens/progress/ProgressScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/states/student/student_home_state.dart';
import '../../../widgets/profile/passport/passport_screen.dart';
import '../../../widgets/profile/passport/widgets/passport_view.dart';
import 'info/student_profile_screen.dart';

class StudentProfileScrollPage extends StatefulWidget {
  const StudentProfileScrollPage({Key? key}) : super(key: key);

  @override
  State<StudentProfileScrollPage> createState() => _StudentProfileScrollPageState();
}

class _StudentProfileScrollPageState extends State<StudentProfileScrollPage> {
  PageController? pageController = PageController(initialPage: 1);
  double offset = 0;
  double offsetScroll = 0;

  @override
  void initState() {
    pageController?.addListener(() {
      changeScroll();
    });
    print((SizerUtil.width - 40) - (offset / 1.2));
    super.initState();
  }

  void changeTab() {
    pageController?.animateTo(
        SizerUtil.width,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
    );
  }

  void changeScroll() {
    setState(() {
      offset = (pageController?.offset ?? 0) - SizerUtil.width;
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
              create: (context) => ProgressState(context),
              child: const ProgressScreen(),
            ),
            ChangeNotifierProvider(
              create: (context) => StudentHomeState(context),
              child: const StudentProfileScreen(),
            ),
            ChangeNotifierProvider(
              create: (context) => StudentPassportState(context),
              child: PassportScreen(
                  changeTab: () {
                    changeTab();
                  },
                  onUpdateScroll: (value) {
                    setState(() {
                      offsetScroll = value;
                    });
                  },
              ),
            ),
          ],
        ),
        Positioned(
          top: 124 - offsetScroll,
          left: (SizerUtil.width - 40) - (offset / 1.2),
          child: const IgnorePointer(
            child: PassportView(),
          ),
        ),
        if(offset >= -(SizerUtil.width / 2)) ...[
          Positioned(
            top: ((SizerUtil.height / 100) * 46) < 330 ? ((SizerUtil.height / 100) * 46) : 330,
            right: 0,
            left: 0,
            child:  IgnorePointer(
              child: DoteIndicator(
                activeIndex: pageController?.positions.isNotEmpty == true ?
                pageController?.page : 0,
              ),
            ),
          )
        ]
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
          3,
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
