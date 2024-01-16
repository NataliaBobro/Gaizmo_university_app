import 'package:etm_crm/app/domain/states/student/student_school_item_state.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_avatar.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_general_info.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_info.dart';
import 'package:etm_crm/app/ui/screens/students/schools/item/widgets/student_school_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../resources/resources.dart';
import '../../../../theme/text_styles.dart';

class StudentSchoolItem extends StatefulWidget {
  const StudentSchoolItem({Key? key}) : super(key: key);

  @override
  State<StudentSchoolItem> createState() => _StudentSchoolItemState();
}

class _StudentSchoolItemState extends State<StudentSchoolItem> with TickerProviderStateMixin{
  late int isActiveTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
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
    final state = context.watch<StudentSchoolItemState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFF0F3F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SchoolHeader(),
                BranchAvatar(
                  hasAdd: false,
                  userData: state.userSchool,
                ),
                BranchInfo(
                    branch: state.userSchool
                ),
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
                            text: 'Personal info',
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
                            text: 'Services',
                          ),
                          if(isActiveTab == 1) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: const Color(0xFFFFC700),
                            )
                          ]
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        BranchGeneralInfoTab(
                            tabController: _tabController,
                            branch: state.userSchool
                        ),
                        const StudentSchoolServices()
                      ]
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

class SchoolHeader extends StatefulWidget {
  const SchoolHeader({Key? key}) : super(key: key);

  @override
  State<SchoolHeader> createState() => _SchoolHeaderState();
}

class _SchoolHeaderState extends State<SchoolHeader> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "School",
                style: TextStyles.s24w700.copyWith(
                    color: const Color(0xFF242424)
                ),
              )
            ],
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ).copyWith(
                top: 10
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 36,
                height: 36,
                child: SvgPicture.asset(
                  Svgs.close,
                  width: 36,
                ),
              )
            )
          )
        ],
      ),
    );
  }
}
