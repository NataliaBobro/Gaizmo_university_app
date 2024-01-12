import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/ui/widgets/app_horizontal_field.dart';
import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:etm_crm/app/ui/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../domain/services/user_service.dart';
import '../utils/show_message.dart';
import 'auth_button.dart';

class SettingGeneralInfo extends StatefulWidget {
  const SettingGeneralInfo({
    Key? key,
    required this.userData
  }) : super(key: key);

  final UserData? userData;

  @override
  State<SettingGeneralInfo> createState() => _SettingGeneralInfoState();
}

class _SettingGeneralInfoState extends State<SettingGeneralInfo> {
  ValidateError? validateError;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController siteAddress = TextEditingController();
  final MaskedTextController phone = MaskedTextController(
      mask: '+00 (000) 000 00 00'
  );

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    if(widget.userData?.school?.name != null){
      name.text = "${widget.userData?.school?.name}";
    }
    if(widget.userData?.phone != null){
      phone.text = "${widget.userData?.phone}";
    }
    if(widget.userData?.email != null){
      email.text = "${widget.userData?.email}";
    }
    if(widget.userData?.school?.siteName != null){
      siteAddress.text = "${widget.userData?.school?.siteName}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeaderWithAction(
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
                                controller: name,
                                changeClear: () {
                                  name.clear();
                                  setState(() {});
                                },
                                error: validateError?.errors.schoolName?.first,
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
                                label: 'Site address',
                                controller: siteAddress,
                                changeClear: () {
                                  siteAddress.clear();
                                  setState(() {});
                                },
                                // error: state.validateError?.errors.emailErrors?.first,
                              ),
                              // SettingsInput(
                              //     title: "Schedule",
                              //     onPress: () async {
                              //       await Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => ChangeNotifierProvider.value(
                              //             value: read,
                              //             child:  const SettingSchedule(),
                              //           ),
                              //         ),
                              //       );
                              //     }
                              // ),
                              // SettingsInput(
                              //     title: "School category",
                              //     onPress: () async {
                              //       await Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => ChangeNotifierProvider.value(
                              //             value: read,
                              //             child: const SettingsSelectCategory(),
                              //           ),
                              //         ),
                              //       );
                              //     }
                              // ),
                              // SettingsInput(
                              //     title: "Address",
                              //     onPress: () async {
                              //       await Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => ChangeNotifierProvider.value(
                              //             value: read,
                              //             child: const SettingsAddress(),
                              //           ),
                              //         ),
                              //       );
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
      final result = await UserService.changeGeneralInfo(
          context,
          widget.userData?.id,
          name.text,
          phone.text,
          email.text,
          siteAddress.text
      );
      if(result == true){
        widget.userData?.school?.name =  name.text;
        widget.userData?.phone =  phone.text;
        widget.userData?.email =  email.text;
        widget.userData?.school?.siteName =  siteAddress.text;
        close();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        validateError = ValidateError.fromJson(data);
        showMessage('${validateError?.message}', color: const Color(0xFFFFC700));
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

}
