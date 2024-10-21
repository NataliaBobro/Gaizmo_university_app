import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/states/school/school_staff_state.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/app_field.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../theme/text_styles.dart';
import '../../../widgets/auth_title.dart';
import '../../../widgets/center_header.dart';
import '../../../widgets/custom_scroll_physics.dart';
import '../../../widgets/select_date_input.dart';
import '../../../widgets/select_input.dart';


class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController house = TextEditingController();
  final MaskedTextController salary = MaskedTextController(mask: '0000');
  final MaskedTextController phone = MaskedTextController(mask: '+00 (000) 000 00 00');
  final TextEditingController country = TextEditingController();
  final TextEditingController city = TextEditingController();

  DateTime? dateBirth;
  int gender = -1;

  bool loadingSearch = false;


  void changeDateBirth(DateTime? date) {
    dateBirth = date;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolStaffState>();
    final listGender = context.watch<AppState>().metaAppData?.genders ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              CenterHeaderWithAction(
                  title: getConstant('Add_staff')
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24
                  ),
                  physics: const BottomBouncingScrollPhysics(),
                  children: [
                    AppTitle(
                      title: getConstant('Personal_info'),
                    ),
                    AppField(
                      error: state.validateError?.errors.firstNameErrors?.first,
                      label: getConstant('First_name'),
                      controller: firstName,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      error: state.validateError?.errors.lastNameErrors?.first,
                      label: getConstant('Last_name'),
                      controller: lastName,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SelectInput(
                        errors: state.validateError?.errors.genderErrors?.first,
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
                    SelectDateInput(
                      errors: state.validateError?.errors.dateBirthErrors?.first,
                      labelStyle: TextStyles.s14w600.copyWith(
                          color: const Color(0xFF242424)
                      ),
                      hintStyle: TextStyles.s14w400.copyWith(
                          color: const Color(0xFF848484)
                      ),
                      onChange: (DateTime? date) {
                        changeDateBirth(date);
                      },
                      // errors: state.validateError?.errors.dateBirthErrors?.first,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      error: state.validateError?.errors.phoneErrors?.first,
                      label: getConstant('Phone_number'),
                      controller: phone,
                      placeholder: '+380',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      error: state.validateError?.errors.emailErrors?.first,
                      label: getConstant('Email'),
                      controller: email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // const AppTitle(
                    //   title: 'Teaching category',
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // SelectInput(
                    //   // errors: state.validateError?.errors.genderErrors?.first,
                    //   title: 'Category',
                    //   hintText: '',
                    //   hintStyle: TextStyles.s14w400.copyWith(
                    //       color: const Color(0xFF848484)
                    //   ),
                    //   items: listGender.map((e) => e.name).toList(),
                    //   selected: gender,
                    //   labelStyle: TextStyles.s14w600.copyWith(
                    //       color: const Color(0xFF242424)
                    //   ),
                    //   onSelect: (index) {
                    //     setState(() {
                    //       gender = index;
                    //     });
                    //   },
                    // ),
                    AppField(
                      label: '${getConstant('Salary')} / ${getConstant('hourly')}',
                      controller: salary,
                      keyboardType: TextInputType.number,
                    ),
                    AppTitle(
                      title: getConstant('Adress'),
                    ),
                    AppField(
                      label: getConstant('Country'),
                      controller: country,
                      keyboardType: TextInputType.text,
                      error: state.validateError?.errors.country?.first,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      label: getConstant('City'),
                      controller: city,
                      keyboardType: TextInputType.text,
                      error: state.validateError?.errors.city?.first,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      label: getConstant('Street'),
                      controller: street,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      label: getConstant('House'),
                      controller: house,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    AppButton(
                      title: getConstant('ADD_EMPLOYEE'),
                      onPressed: () {
                        state.addOrEditStaff(
                            firstName.text,
                            lastName.text,
                            gender,
                            dateBirth,
                            phone.text,
                            email.text,
                            country.text,
                            city.text,
                            street.text,
                            house.text,
                            salary.text
                        );
                      },
                      horizontalPadding: 16,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
