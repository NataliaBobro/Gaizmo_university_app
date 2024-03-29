import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../domain/states/auth_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/arrow_back.dart';

class ConfirmCodeScreen extends StatefulWidget {
  const ConfirmCodeScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: const Color(0xFFFFC700), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(192, 218, 234, 1.0)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFFFFC700),),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.registerBg,
      ),
    );

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        getConstant('Verification'),
                        style: TextStyles.s24w500.copyWith(
                          color: const Color(0xFFFFC700)
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${getConstant('Enter_the_code_sent_to_the_email')} ',
                            style: TextStyles.s12w500.copyWith(
                                color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: state.email.text,
                                style: TextStyles.s12w500.copyWith(
                                    color: const Color(0xFFFFC700)
                                ),
                              )
                            ]
                          )
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Pinput(
                            autofocus: true,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) {
                              state.signUp(pin);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 170,
                      ),
                      Text(
                        getConstant('Didnt_receive_code'),
                        style: TextStyles.s14w500.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      CupertinoButton(
                        minSize: 0.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8
                        ),
                        child: Text(
                          getConstant('Resend'),
                          style: TextStyles.s14w500.copyWith(
                            color: const Color(0xFFFFC700),
                            decoration: TextDecoration.underline
                          ),
                        ),
                        onPressed: () {
                          state.sendCode(open: false);
                        }
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: ArrowBack(
                  onArrowBack: () {
                    state.clearCode();
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}
