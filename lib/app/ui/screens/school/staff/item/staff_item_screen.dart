import 'package:european_university_app/app/domain/states/school/school_staff_item_state.dart';
import 'package:european_university_app/app/ui/screens/school/staff/item/widgets/staff_avatar.dart';
import 'package:european_university_app/app/ui/screens/school/staff/item/widgets/staff_documents_tab.dart';
import 'package:european_university_app/app/ui/screens/school/staff/item/widgets/staff_info.dart';
import 'package:european_university_app/app/ui/screens/school/staff/item/widgets/staff_personal_info_tab.dart';
import 'package:european_university_app/app/ui/screens/school/staff/item/widgets/staff_settings_tab.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../resources/resources.dart';
import '../../../../theme/text_styles.dart';

class StaffItemScreen extends StatefulWidget {
  const StaffItemScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StaffItemScreen> createState() => _StaffItemScreenState();
}

class _StaffItemScreenState extends State<StaffItemScreen> with TickerProviderStateMixin{
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
    final state = context.watch<SchoolStaffItemState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFF0F3F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const StaffHeader(),
                StaffAvatar(
                    staff: state.staff,
                    onUpload: () {
                      state.updateStaff();
                    },
                ),
                StaffInfo(
                    staff: state.staff
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
                        horizontal: 0
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
                          Tab(
                            height: 24,
                            text: getConstant('Personal_info'),
                            iconMargin: EdgeInsets.zero,
                          ),
                          if(isActiveTab == 0) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: AppColors.appButton,
                            )
                          ]
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Tab(
                            height: 19,
                            text: getConstant('Documents'),
                          ),
                          if(isActiveTab == 1) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: AppColors.appButton,
                            )
                          ]
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Tab(
                            height: 19,
                            text: getConstant('Settings'),
                          ),
                          if(isActiveTab == 2) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: AppColors.appButton,
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
                        StaffPersonalInfoTab(),
                        StaffDocumentsTab(),
                        StaffSettingsTab(),
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


class StaffHeader extends StatefulWidget {
  const StaffHeader({Key? key}) : super(key: key);

  @override
  State<StaffHeader> createState() => _StaffHeaderState();
}

class _StaffHeaderState extends State<StaffHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              right: 10
            ),
            child: SvgPicture.asset(
              Svgs.back
            ),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
          Text(
            getConstant('Staff'),
            style: TextStyles.s24w700.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
        ],
      ),
    );
  }
}
