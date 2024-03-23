import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
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
              color: Colors.white
          ),
          children: [
            TextSpan(
              text: ' ${getConstant('Get_started')}',
              style: TextStyles.s14w600.copyWith(
                  color: const Color(0xFFFFC700)
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
