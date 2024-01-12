import 'package:etm_crm/app/domain/states/school/school_staff_item_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/text_styles.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../../widgets/select_date_input.dart';

class StaffDateBirth extends StatefulWidget {
  const StaffDateBirth({Key? key}) : super(key: key);

  @override
  State<StaffDateBirth> createState() => _StaffDateBirthState();
}

class _StaffDateBirthState extends State<StaffDateBirth> {
  String? value;

  @override
  void initState() {
    final read = context.read<SchoolStaffItemState>();
    value = read.staff?.dateBirth;
    super.initState();
  }
  void changeDateBirth(newDate){
    value = newDate;
    setState(() {});
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
                const CenterHeaderWithAction(
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
                              const SizedBox(
                                height: 24,
                              ),
                              SelectDateInput(
                                dropdownColor: const Color(0xFFF0F3F6),
                                value: read.staff?.dateBirth,
                                labelStyle: TextStyles.s14w600.copyWith(
                                  color: const Color(0xFF242424)
                                ),
                                hintStyle: TextStyles.s14w400.copyWith(
                                    color: const Color(0xFF242424)
                                ),
                                onChange: (day, mon, year) {
                                  if(day != null && mon != null && year != null){
                                    changeDateBirth('$day-$mon-$year');
                                  }
                                },
                                // errors: state.validateError?.errors.dateBirthErrors?.first,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: 'Save changes',
                              onPressed: () {
                                read.saveDateBirth(value);
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
