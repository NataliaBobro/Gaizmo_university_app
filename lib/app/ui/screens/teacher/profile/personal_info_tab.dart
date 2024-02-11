import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/widgets/social_account_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_scroll_physics.dart';
import '../../../widgets/info_value.dart';
import '../../../widgets/settings_input.dart';


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
                title: "Full name",
                value: "${state?.firstName} ${state?.lastName}"
            ),
            InfoValue(
                title: "Phone number",
                value: "${state?.phone}"
            ),
            InfoValue(
                title: "E-mail",
                value: "${state?.email}"
            ),
            if(state?.socialAccounts != null) ...[
              SocialAccountInfo(
                  socialAccounts: state?.socialAccounts
              )
            ],
            const InfoValue(
                title: "My salary",
                value: "15000 per mounth"
            ),
            SettingsInput(
                title: "Statistics",
                onPress: () async {

                }
            ),
            SettingsInput(
                title: "Uniform",
                onPress: () async {

                }
            ),
          ],
        )
      ],
    );
  }
}
