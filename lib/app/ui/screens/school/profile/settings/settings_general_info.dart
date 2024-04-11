import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/screens/school/profile/settings/settings_address.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/settings/settings_schedule.dart';
import 'package:european_university_app/app/ui/screens/school/profile/settings/settings_select_category.dart';
import 'package:european_university_app/app/ui/widgets/app_horizontal_field.dart';
import 'package:european_university_app/app/ui/widgets/center_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/school/school_profile_state.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/modal/delete_account_modal.dart';
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
    final addState = context.read<AppState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('Settings')
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
                                label: getConstant('Name_of_school'),
                                controller: state.nameSchool,
                                changeClear: () {
                                  state.changeClear(state.nameSchool);
                                },
                                error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                keyboardType: TextInputType.number,
                                label: getConstant('Phone_number'),
                                controller: state.phone,
                                changeClear: () {
                                  state.changeClear(state.phone);
                                },
                                error: state.validateError?.errors.phoneErrors?.first,
                              ),
                              AppHorizontalField(
                                label: getConstant('Email'),
                                controller: state.email,
                                changeClear: () {
                                  state.changeClear(state.email);
                                },
                                error: state.validateError?.errors.emailErrors?.first,
                              ),
                              AppHorizontalField(
                                label: getConstant('Site_address'),
                                controller: state.siteAddress,
                                changeClear: () {
                                  state.changeClear(state.siteAddress);
                                },
                                // error: state.validateError?.errors.emailErrors?.first,
                              ),
                              SettingsInput(
                                  title: getConstant('Schedule'),
                                  onPress: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider.value(
                                          value: read,
                                          child:  SettingSchedule(
                                            user: addState.userData,
                                            onUpdate: () {
                                              addState.getUser();
                                            }
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: getConstant('School_category'),
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
                                  title: getConstant('Address'),
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
                              SettingsInput(
                                  title: getConstant('Delete_account'),
                                  onPress: () {
                                    showDeleteDialog(context, () {
                                      Navigator.pop(context);
                                      context.read<AppState>().deleteAccount();
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                            title: getConstant('SAVE_CHANGES'),
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
