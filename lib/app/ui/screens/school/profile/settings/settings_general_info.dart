import 'package:etm_crm/app/ui/screens/school/profile/settings/settings_address.dart';
import 'package:etm_crm/app/ui/screens/school/profile/settings/settings_schedule.dart';
import 'package:etm_crm/app/ui/screens/school/profile/settings/settings_select_category.dart';
import 'package:etm_crm/app/ui/widgets/app_horizontal_field.dart';
import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/school/school_profile_state.dart';
import '../../../../widgets/auth_button.dart';
import '../widgets/settings_tab.dart';

class SettingGeneralInfo extends StatefulWidget {
  const SettingGeneralInfo({Key? key}) : super(key: key);

  @override
  State<SettingGeneralInfo> createState() => _SettingGeneralInfoState();
}

class _SettingGeneralInfoState extends State<SettingGeneralInfo> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SchoolProfileState>();
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
                        Expanded(
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              AppHorizontalField(
                                label: 'Name of school',
                                controller: state.nameSchool,
                                changeClear: () {
                                  state.changeClear(state.nameSchool);
                                },
                                error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                label: 'Phone number',
                                controller: state.phone,
                                changeClear: () {
                                  state.changeClear(state.phone);
                                },
                                error: state.validateError?.errors.phoneErrors?.first,
                              ),
                              AppHorizontalField(
                                label: 'E-mail',
                                controller: state.email,
                                changeClear: () {
                                  state.changeClear(state.email);
                                },
                                error: state.validateError?.errors.emailErrors?.first,
                              ),
                              AppHorizontalField(
                                label: 'Site address',
                                controller: state.siteAddress,
                                changeClear: () {
                                  state.changeClear(state.siteAddress);
                                },
                                // error: state.validateError?.errors.emailErrors?.first,
                              ),
                              SettingsInput(
                                  title: "Schedule",
                                  onPress: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider.value(
                                          value: read,
                                          child:  const SettingSchedule(),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "School category",
                                  onPress: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider.value(
                                          value: read,
                                          child: const SettingsSelectCategory(),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "Address",
                                  onPress: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider.value(
                                          value: read,
                                          child: const SettingsAddress(),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                            title: 'Save changes',
                            onPressed: () {
                              state.saveGeneralInfo();
                            }
                          ),
                        )
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
