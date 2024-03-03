import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/widgets/arrow_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';

class ConfirmPasswordRecovery extends StatefulWidget {
  const ConfirmPasswordRecovery({Key? key}) : super(key: key);

  @override
  State<ConfirmPasswordRecovery> createState() => _ConfirmPasswordRecoveryState();
}

class _ConfirmPasswordRecoveryState extends State<ConfirmPasswordRecovery> {
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
                          'Password recovery',
                          style: TextStyles.s24w600.copyWith(
                              color: Colors.white
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
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyles.s14w600.copyWith(
                                        color: Colors.white,
                                        height: 1.57
                                    ),
                                    text: "Please enter the password\nreset code sent to the email\n",
                                    children: [
                                      TextSpan(
                                          text: "${state.email.text} ",
                                          style: TextStyles.s14w400.copyWith(
                                              color: const Color(0xFFFFC700)
                                          )
                                      )
                                    ]
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AuthInput(
                              keyboardType: TextInputType.number,
                              controller: state.code,
                              title: 'Code',
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            AppButton(
                              title: 'Continue',
                              onPressed: () {
                                state.confirmCode();
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
