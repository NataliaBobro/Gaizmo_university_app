import 'package:european_university_app/app/domain/states/school/school_staff_item_state.dart';
import 'package:european_university_app/app/ui/screens/school/staff/item/widgets/staff_personal_info_screen.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/change_password.dart';
import 'package:european_university_app/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../app.dart';
import '../../../../../widgets/modal/delete_account_modal.dart';
import '../../../profile/widgets/settings_tab.dart';

class StaffSettingsTab extends StatefulWidget {
  const StaffSettingsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<StaffSettingsTab> createState() => _StaffSettingsTabState();
}

class _StaffSettingsTabState extends State<StaffSettingsTab> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SchoolStaffItemState>();
    return ListView(
      physics: const BottomBouncingScrollPhysics(),
      children: [
        const SizedBox(
          height: 24,
        ),
        SettingsInput(
            title: getConstant('Personal_info'),
            onPress: () async {
              read.openPage(
                  const StaffPersonalInfoScreen()
              );
            }
        ),
        SettingsInput(
            title: getConstant('Category'),
            onPress: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //       value: read,
              //       child: const SettingsSocialAccounts(),
              //     ),
              //   ),
              // );
            }
        ),
        SettingsInput(
            title: getConstant('Schedule'),
            onPress: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //       value: read,
              //       child: const SettingsSocialAccounts(),
              //     ),
              //   ),
              // );
            }
        ),
        SettingsInput(
            title: getConstant('My_social_accounts'),
            onPress: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //       value: read,
              //       child: const SettingsSocialAccounts(),
              //     ),
              //   ),
              // );
            }
        ),
        SettingsInput(
            title: getConstant('Password'),
            onPress: () async {
              read.openPage(
                  ChangePassword(
                      userId: read.staff?.id
                  )
              );
            }
        ),
        SettingsInput(
            title: getConstant('Delete_account'),
            onPress: () {
              showDeleteDialog(context, () {
                Navigator.pop(context);
                context.read<AppState>().deleteAccount(userId: read.staff?.id);
              });
            }
        ),
      ],
    );
  }
}
