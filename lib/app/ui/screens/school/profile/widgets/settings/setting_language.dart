import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/states/school/school_profile_state.dart';
import '../../../../../widgets/select_bottom_sheet_input.dart';

class SettingLanguage extends StatefulWidget {
  const SettingLanguage({Key? key}) : super(key: key);

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        SelectBottomSheetInput(
                            label: "Choose language",
                            labelModal: "Choose language",
                            selected: state.selectLanguage,
                            items: state.listLanguage,
                            onSelect: (value) {
                              state.changeLanguage(value);
                            }
                        ),
                      ],
                    ),
                    if(state.selectLanguage?['id'] != context.watch<AppState>().userData?.languageId) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: AppButton(
                          title: 'Save changes',
                          onPressed: () {
                            state.saveLanguage();
                          }
                        ),
                      )
                    ]
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
