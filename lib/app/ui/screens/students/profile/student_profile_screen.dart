import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/screens/students/profile/widgets/profile_avatar.dart';
import 'package:etm_crm/app/ui/screens/students/profile/widgets/profile_header.dart';
import 'package:etm_crm/app/ui/screens/students/profile/widgets/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/text_styles.dart';


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
    final appState = context.read<AppState>();
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
              const ProfileAvatar(),
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
              CupertinoButton(
                  child: const Text('Logout'),
                  onPressed: () {
                    appState.onLogout();
                  }
              )
            ],
          ),
        )
      ),
    );
  }
}
