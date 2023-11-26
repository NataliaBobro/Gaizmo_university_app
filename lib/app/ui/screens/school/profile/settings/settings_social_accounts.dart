import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/school/school_profile_state.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class SettingsSocialAccounts extends StatefulWidget {
  const SettingsSocialAccounts({Key? key}) : super(key: key);

  @override
  State<SettingsSocialAccounts> createState() => _SettingsSocialAccountsState();
}

class _SettingsSocialAccountsState extends State<SettingsSocialAccounts> {

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolProfileState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'Settings'
                ),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'Instagram link',
                              controller: state.instagramField,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'Facebook link',
                              controller: state.facebookField,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'Linkedin link',
                              controller: state.linkedinField,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'Twitter link',
                              controller: state.twitterField,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: AppButton(
                      title: 'Save changes',
                      onPressed: () {
                        state.saveSocialLinks();
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
