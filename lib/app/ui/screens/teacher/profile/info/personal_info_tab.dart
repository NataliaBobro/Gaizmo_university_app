import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/social_account_info.dart';
import 'package:european_university_app/app/ui/widgets/statistics/statistics_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/statistics_state.dart';
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
                value: "${state?.firstName} ${state?.lastName}"
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
            InfoValue(
                title: getConstant('My_salary'),
                value: "15000 per mounth"
            ),
            SettingsInput(
                title: getConstant('Statistics'),
                onPress: () async {
                  await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => StatisticsState(context) ,
                            child: const StatisticsScreen(),
                          )
                      )
                  );
                }
            ),
            SettingsInput(
                title: getConstant('Uniform'),
                onPress: () async {

                }
            ),
          ],
        )
      ],
    );
  }
}
