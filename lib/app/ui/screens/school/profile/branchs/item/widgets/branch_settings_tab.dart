import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/user_service.dart';
import 'package:etm_crm/app/domain/states/school/school_branch_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../resources/resources.dart';
import '../../../../../../widgets/settings_language.dart';

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
        SettingsInput(
            title: "Language",
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingLanguage(
                    saveLanguage: (val) {
                      changeLanguageForUser(val['id']);
                    },
                    selectLanguage: widget.branch?.languageId,
                  )
                ),
              );
            }
        ),
        SettingsInput(
            title: "General info",
            onPress: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //       value: read,
              //       child: const SettingGeneralInfo(),
              //     ),
              //   ),
              // );
            }
        ),
        SettingsInput(
            title: "Social accounts",
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

