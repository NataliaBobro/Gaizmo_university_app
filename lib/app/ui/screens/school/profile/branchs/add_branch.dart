import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:etm_crm/app/domain/services/school_service.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:etm_crm/app/ui/widgets/add_schedule.dart';
import 'package:etm_crm/app/ui/widgets/app_horizontal_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../../app.dart';
import '../../../../utils/show_message.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/select_school_category.dart';
import '../widgets/settings_tab.dart';

class AddBranch extends StatefulWidget {
  const AddBranch({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final Function onAdd;

  @override
  State<AddBranch> createState() => _AddBranchState();
}

class _AddBranchState extends State<AddBranch> {
  ValidateError? validateError;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController site = TextEditingController();
  MaskedTextController phone = MaskedTextController(mask: '+00 (000) 000 00 00', text: '+38 (0');
  List<int> listWorkDay = [];
  MaskedTextController scheduleFrom = MaskedTextController(
      mask: '00 : 00'
  );
  MaskedTextController scheduleTo = MaskedTextController(
      mask: '00 : 00'
  );
  Map<String, dynamic>? schoolCategory;


  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('Add_branch')
                ),
                Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        AppHorizontalField(
                          label: getConstant('Name_of_school'),
                          controller: name,
                          changeClear: () {
                            name.clear();
                            setState(() {});
                          },
                          error: validateError?.errors.schoolName?.first,
                        ),
                        AppHorizontalField(
                            error: validateError?.errors.phoneErrors?.first,
                            label: getConstant('Phone_number'),
                            controller: phone,
                            changeClear: () {
                              phone.clear();
                              setState(() {});
                            }
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
                            label: getConstant('Site_address'),
                            controller: site,
                            changeClear: () {
                              site.clear();
                              setState(() {});
                            },
                        ),
                        SettingsInput(
                            title: getConstant('Schedule'),
                            info: renderScheduleInfo(),
                            onPress: () async {
                              appState.openPage(
                                  context,
                                  AddSchedule(
                                    selectedDay: listWorkDay,
                                    to: scheduleTo,
                                    from: scheduleFrom,
                                    onSelect: (newWork) {
                                      listWorkDay = newWork;
                                      setState(() {});
                                    }
                                  )
                              );
                            }
                        ),
                        SettingsInput(
                            title: getConstant('School_category'),
                            info: schoolCategory != null ? schoolCategory!['name'] : null,
                            onPress: () async {
                              appState.openPage(
                                  context,
                                  SelectSchoolCategory(
                                    selected: schoolCategory,
                                    onSelect: (value) {
                                      schoolCategory = value;
                                      setState(() {});
                                    }
                                  )
                              );
                            }
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AppButton(
                      title: 'Save changes',
                      onPressed: () {
                        addBranch();
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  String renderScheduleInfo(){
    List<String> listDay = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    List<String> selectedDays = listWorkDay.map((index) => listDay[index]).toList();
    String result = selectedDays.join(', ');
    return '$result ${scheduleFrom.text}-${scheduleTo.text}';
  }

  Future<void> addBranch() async {
    validateError = null;
    setState(() {});
    try{
      final result = await SchoolService.addBranch(
          context,
          {
            "school_name": name.text,
            "phone": phone.text,
            "email": email.text,
            "site_address": site.text,
            "work_day": listWorkDay,
            "schedule_to": scheduleTo.text,
            "schedule_from": scheduleFrom.text,
            "school_category": schoolCategory?['id']
          }
      );
      if(result == true){
        widget.onAdd();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        validateError = ValidateError.fromJson(data);
        setState(() {});
        showMessage('${validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    }catch(e){
      print(e);
    }
  }
}
