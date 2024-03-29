import 'package:european_university_app/app/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../domain/services/staff_service.dart';
import '../../theme/text_styles.dart';
import '../../utils/get_constant.dart';
import '../auth_button.dart';
import '../center_header.dart';
import '../select_input.dart';

class SettingsGender extends StatefulWidget {
  const SettingsGender({
    Key? key,
    required this.user
  }) : super(key: key);

  final UserData? user;

  @override
  State<SettingsGender> createState() => _SettingsGenderState();
}

class _SettingsGenderState extends State<SettingsGender> {
  String? value;
  int gender = -1;

  @override
  void initState() {
    gender = widget.user?.gender ?? -1;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final listGender = context.watch<AppState>().metaAppData?.genders ?? [];
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
                              SelectInput(
                                // errors: state.validateError?.errors.genderErrors?.first,
                                title: getConstant('Gender'),
                                hintText: '',
                                hintStyle: TextStyles.s14w400.copyWith(
                                    color: const Color(0xFF848484)
                                ),
                                items: listGender.map((e) => e.name).toList(),
                                selected: gender,
                                labelStyle: TextStyles.s14w600.copyWith(
                                    color: const Color(0xFF242424)
                                ),
                                onSelect: (index) {
                                  setState(() {
                                    gender = index;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: getConstant('SAVE_CHANGES'),
                              onPressed: () {
                                saveGender(gender);
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

  Future<void> saveGender(int? gender) async {
    try{
      final result = await StaffService.saveGender(
          context,
          widget.user?.id,
          {
            'gender': gender,
          }
      );
      if(result == true){
        widget.user?.gender = gender;
        setState(() {});
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
