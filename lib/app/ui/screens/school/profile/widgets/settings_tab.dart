import 'package:european_university_app/app/domain/states/payment_state.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/custom_scroll_physics.dart';
import 'package:european_university_app/app/ui/widgets/payments/payment_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../app.dart';
import '../../../../../domain/states/school/school_profile_state.dart';
import '../../../../widgets/change_password.dart';
import '../../../../widgets/settings_language.dart';
import '../../../../widgets/settings_social_accounts.dart';
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
    final state = context.watch<SchoolProfileState>();
    final appState = context.read<AppState>();
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
                      state.changeLanguage(val);
                    },
                    selectLanguage: state.selectLanguage != null ?
                      state.selectLanguage!['id'] : null,
                  ),
                ),
              );
          }
        ),
        SettingsInput(
          title: getConstant('General_info'),
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
            title: getConstant('Payments'),
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => PaymentState(
                        context,
                        appState.userData?.id
                    ),
                    child: const PaymentList(),
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
                    user: context.read<AppState>().userData,
                    onSave: (){
                      state.updateUser();
                    },
                  ),
                ),
              );
            }
        ),
        SettingsInput(
            title: getConstant('Notifications'),
            onPress: () {}
        ),
        SettingsInput(
            title: getConstant('Sign_out'),
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
                    userId: appState.userData?.id,
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
    this.info,
  }) : super(key: key);

  final String title;
  final String? info;
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
           if(widget.info != null) ...[
             Expanded(
               child: Row(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Container(
                     alignment: Alignment.centerRight,
                     constraints: const BoxConstraints(
                       maxWidth: 180
                     ),
                     child: Text(
                       '${widget.info}',
                       style: TextStyles.s14w400.copyWith(
                           color: const Color(0xFF848484)
                       ),
                       textAlign: TextAlign.end,
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                   )
                 ],
               ),
             ),
          ],
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

