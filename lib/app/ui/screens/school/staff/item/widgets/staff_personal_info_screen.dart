import 'package:etm_crm/app/domain/states/school/school_staff_item_state.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/states/school/school_staff_state.dart';
import '../../../../../widgets/app_horizontal_field.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../profile/widgets/settings_tab.dart';
import '../../../../../widgets/settings/settings_date_birth.dart';
import '../../../../../widgets/settings/settings_gender.dart';
import '../../../../../widgets/settings/settings_address.dart';

class StaffPersonalInfoScreen extends StatefulWidget {
  const StaffPersonalInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StaffPersonalInfoScreen> createState() => _StaffPersonalInfoScreenState();
}

class _StaffPersonalInfoScreenState extends State<StaffPersonalInfoScreen> {
  TextEditingController fullName = TextEditingController();
  MaskedTextController phone = MaskedTextController(mask: '+00 (000) 000 00 00', text: '+38 (0');
  TextEditingController email = TextEditingController();
  TextEditingController about = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final read = context.read<SchoolStaffItemState>();
    fullName.text = '${read.staff?.firstName} ${read.staff?.lastName}';
    phone.text = '${read.staff?.phone}';
    email.text = '${read.staff?.email}';
    about.text = read.staff?.about != null ? '${read.staff?.about}' : '';
  }

  void close() {
    context.read<SchoolStaffState>().getStaff();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    fullName.clear();
    phone.clear();
    email.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final read = context.read<SchoolStaffItemState>();
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
                                label: getConstant('Full_name'),
                                controller: fullName,
                                changeClear: () {
                                  fullName.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                label: getConstant('Phone_number'),
                                controller: phone,
                                changeClear: () {
                                  phone.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                label: getConstant('Email'),
                                controller: email,
                                changeClear: () {
                                  email.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                label: getConstant('About_me'),
                                controller: about,
                                changeClear: () {
                                  about.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              SettingsInput(
                                  title: getConstant('Date_of_birth'),
                                  onPress: () async {
                                    read.openPage(
                                        SettingsDateBirth(
                                          user: read.staff,
                                        )
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: getConstant('Gender'),
                                  onPress: () async {
                                    read.openPage(
                                        SettingsGender(
                                          user: read.staff,
                                        )
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: getConstant('Adress'),
                                  onPress: ()  {
                                    read.openPage(
                                        SettingsAddress(
                                          user: read.staff,
                                        )
                                    );
                                  }
                              ),
                              // SettingsInput(
                              //     title: "Schedule",
                              //     onPress: () async {
                              //       // await Navigator.push(
                              //       //   context,
                              //       //   MaterialPageRoute(
                              //       //     builder: (context) => ChangeNotifierProvider.value(
                              //       //       value: read,
                              //       //       child: StaffPersonalInfoScreen(
                              //       //           staff: widget.staff
                              //       //       ),
                              //       //     ),
                              //       //   ),
                              //       // );
                              //     }
                              // ),
                              // SettingsInput(
                              //     title: "Salary",
                              //     onPress: () async {
                              //       // await Navigator.push(
                              //       //   context,
                              //       //   MaterialPageRoute(
                              //       //     builder: (context) => ChangeNotifierProvider.value(
                              //       //       value: read,
                              //       //       child: StaffPersonalInfoScreen(
                              //       //           staff: widget.staff
                              //       //       ),
                              //       //     ),
                              //       //   ),
                              //       // );
                              //     }
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: getConstant('SAVE_CHANGES'),
                              onPressed: () {
                                context.read<SchoolStaffItemState>().saveGeneralInfo(
                                    fullName.text, phone.text, email.text, about.text
                                );
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
