import 'package:dio/dio.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/settings/setting_salary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/show_message.dart';
import '../../../../../widgets/app_horizontal_field.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../../widgets/settings/settings_address.dart';
import '../../../../../widgets/settings/settings_date_birth.dart';
import '../../../../../widgets/settings/settings_gender.dart';
import '../../../../../widgets/settings/settings_schedule.dart';
import '../../../../../widgets/settings_input.dart';
import '../../../../../widgets/snackbars.dart';


class PersonalInfoTeacher extends StatefulWidget {
  const PersonalInfoTeacher({
    Key? key,
    required this.student
  }) : super(key: key);

  final UserData? student;

  @override
  State<PersonalInfoTeacher> createState() => _PersonalInfoTeacherState();
}

class _PersonalInfoTeacherState extends State<PersonalInfoTeacher> {
  ValidateError? validateError;
  bool? loadingSearch;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController about = TextEditingController();

  final MaskedTextController phone = MaskedTextController(
      mask: '+00 (000) 000 00 00'
  );
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    fullName.text = '${widget.student?.firstName} ${widget.student?.lastName}';
    phone.text = '${widget.student?.phone}';
    email.text = '${widget.student?.email}';
    if(widget.student?.about != null) {
      about.text = '${widget.student?.about}';
    }
  }

  String? openField;

  void changeOpen(value){
    if(openField == value){
      openField = null;
    }else{
      openField = value;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
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
                                label: 'Full name',
                                controller: fullName,
                                changeClear: () {
                                  fullName.clear();
                                  setState(() {});
                                },
                                error: validateError?.errors.fullNameErrors?.first,
                              ),
                              AppHorizontalField(
                                label: 'Phone number',
                                controller: phone,
                                changeClear: () {
                                  phone.clear();
                                  setState(() {});
                                },
                                error: validateError?.errors.phoneErrors?.first,
                              ),
                              AppHorizontalField(
                                label: 'E-mail',
                                controller: email,
                                changeClear: () {
                                  email.clear();
                                  setState(() {});
                                },
                                error: validateError?.errors.emailErrors?.first,
                              ),
                              AppHorizontalField(
                                label: 'About me',
                                controller: about,
                                changeClear: () {
                                  about.clear();
                                  setState(() {});
                                },
                                error: validateError?.errors.about?.first,
                              ),
                              SettingsInput(
                                  title: "Date of birth",
                                  onPress: () async {
                                    appState.openPage(
                                      context,
                                      SettingsDateBirth(
                                        user: appState.userData,
                                      )
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "Gender",
                                  onPress: () async {
                                    appState.openPage(
                                      context,
                                        SettingsGender(
                                          user: appState.userData,
                                        )
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "Address",
                                  onPress: ()  {
                                    appState.openPage(
                                        context,
                                        SettingsAddress(
                                          user: appState.userData,
                                        )
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "Schedule",
                                  onPress: () async {
                                    appState.openPage(
                                        context,
                                        SettingSchedule(
                                          user: appState.userData,
                                          onUpdate: () {
                                            appState.getUser();
                                          },
                                        )
                                    );
                                  }
                              ),
                              SettingsInput(
                                  title: "Salary",
                                  onPress: ()  {
                                    appState.openPage(
                                        context,
                                        SettingsSalary(
                                          user: appState.userData,
                                        )
                                    );
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
                                saveGeneralInfo();
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

  Future<void> saveGeneralInfo() async {
    try {
      // final result = await UserService.changeGeneralInfoStudent(
      //   context,
      //   widget.student?.id,
      //   fullName.text,
      //   phone.text,
      //   email.text,
      //   about.text
      // );
      // if(result == true){
      //   updateUser();
      //   close();
      // }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        validateError = ValidateError.fromJson(data);
        showMessage('${validateError?.message}', color: AppColors.appButton);
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      setState(() {});
    }
  }

  void close() {
    Navigator.pop(context);
  }

  void updateUser() {
    context.read<AppState>().getUser();
  }
}
