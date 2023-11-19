import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/screens/auth/widgets/already_account.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_title.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';
import '../../widgets/cart_number.dart';
import '../../widgets/select_date_input.dart';
import '../../widgets/select_input.dart';
import 'auth_sign_up_school.dart';

class AuthSignUpStudent extends StatefulWidget {
  const AuthSignUpStudent({Key? key}) : super(key: key);

  @override
  State<AuthSignUpStudent> createState() => _AuthSignUpStudentState();
}

class _AuthSignUpStudentState extends State<AuthSignUpStudent> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();
    return Scaffold(
      backgroundColor: AppColors.registerBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Sign up',
                  style: TextStyles.s24w600.copyWith(
                      color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BottomBouncingScrollPhysics(),
                  children: [
                    const AuthTitle(
                      title: 'General info *',
                    ),
                    AuthInput(
                      controller: state.phone,
                      title: 'Phone number',
                      hintText: '+380',
                      errors: state.validateError?.errors.phoneErrors?.first,
                    ),
                    AuthInput(
                      controller: state.email,
                      title: 'E-mail address',
                      errors: state.validateError?.errors.emailErrors?.first,
                    ),
                    AuthInput(
                      controller: state.password,
                      title: 'Password',
                      isPass: true,
                      errors: state.validateError?.errors.passwordErrors?.first,
                    ),
                    AuthInput(
                      controller: state.confirmPassword,
                      title: 'Confirm password',
                      isPass: true,
                      isBottomPadding: false,
                    ),
                    const AuthTitle(
                      title: 'Personal info *',
                    ),
                    AuthInput(
                      controller: state.firstName,
                      title: 'First name',
                      errors: state.validateError?.errors.firstNameErrors?.first,
                    ),
                    AuthInput(
                      controller: state.lastName,
                      title: 'Middle name',
                      errors: state.validateError?.errors.lastNameErrors?.first,
                    ),
                    AuthInput(
                      controller: state.surname,
                      title: 'Surname',
                      errors: state.validateError?.errors.surnameErrors?.first,
                    ),
                    SelectInput(
                      errors: state.validateError?.errors.genderErrors?.first,
                      title: 'Gender',
                      hintText: 'Choose your gender',
                      items: state.listGender(),
                      selected: state.gender,
                      onSelect: (index) {
                        state.changeGander(index);
                      }
                    ),
                    SelectDateInput(
                      onChange: (day, mon, year) {
                        if(day != null && mon != null && year != null){
                          state.changeDateBirth('$day.$mon.$year');
                        }
                      },
                      errors: state.validateError?.errors.dateBirthErrors?.first,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const AuthTitle(
                      title: 'Payment info',
                    ),
                    CartNumber(
                      controllerNumberCart: state.controllerNumberCart,
                      controllerDateCart: state.controllerDateCart,
                      controllerCodeCart: state.controllerCodeCart,
                      errorsCode: state.validateError?.errors.paymentCodeErrors?.first,
                      errorsNumber: state.validateError?.errors.paymentNumberErrors?.first,
                      errorsDate: state.validateError?.errors.paymentDateErrors?.first,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const CheckboxAuth(),
                    const SizedBox(
                      height: 40,
                    ),
                    AppButton(
                      title: 'Sign up',
                      onPressed: () {
                        if(!state.isLoading) {
                          state.signUp('student');
                        }
                      },
                      horizontalPadding: 16.0,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const AlreadyAccount()
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}


