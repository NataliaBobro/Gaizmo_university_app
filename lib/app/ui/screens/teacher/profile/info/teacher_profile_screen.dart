import 'package:etm_crm/app/ui/screens/teacher/profile/info/my_lessons_tab.dart';
import 'package:etm_crm/app/ui/screens/teacher/profile/info/personal_info_tab.dart';
import 'package:etm_crm/app/ui/screens/teacher/widgets/profile_header.dart';
import 'package:etm_crm/app/ui/screens/teacher/widgets/user_info.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
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
                  height: 55,
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.zero,
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 0.5,
                    labelStyle: TextStyles.s14w700,
                    // isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: 16
                    ).copyWith(
                        bottom: 24
                    ),
                    labelColor: const Color(0xFF242424),
                    unselectedLabelStyle: TextStyles.s14w400,
                    unselectedLabelColor: const Color(0xFFACACAC),
                    tabs: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Tab(
                            height: 24,
                            text: 'My lessons',
                            iconMargin: EdgeInsets.zero,
                          ),
                          if(isActiveTab == 0) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: const Color(0xFFFFC700),
                            )
                          ]
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Tab(
                            height: 19,
                            text: 'Personal info',
                          ),
                          if(isActiveTab == 1) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: const Color(0xFFFFC700),
                            )
                          ]
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Tab(
                            height: 19,
                            text: 'Settings',
                          ),
                          if(isActiveTab == 2) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: const Color(0xFFFFC700),
                            )
                          ]
                        ],
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

