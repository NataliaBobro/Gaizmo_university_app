import 'package:european_university_app/app/domain/states/auth_state.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/text_styles.dart';

class AlreadyAccount extends StatelessWidget {
  const AlreadyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: getConstant('Already_have_an_account'),
          style: TextStyles.s14w600.copyWith(
              color: AppColors.appTitle
          ),
          children: [
            TextSpan(
              text: ' ${getConstant('auth')}',
              style: TextStyles.s14w600.copyWith(
                  color: AppColors.appButton
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.read<AuthState>().openSignIn();
                },
            )
          ]
      ),
    );
  }
}
