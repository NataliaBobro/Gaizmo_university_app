import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/screens/school/profile/widgets/document_tab.dart';
import 'package:european_university_app/app/ui/screens/school/profile/widgets/general_info_tab.dart';
import 'package:european_university_app/app/ui/screens/school/profile/widgets/school_info.dart';
import 'package:european_university_app/app/ui/screens/school/profile/widgets/settings_tab.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

import '../../../theme/text_styles.dart';
import '../../school/profile/widgets/profile_header.dart';
import '../../school/profile/widgets/profile_avatar.dart';


class SchoolProfileScreen extends StatefulWidget {
  const SchoolProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SchoolProfileScreen> createState() => _SchoolProfileScreenState();
}

class _SchoolProfileScreenState extends State<SchoolProfileScreen> with TickerProviderStateMixin{
  late int isActiveTab = 0;
  late TabController _tabController;
  TabPageState? pageState;

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
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        key: ValueKey(state.constantsList),
          child: Container(
            width: double.infinity,
            color: const Color(0xFFF0F3F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ProfileHeader(),
                const ProfileAvatar(),
                const SchoolInfo(),
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
                    tabs:  [
                      Tab(
                        text: getConstant('General_info'),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: getConstant('Documents'),
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
                    children: [
                      GeneralInfoTab(
                        tabController: _tabController
                      ),
                      const DocumentTab(),
                      const SettingsTab()
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
