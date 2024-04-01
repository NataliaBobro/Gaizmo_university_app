import 'package:european_university_app/app/domain/states/auth_state.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/arrow_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
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
                          getConstant('Password_recovery'),
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
                              height: 197,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50
                              ),
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyles.s14w600.copyWith(
                                        color: AppColors.appTitle,
                                        height: 1.57
                                    ),
                                    text: "${getConstant('Forgot_the_password')}\n"
                                        "${getConstant('Leave_your')} ",
                                    children: [
                                      TextSpan(
                                          text: "${getConstant('Email_adress')} ",
                                          style: TextStyles.s14w400.copyWith(
                                              color: AppColors.appButton
                                          )
                                      ),
                                      TextSpan(
                                          text: getConstant('and_we_will_help_you_recover_it')
                                      )
                                    ]
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AuthInput(
                              controller: state.email,
                              title: getConstant('Email_adress'),
                              errors: state.validateError?.errors.emailErrors?.first,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            AppButton(
                              title: getConstant('CONTINUE'),
                              onPressed: () {
                                state.sendRecoveryCode();
                              },
                              horizontalPadding: 16.0,
                            ),
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
