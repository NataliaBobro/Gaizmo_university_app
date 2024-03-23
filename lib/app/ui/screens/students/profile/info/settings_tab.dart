import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/screens/students/profile/info/widgets/personal_info_student.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:etm_crm/app/ui/widgets/notifications_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/services/user_service.dart';
import '../../../../theme/text_styles.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/settings_input.dart';
import '../../../../widgets/settings_language.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return ListView(
      padding: const EdgeInsets.only(top: 24),
      physics: const BottomBouncingScrollPhysics(),
      children: [
        SettingsInput(
            title: getConstant('Language'),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingLanguage(
                      saveLanguage: (val) {
                        changeLanguageForUser(val['id']);
                      },
                      selectLanguage: state.userData?.languageId,
                    )
                ),
              );
            }
        ),
        SettingsInput(
            title: getConstant('Personal_info'),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalInfoStudent(
                      student: state.userData
                    )
                ),
              );
            }
        ),
        SettingsInput(
            title: getConstant('Notifications'),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsSettings(
                        user: state.userData,
                        onUpdate: () {
                          state.getUser();
                        },
                    )
                ),
              );
            }
        ),
        // SettingsInput(
        //     title: "My cards",
        //     onPress: () async {
        //       await Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => PaymentCartScreen(
        //               userId: state.userData?.id,
        //             )
        //         ),
        //       );
        //     }
        // ),
        SettingsInput(
            title: getConstant('Sign_out'),
            onPress: () {
              showSignOutDialog();
            }
        ),

      ],
    );
  }

  Future<void> changeLanguageForUser(val) async {
    final read = context.read<AppState>().userData;
    try{
      final result = await UserService.changeLanguageForUser(
          context,
          read?.id,
          val
      );
      if(result == true){
        read?.languageId = val;
        updateUser();
      }
    }catch(e){
      print(e);
    }
  }

  Future<void> showSignOutDialog() async {
    await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        content: Text(
          getConstant('Do_you_really_want_to_sign_up_from_ETM'),
          style: TextStyles.s17w600,
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: Text(getConstant('Yes')),
            onPressed: () {
              Navigator.pop(context);
              context.read<AppState>().onLogout();
            },
          ),
          BasicDialogAction(
            title: Text(getConstant('No')),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void updateUser() {
    context.read<AppState>().getUser();
  }
}
