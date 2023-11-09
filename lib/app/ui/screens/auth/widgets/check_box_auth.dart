import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/states/auth_state.dart';
import '../../../theme/text_styles.dart';

class CheckboxAuth extends StatefulWidget {
  const CheckboxAuth({Key? key}) : super(key: key);

  @override
  State<CheckboxAuth> createState() => _CheckboxAuthState();
}

class _CheckboxAuthState extends State<CheckboxAuth> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();
    final isActivePrivacy = state.isActivePrivacy;
    final error = state.validateError?.errors.privacyErrors?.first;

    return CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: const Color(0xFF848484)
                  ),
                  color: isActivePrivacy ? const Color(0xFF848484) : null
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Container(
              constraints: const BoxConstraints(
                  maxWidth: 270
              ),
              child: Text(
                'I have read and agree to the  privacy policy, '
                    'terms of service, and community guidlines',
                style: TextStyles.s10w600.copyWith(
                    color: error != null ? const Color(0xFFFFC700) : Colors.white,
                    letterSpacing: 0.0
                ),
              ),
            )
          ],
        ),
        onPressed: () {
          state.changeActivePrivacy();
        }
    );
  }
}