import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/screens/students/profile/info/widgets/my_qr_code.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:etm_crm/app/ui/widgets/social_account_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/info_value.dart';
import '../../../../widgets/settings_input.dart';

class PersonalInfoTab extends StatefulWidget {
  const PersonalInfoTab({Key? key}) : super(key: key);

  @override
  State<PersonalInfoTab> createState() => _PersonalInfoTabState();
}

class _PersonalInfoTabState extends State<PersonalInfoTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>().userData;
    return ListView(
      physics: const BottomBouncingScrollPhysics(),
      children: [
        Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            InfoValue(
                title: getConstant('Full_name'),
                value: "${state?.firstName} ${state?.lastName ?? state?.surname}"
            ),
            InfoValue(
                title: getConstant('Phone_number'),
                value: "${state?.phone}"
            ),
            InfoValue(
                title: getConstant('Email'),
                value: "${state?.email}"
            ),
            if(state?.socialAccounts != null) ...[
              SocialAccountInfo(
                  socialAccounts: state?.socialAccounts
              )
            ],
            SettingsInput(
                title: getConstant('QR_Code'),
                onPress: () async {
                  context.read<AppState>().openPage(
                      context,
                      const MuQrCode()
                  );
                }
            ),
          ],
        )
      ],
    );
  }
}
