import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_avatar.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_document_tab.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_general_info.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_header.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_info.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_settings_tab.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/text_styles.dart';

class BranchItemScreen extends StatefulWidget {
  const BranchItemScreen({
    Key? key,
    required this.branch
  }) : super(key: key);

  final UserData? branch;

  @override
  State<BranchItemScreen> createState() => _BranchItemScreenState();
}

class _BranchItemScreenState extends State<BranchItemScreen> with TickerProviderStateMixin{
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
                const BranchHeader(),
                BranchAvatar(
                    userData: widget.branch
                ),
                BranchInfo(
                  branch: widget.branch,
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
                            text: 'General info',
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
                            text: 'Documents',
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
                    children: [
                      BranchGeneralInfoTab(
                        tabController: _tabController,
                        branch: widget.branch,
                      ),
                      BranchDocumentTab(
                        branch: widget.branch,
                      ),
                      BranchSettingsTab(
                        branch: widget.branch,
                      )
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
