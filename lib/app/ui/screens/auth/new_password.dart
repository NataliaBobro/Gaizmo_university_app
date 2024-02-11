import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/widgets/arrow_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();
    return Scaffold(
        backgroundColor: AppColors.registerBg,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
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
                    const SizedBox(
                      height: 157,
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
                            text: "New Password Setup"
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AuthInput(
                      controller: state.password,
                      title: 'New password',
                      isPass: true,
                      errors: state.validateError?.errors.passwordErrors?.first,
                    ),
                    AuthInput(
                      controller: state.confirmPassword,
                      title: 'Confirm password',
                      isPass: true,
                      errors: state.validateError?.errors.confirmPassword?.first,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    AppButton(
                      title: 'Continue',
                      onPressed: () {
                        state.setNewPass();
                      },
                      horizontalPadding: 16.0,
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 16,
                left: 0,
                child: ArrowBack(),
              )
            ],
          ),
        )
    );
  }
}
