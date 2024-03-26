import 'package:dio/dio.dart';
import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:etm_crm/app/ui/widgets/modal/delete_account_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/services/app_ninjas_service.dart';
import '../../../../../../domain/services/user_service.dart';
import '../../../../../theme/text_styles.dart';
import '../../../../../utils/show_message.dart';
import '../../../../../widgets/app_horizontal_field.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../../widgets/select_input_search_field.dart';
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
  Map<String, dynamic>? _country;
  Map<String, dynamic>? _city;
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
    if(widget.student?.country != null){
      _country = {
        "id": "1",
        "name": widget.student?.country,
      };
    }
    if(widget.student?.city != null){
      _city = {
        "id": "1",
        "name": widget.student?.city,
      };
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

  List<Map<String, dynamic>>? countryList = [];
  final List<Map<String, dynamic>> listDefaultCountry = [
    {
      "id": "1",
      "name": "Ukraine",
      "iso2": "UA"
    },
    {
      "id": "2",
      "name": "Poland",
      "iso2": "PL"
    },
    {
      "id": "3",
      "name": "Austria",
      "iso2": "AT"
    },
    {
      "id": "3",
      "name": "Germany",
      "iso2": "DE"
    },
  ];

  List<Map<String, dynamic>> cityList = [];

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
                    CenterHeaderWithAction(
                        title: getConstant('Settings')
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
                          AppHorizontalField(
                            label: getConstant('About_me'),
                            controller: about,
                            changeClear: () {
                              about.clear();
                              setState(() {});
                            },
                            error: validateError?.errors.about?.first,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24
                            ),
                            child: Column(
                              children: [
                                SelectInputSearchField(
                                  titleStyle: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF848484)
                                  ),
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF242424)
                                  ),
                                  errors: validateError?.errors.country?.first,
                                  title: getConstant('Country'),
                                  items:  (countryList?.length ?? 0) > 0 ?
                                  countryList : listDefaultCountry,
                                  selected: _country,
                                  onSelect: (value) {
                                    _country = value;
                                    changeOpen(null);
                                  },
                                  onSearch: (value) {
                                    searchCountry(value);
                                  },
                                  changeOpen: () {
                                    changeOpen('country');
                                  },
                                  isOpen: openField == 'country',
                                  hintText: '',
                                ),
                                SelectInputSearchField(
                                  titleStyle: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF848484)
                                  ),
                                  style: TextStyles.s14w400.copyWith(
                                      color: const Color(0xFF242424)
                                  ),
                                  errors: validateError?.errors.city?.first,
                                  title: getConstant('City'),
                                  items: cityList,
                                  onSearch: (value) {
                                    searchCity(value);
                                  },
                                  selected: _city,
                                  changeOpen: () {
                                    changeOpen('city');
                                  },
                                  isOpen: openField == 'city',
                                  onSelect: (index) {
                                    _city = index;
                                    changeOpen(null);
                                  },
                                  hintText: '',
                                ),
                              ],
                            ),
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
                          SettingsInput(
                              title: getConstant('Show_in_profile'),
                              onPress: () {

                              }
                          ),
                          SettingsInput(
                            title: getConstant('Delete_account'),
                            onPress: () {
                              showDeleteDialog(context);
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
          _country?['name'],
          _city?['name'],
      );
      if(result == true){
       updateUser();
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

  void updateUser() {
    context.read<AppState>().getUser();
  }

  Future<void> searchCountry(String? value) async {
    if((value?.length ?? 0) < 2) return;
    loadingSearch = true;
    setState(() {});
    try {
      final result = await AppNinjasService.getCountry(value);
      if (result != null) {
        List<Map<String, dynamic>>? list = [];
        for(var a = 0; a < result.length; a++){
          list.add({
            'name': result[a]['name'],
            'iso2': result[a]['iso2']
          });
        }
        countryList = list;
      }
    } finally {
      loadingSearch = false;
      setState(() {});
    }
  }

  Future<void> searchCity(String? value) async {
    if((value?.length ?? 0) < 2) return;
    loadingSearch = true;
    setState(() {});
    try {
      final result = await AppNinjasService.getCity(value, _country);
      if(result != null){
        List<Map<String, dynamic>>? list = [];
        for(var a = 0; a < result.length; a++){
          list.add({
            'name': result[a]['name']
          });
        }
        cityList = list;
      }
    } finally {
      loadingSearch = false;
      setState(() {});
    }
  }
}
