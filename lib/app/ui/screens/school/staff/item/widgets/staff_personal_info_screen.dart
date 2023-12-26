import 'package:etm_crm/app/domain/states/school/school_staff_item_state.dart';
import 'package:etm_crm/app/ui/screens/school/staff/item/settings/staff_address.dart';
import 'package:etm_crm/app/ui/screens/school/staff/item/settings/staff_date_birth.dart';
import 'package:etm_crm/app/ui/screens/school/staff/item/settings/staff_gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/states/school/school_staff_state.dart';
import '../../../../../widgets/app_horizontal_field.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../profile/widgets/settings_tab.dart';

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
    fullName.text = '${read.staff?.firstName} ${read.staff?.lastName} ${read.staff?.surname}';
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
                                label: 'Full name',
                                controller: fullName,
                                changeClear: () {
                                  fullName.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                label: 'Phone number',
                                controller: phone,
                                changeClear: () {
                                  phone.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                label: 'E-mail',
                                controller: email,
                                changeClear: () {
                                  email.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              AppHorizontalField(
                                label: 'About me',
                                controller: about,
                                changeClear: () {
                                  about.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.schoolName?.first,
                              ),
                              SettingsInput(
                                  title: "Date of birth",
                                  onPress: () async {
                                    read.openPage(
                                      const StaffDateBirth()
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "Gender",
                                  onPress: () async {
                                    read.openPage(
                                        const StaffGender()
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "Address",
                                  onPress: () async {
                                    read.openPage(
                                        const StaffAddress()
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
                              title: 'Save changes',
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
