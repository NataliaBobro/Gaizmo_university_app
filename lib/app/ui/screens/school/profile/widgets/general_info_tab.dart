import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/screens/school/profile/branchs/branch_list.dart';
import 'package:european_university_app/app/ui/screens/school/profile/widgets/settings_tab.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../domain/states/school/school_branch_state.dart';

class GeneralInfoTab extends StatefulWidget {
  const GeneralInfoTab({
    Key? key,
    required this.tabController
  }) : super(key: key);

  final TabController tabController;

  @override
  State<GeneralInfoTab> createState() => _GeneralInfoTabState();
}

class _GeneralInfoTabState extends State<GeneralInfoTab> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final school = appState.userData;

    return ListView(
      physics: const BottomBouncingScrollPhysics(),
      children: [
        Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            if(school?.phone != null) ...[
              InfoValue(
                  title: getConstant('Phone_number'),
                  value: school?.phone ?? ''
              ),
            ],
            InfoValue(
                title: getConstant('Email'),
                value: "${school?.email}"
            ),
            InfoValue(
                title: getConstant('School_category'),
                value: getConstant('${school?.school?.category?.define}')
            ),
            SettingsInput(
                title: getConstant('Branches'),
                info: school?.parentCount != null && (school?.parentCount ?? 0) > 0?
                    '${school?.parentCount} ${getConstant('Branches')}'
                    : null,
                onPress: () async {
                  await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => SchoolBranchState(context),
                            child: const BranchList(),
                          )
                      )
                  );
                }
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              getConstant('Add_more_info_about_your_school'),
              style: TextStyles.s14w400,
            ),
            CupertinoButton(
                minSize: 0.0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 40
                ).copyWith(
                    top: 8
                ),
                child: Text(
                  getConstant('Go_to_settings'),
                  style: TextStyles.s14w400.copyWith(
                      color: Colors.black,
                      decoration: TextDecoration.underline
                  ),
                ),
                onPressed: () {
                  widget.tabController.animateTo(2);
                }
            )
          ],
        )
      ],
    );
  }
}

class InfoValue extends StatelessWidget {
  const InfoValue({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 18
      ),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            child: Text(
              '$title',
              style: TextStyles.s14w400.copyWith(
                color: const Color(0xFF848484)
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: SizerUtil.width / 2,
            ),
            child: Text(
              "$value",
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
          )
        ],
      ),
    );
  }
}

