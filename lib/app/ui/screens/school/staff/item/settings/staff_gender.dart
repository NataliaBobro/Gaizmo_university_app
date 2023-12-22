import 'package:etm_crm/app/domain/states/school/school_staff_item_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../app.dart';
import '../../../../../theme/text_styles.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../../widgets/select_input.dart';

class StaffGender extends StatefulWidget {
  const StaffGender({Key? key}) : super(key: key);

  @override
  State<StaffGender> createState() => _StaffGenderState();
}

class _StaffGenderState extends State<StaffGender> {
  String? value;
  int gender = -1;

  @override
  void initState() {
    final read = context.read<SchoolStaffItemState>();
    gender = read.staff?.gender ?? -1;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final read = context.read<SchoolStaffItemState>();
    final listGender = context.watch<AppState>().metaAppData?.genders ?? [];
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24
                            ),
                            physics: const ClampingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 24,
                              ),
                              SelectInput(
                                // errors: state.validateError?.errors.genderErrors?.first,
                                title: 'Choose gender',
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
                              title: 'Save changes',
                              onPressed: () {
                                read.saveGender(gender);
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
