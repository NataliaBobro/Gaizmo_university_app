import 'package:etm_crm/app/domain/states/student/student_passport_state.dart';
import 'package:etm_crm/app/ui/screens/students/profile/passport/student_passport_screen.dart';
import 'package:etm_crm/app/ui/screens/students/profile/passport/widgets/possport_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/states/student/student_home_state.dart';
import 'info/student_profile_screen.dart';

class StudentProfileScrollPage extends StatefulWidget {
  const StudentProfileScrollPage({Key? key}) : super(key: key);

  @override
  State<StudentProfileScrollPage> createState() => _StudentProfileScrollPageState();
}

class _StudentProfileScrollPageState extends State<StudentProfileScrollPage> {
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
              child: const StudentProfileScreen(),
            ),
            ChangeNotifierProvider(
              create: (context) => StudentPassportState(context),
              child: StudentPassportScreen(
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
        )
      ],
    );
  }
}
