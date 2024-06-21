import 'package:european_university_app/app/ui/screens/auth/widgets/already_account.dart';
import 'package:european_university_app/app/ui/screens/auth/widgets/check_box_auth.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/states/auth_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/arrow_back.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';
import '../../widgets/auth_title.dart';
import '../../widgets/custom_scroll_physics.dart';
import '../../widgets/select_date_input.dart';
import '../../widgets/select_input.dart';

class AuthSignUpTeacher extends StatefulWidget {
  const AuthSignUpTeacher({Key? key}) : super(key: key);

  @override
  State<AuthSignUpTeacher> createState() => _AuthSignUpTeacherState();
}

class _AuthSignUpTeacherState extends State<AuthSignUpTeacher> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();
    return Scaffold(
      backgroundColor: AppColors.registerBg,
      body: SafeArea(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                onHorizontalDragUpdate: (details){
                  if(details.delta.dx > 30){
                    state.clear();
                    Navigator.pop(context);
                  }
                },
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
                          getConstant('SIGN_UP'),
                          style: TextStyles.s24w600.copyWith(
                              color: AppColors.appTitle
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BottomBouncingScrollPhysics(),
                          children: [
                            AppTitle(
                              title: getConstant('General_info'),
                            ),
                            AuthInput(
                              keyboardType: TextInputType.number,
                              controller: state.phone,
                              title: getConstant('Phone_number'),
                              errors: state.validateError?.errors.phoneErrors?.first,
                            ),
                            AuthInput(
                              controller: state.email,
                              title: getConstant('Email_adress'),
                              errors: state.validateError?.errors.emailErrors?.first,
                            ),
                            AuthInput(
                              controller: state.password,
                              title: getConstant('Password'),
                              isPass: true,
                              errors: state.validateError?.errors.passwordErrors?.first,
                            ),
                            AuthInput(
                              controller: state.confirmPassword,
                              title: getConstant('Confirm_password'),
                              isPass: true,
                              isBottomPadding: false,
                            ),
                            AppTitle(
                              title: getConstant('Personal_info'),
                            ),
                            AuthInput(
                              controller: state.firstName,
                              title: getConstant('First_name'),
                              errors: state.validateError?.errors.firstNameErrors?.first,
                            ),
                            AuthInput(
                              controller: state.surname,
                              title: getConstant('Surname'),
                              errors: state.validateError?.errors.surnameErrors?.first,
                            ),
                            SelectInput(
                                errors: state.validateError?.errors.genderErrors?.first,
                                title: getConstant('Gender'),
                                hintText: getConstant('Choose_your_gender'),
                                items: state.listGender(),
                                selected: state.gender,
                                onSelect: (index) {
                                  state.changeGander(index);
                                }
                            ),
                            SelectDateInput(
                              onChange: (DateTime? date) {
                                state.changeDateBirth(date);
                              },
                              errors: state.validateError?.errors.dateBirthErrors?.first,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const CheckboxAuth(),
                            const SizedBox(
                              height: 40,
                            ),
                            AppButton(
                              title: getConstant('SIGN_UP'),
                              onPressed: () {
                                if(!state.isLoading) {
                                  state.signUpTeacher(sendCode: true);
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
                ),
              ),
              Positioned(
                top: 16,
                left: 0,
                child: ArrowBack(
                  onArrowBack: () {
                    state.clear();
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}
