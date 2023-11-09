import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../theme/text_styles.dart';

class AlreadyAccount extends StatelessWidget {
  const AlreadyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Already  have an account ? ',
          style: TextStyles.s14w600.copyWith(
              color: Colors.white
          ),
          children: [
            TextSpan(
              text: 'Get started!',
              style: TextStyles.s14w600.copyWith(
                  color: const Color(0xFFFFC700)
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {

                },
            )
          ]
      ),
    );
  }
}
