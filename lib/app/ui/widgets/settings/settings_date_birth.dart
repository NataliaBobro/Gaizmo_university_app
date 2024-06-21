import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/services/staff_service.dart';
import '../../theme/text_styles.dart';
import '../auth_button.dart';
import '../center_header.dart';
import '../select_date_input.dart';

class SettingsDateBirth extends StatefulWidget {
  const SettingsDateBirth({
    Key? key,
    required this.user
  }) : super(key: key);

  final UserData? user;

  @override
  State<SettingsDateBirth> createState() => _SettingsDateBirthState();
}

class _SettingsDateBirthState extends State<SettingsDateBirth> {
  String? value;

  @override
  void initState() {
    value = widget.user?.dateBirth;
    super.initState();
  }
  void changeDateBirth(newDate){
    value = newDate;
    setState(() {});
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
                CenterHeaderWithAction(
                    title: getConstant('Settings')
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24
                            ),
                            physics: const ClampingScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              SelectDateInput(
                                dropdownColor: const Color(0xFFF0F3F6),
                                value: value,
                                labelStyle: TextStyles.s14w600.copyWith(
                                  color: const Color(0xFF242424)
                                ),
                                hintStyle: TextStyles.s14w400.copyWith(
                                    color: const Color(0xFF242424)
                                ),
                                onChange: (DateTime? date) {
                                  changeDateBirth(date);
                                },
                                // errors: state.validateError?.errors.dateBirthErrors?.first,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: getConstant('SAVE_CHANGES'),
                              onPressed: () {
                                saveDateBirth(value);
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

  Future<void> saveDateBirth(String? value) async {
    try{
      final result = await StaffService.saveBirthDate(
          context,
          widget.user?.id,
          {
            'date_birth': value,
          }
      );
      if(result == true){
        DateFormat inputFormat = DateFormat('d-MMMM-yyyy', 'en_US');
        DateTime parsedDate = inputFormat.parse('$value');
        DateFormat outputFormat = DateFormat('yyyy-MM-d', 'en_US');
        String formattedDate = outputFormat.format(parsedDate);
        widget.user?.dateBirth = formattedDate;
        back();
      }
    }catch (e){
      print(e);
    }
  }

  void back() {
    Navigator.pop(context);
  }
}
