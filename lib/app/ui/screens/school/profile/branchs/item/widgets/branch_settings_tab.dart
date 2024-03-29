import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/domain/services/user_service.dart';
import 'package:european_university_app/app/domain/states/school/school_branch_state.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/change_password.dart';
import 'package:european_university_app/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../widgets/settings_general_info.dart';
import '../../../../../../widgets/settings_input.dart';
import '../../../../../../widgets/settings_social_accounts.dart';

class BranchSettingsTab extends StatefulWidget {
  const BranchSettingsTab({
    Key? key,
    required this.branch
  }) : super(key: key);

  final UserData? branch;

  @override
  State<BranchSettingsTab> createState() => _BranchSettingsTabState();
}

class _BranchSettingsTabState extends State<BranchSettingsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 24),
      physics: const BottomBouncingScrollPhysics(),
      children: [
        // SettingsInput(
        //     title: "Language",
        //     onPress: () async {
        //       await Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => SettingLanguage(
        //             saveLanguage: (val) {
        //               changeLanguageForUser(val['id']);
        //             },
        //             selectLanguage: widget.branch?.languageId,
        //           )
        //         ),
        //       );
        //     }
        // ),
        SettingsInput(
            title: getConstant('General_info'),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingGeneralInfo(
                      userData: widget.branch,
                    ),
                  ),
                );
            }
        ),
        SettingsInput(
            title: getConstant('Social_accounts'),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsSocialAccounts(
                    user: widget.branch,
                  ),
                ),
              );
            }
        ),
        const SizedBox(
          height: 58,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24
          ),
          child: Text(
            getConstant('Privacy_settings'),
            style: TextStyles.s14w600.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SettingsInput(
            title: getConstant('Password'),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePassword(
                    userId: widget.branch?.id,
                  ),
                ),
              );
            }
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Future<void> changeLanguageForUser(val) async {
      try{
        final result = await UserService.changeLanguageForUser(
            context,
            widget.branch?.id,
            val
        );
        if(result == true){
          widget.branch?.languageId = val;
          updateUser();
        }
      }catch(e){
        print(e);
      }
  }

  void updateUser() {
    context.read<SchoolBranchState>().updateBranch(widget.branch?.id);
  }
}
