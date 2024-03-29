import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/screens/teacher/profile/info/widgets/personal_info_teacher.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/services/user_service.dart';
import '../../../../theme/text_styles.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/notifications_settings.dart';
import '../../../../widgets/settings/settings_document.dart';
import '../../../../widgets/settings_input.dart';
import '../../../../widgets/settings_language.dart';
import '../../../../widgets/settings_social_accounts.dart';


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
            title: "Personal info",
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalInfoTeacher(
                        student: state.userData
                    )
                ),
              );
            }
        ),
        SettingsInput(
            title: "Social accounts",
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsSocialAccounts(
                    user: state.userData,
                  ),
                ),
              );
            }
        ),
        SettingsInput(
            title: "Notifications",
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
        SettingsInput(
            title: "My documents",
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsDocument(
                      user: state.userData,
                    )
                ),
              );
            }
        ),
        SettingsInput(
            title: "Sign out",
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
        content: const Text(
          "Do you really want\n to sign up from “ETM”?",
          style: TextStyles.s17w600,
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("Yes"),
            onPressed: () {
              Navigator.pop(context);
              context.read<AppState>().onLogout();
            },
          ),
          BasicDialogAction(
            title: const Text("No"),
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
