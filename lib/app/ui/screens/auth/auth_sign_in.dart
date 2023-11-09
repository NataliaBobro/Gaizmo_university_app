import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
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
                    'Sign in',
                    style: TextStyles.s24w600.copyWith(
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 157,
                ),
                AuthInput(
                  controller: state.phone,
                  title: 'Phone number',
                  hintText: '+380',
                  errors: state.validateError?.errors.phoneErrors?.first,
                ),
                AuthInput(
                  controller: state.password,
                  title: 'Password',
                  isPass: true,
                  errors: state.validateError?.errors.passwordErrors?.first,
                  isBottomPadding: false,
                  bottomLeftWidget: CupertinoButton(
                    minSize: 0.0,
                    padding: const EdgeInsets.only(
                      top: 4
                    ),
                    child: Text(
                        'Forgot the password?',
                      style: TextStyles.s12w400.copyWith(
                        color: const Color(0xFF848484)
                      ),
                    ),
                    onPressed: () {},
                  )
                ),
                const SizedBox(
                  height: 80,
                ),
                AuthButton(
                  title: 'Sign in',
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
                        text: 'Don’t have an account yet? ',
                        style: TextStyles.s14w600.copyWith(
                            color: Colors.white
                        ),
                        children: [
                          TextSpan(
                              text: 'Get started!',
                              style: TextStyles.s14w600.copyWith(
                                  color: const Color(0xFFFFC700)
                              )
                          )
                        ]
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
