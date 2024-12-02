import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/screens/teacher/profile/info/my_lessons_tab.dart';
import 'package:european_university_app/app/ui/screens/teacher/profile/info/personal_info_tab.dart';
import 'package:european_university_app/app/ui/screens/teacher/widgets/profile_header.dart';
import 'package:european_university_app/app/ui/screens/teacher/widgets/user_info.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../theme/text_styles.dart';
import '../../../../widgets/profile/profile_avatar_with_etm.dart';
import '../../../students/profile/info/settings_tab.dart';

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> with TickerProviderStateMixin{
  late int isActiveTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: const Duration(milliseconds: 100),
    );

    _tabController.addListener(() {
      viewTab(_tabController.index);
    });
    super.initState();
  }

  void viewTab (index) {
    setState(() {
      isActiveTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      key: ValueKey(appState.constantsList),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFF0F3F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ProfileHeader(),
                const ProfileAvatarWithETM(),
                const UserInfo(),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      bottom: 24
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelStyle: TextStyles.s14w700,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3.0, color: AppColors.appButton),
                      insets: EdgeInsets.only(right: 35.0),
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: 0
                    ),
                    labelColor: const Color(0xFF242424),
                    unselectedLabelStyle: TextStyles.s14w400,
                    unselectedLabelColor: const Color(0xFFACACAC),
                    tabs: [
                      Tab(
                        text: getConstant('My_lessons'),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: getConstant('Personal_info'),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: getConstant('Settings'),
                        iconMargin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      MyLessonsTab(),
                      PersonalInfoTab(),
                      SettingTab()
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

