import 'package:etm_crm/app/ui/screens/school/profile/settings/settings_social_accounts.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../app.dart';
import '../../../../../domain/states/school/school_profile_state.dart';
import '../settings/setting_language.dart';
import '../settings/settings_general_info.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SchoolProfileState>();
    return ListView(
      padding: const EdgeInsets.only(top: 24),
      physics: const BottomBouncingScrollPhysics(),
      children: [
        SettingsInput(
          title: "Language",
          onPress: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: read,
                  child: const SettingLanguage(),
                ),
              ),
            );
          }
        ),
        SettingsInput(
          title: "General info",
          onPress: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: read,
                  child: const SettingGeneralInfo(),
                ),
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
                  builder: (context) => ChangeNotifierProvider.value(
                    value: read,
                    child: const SettingsSocialAccounts(),
                  ),
                ),
              );
            }
        ),
        SettingsInput(
            title: "Notifications",
            onPress: () {}
        ),
        SettingsInput(
            title: "Sign out",
            onPress: () {
              showSignOutDialog();
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
            'Privacy settings',
            style: TextStyles.s14w600.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SettingsInput(
            title: "Password",
            onPress: () {}
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
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
}

class SettingsInput extends StatefulWidget {
  const SettingsInput({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final Function onPress;

  @override
  State<SettingsInput> createState() => _SettingsInputState();
}

class _SettingsInputState extends State<SettingsInput> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 18
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyles.s14w400.copyWith(
              color: const Color(0xFF848484)
            ),
          ),
          SvgPicture.asset(
            Svgs.next,
            width: 32,
          )
        ],
      ),
      onPressed: () {
        widget.onPress();
      },
    );
  }
}

