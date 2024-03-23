import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/screens/students/profile/info/my_lessons_tab.dart';
import 'package:etm_crm/app/ui/screens/students/profile/info/personal_info_tab.dart';
import 'package:etm_crm/app/ui/screens/students/profile/info/settings_tab.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../theme/text_styles.dart';
import '../../../../widgets/profile/profile_avatar_with_etm.dart';
import '../../../students/profile/info/widgets/profile_header.dart';
import '../../../teacher/widgets/user_info.dart';


class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> with TickerProviderStateMixin{
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
    final appSate = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.white,
      key: ValueKey(appSate.constantsList),
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.zero,
                  controller: _tabController,
                  labelStyle: TextStyles.s14w700,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3.0, color: Color(0xFFFFC700)),
                    insets: EdgeInsets.only(right: 35.0),
                  ),
                  labelPadding: const EdgeInsets.symmetric(
                      horizontal: 16
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
