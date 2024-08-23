import 'package:dio/dio.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/modal/delete_account_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/services/user_service.dart';
import '../../../../../theme/text_styles.dart';
import '../../../../../utils/show_message.dart';
import '../../../../../widgets/about_me_settings.dart';
import '../../../../../widgets/app_horizontal_field.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../../widgets/settings_input.dart';
import '../../../../../widgets/settings_social_accounts.dart';
import '../../../../../widgets/snackbars.dart';


class PersonalInfoStudent extends StatefulWidget {
  const PersonalInfoStudent({
    Key? key,
    required this.student
  }) : super(key: key);

  final UserData? student;

  @override
  State<PersonalInfoStudent> createState() => _PersonalInfoStudentState();
}

class _PersonalInfoStudentState extends State<PersonalInfoStudent> {
  ValidateError? validateError;
  bool? loadingSearch;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();

  final MaskedTextController phone = MaskedTextController(
      mask: '+00 (000) 000 00 00'
  );
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    fullName.text = '${widget.student?.firstName ?? ''} ${widget.student?.lastName ?? ''}';
    phone.text = widget.student?.phone ?? '';
    email.text = '${widget.student?.email}';
    country.text = widget.student?.country ?? '';
    city.text = widget.student?.city ?? '';


    if(widget.student?.about != null) {
      about.text = '${widget.student?.about}';
    }
  }

  String? openField;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Stack(
              children: [
                Column(
                  children: [
                    CenterHeader(
                        title: getConstant('Personal_info')
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(
                          bottom: 120
                        ),
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
                            error: validateError?.errors.fullNameErrors?.first,
                          ),
                          AppHorizontalField(
                            label: getConstant('Phone_number'),
                            controller: phone,
                            changeClear: () {
                              phone.clear();
                              setState(() {});
                            },
                            error: validateError?.errors.phoneErrors?.first,
                          ),
                          AppHorizontalField(
                            label: getConstant('Email'),
                            controller: email,
                            changeClear: () {
                              email.clear();
                              setState(() {});
                            },
                            error: validateError?.errors.emailErrors?.first,
                          ),
                          // AppHorizontalField(
                          //   label: getConstant('About_me'),
                          //   controller: about,
                          //   changeClear: () {
                          //     about.clear();
                          //     setState(() {});
                          //   },
                          //   error: validateError?.errors.about?.first,
                          // ),
                          SettingsInput(
                              value: Text(
                                about.text,
                                maxLines: 1,
                                style: TextStyles.s14w400.copyWith(
                                  color: const Color(0xFF242424),
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                              title: getConstant('About_me'),
                              onPress: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AboutMeSettings(
                                      user: widget.student,
                                      onSave: (aboutNew){
                                       setState(() {
                                         about.text = aboutNew;
                                       });
                                      },
                                    ),
                                  ),
                                );
                              }
                          ),
                          AppHorizontalField(
                            label: getConstant('City'),
                            controller: city,
                            changeClear: () {
                              city.clear();
                              setState(() {});
                            },
                            error: validateError?.errors.city?.first,
                          ),
                          SettingsInput(
                              title: getConstant('Social_accounts'),
                              onPress: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingsSocialAccounts(
                                      user: widget.student,
                                      onSave: (){
                                        updateUser();
                                      },
                                    ),
                                  ),
                                );
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24
                            ),
                            child: Text(
                              getConstant('Privacy_settings'),
                              style: TextStyles.s14w500.copyWith(
                                  color: const Color(0xFF242424)
                              ),
                            ),
                          ),
                          // SettingsInput(
                          //     title: getConstant('Show_in_profile'),
                          //     onPress: () {
                          //
                          //     }
                          // ),
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
                  ],
                ),

                Positioned(
                  bottom: 40,
                  right: 0,
                  left: 0,
                  child: AppButton(
                      title: getConstant('SAVE_CHANGES'),
                      onPressed: () {
                        saveGeneralInfo();
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Future<void> saveGeneralInfo() async {
    try {
      final result = await UserService.changeGeneralInfoStudent(
          context,
          widget.student?.id,
          fullName.text,
          phone.text,
          email.text,
          about.text,
          country.text,
          city.text,
      );
      if(result == true){
       updateUser();
       close();
      }
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
