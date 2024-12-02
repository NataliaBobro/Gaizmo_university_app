import 'package:european_university_app/app/domain/states/auth_state.dart';
import 'package:european_university_app/app/ui/screens/auth/password_recovery.dart';
import 'package:european_university_app/app/ui/widgets/arrow_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../utils/get_constant.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';

class AuthSignIn extends StatefulWidget {
  const AuthSignIn({Key? key}) : super(key: key);

  @override
  State<AuthSignIn> createState() => _AuthSignInState();
}

class _AuthSignInState extends State<AuthSignIn> {
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
                  if(details.delta.dx > 20){
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          getConstant('SIGN_IN'),
                          style: TextStyles.s24w600.copyWith(
                              color: AppColors.appTitle
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 157,
                            ),
                            AuthInput(
                              keyboardType: TextInputType.emailAddress,
                              controller: state.email,
                              title: getConstant('Email'),
                              errors: state.validateError?.errors.emailErrors?.first,
                            ),
                            AuthInput(
                                controller: state.password,
                                title: getConstant('Password'),
                                isPass: true,
                                errors: state.validateError?.errors.passwordErrors?.first,
                                isBottomPadding: false,
                                bottomLeftWidget: CupertinoButton(
                                  minSize: 0.0,
                                  padding: const EdgeInsets.only(
                                      top: 4
                                  ),
                                  child: Text(
                                    getConstant('Forgot_the_password'),
                                    style: TextStyles.s12w400.copyWith(
                                        color: const Color(0xFF848484)
                                    ),
                                  ),
                                  onPressed: () {
                                    state.pageOpen(
                                        const PasswordRecovery()
                                    );
                                  },
                                )
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            AppButton(
                              title: getConstant('SIGN_IN'),
                              onPressed: () {
                                if(!state.isLoading) {
                                  state.signIn();
                                }
                              },
                              horizontalPadding: 16.0,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: '${getConstant('Dont_have_an_account_yet')} ',
                                    style: TextStyles.s14w600.copyWith(
                                        color: AppColors.appTitle
                                    ),
                                    children: [
                                      TextSpan(
                                        text: getConstant('Get_started'),
                                        style: TextStyles.s14w600.copyWith(
                                            color: AppColors.appButton
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.read<AuthState>().openSelectUserType();
                                          },
                                      )
                                    ]
                                ),
                              ),
                            )
                          ],
                        ),
                      )
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
          ),
        )
    );
  }
}
