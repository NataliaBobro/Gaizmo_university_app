import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/resources.dart';
import '../../../theme/app_colors.dart';

class AuthSelectType extends StatefulWidget {
  const AuthSelectType({Key? key}) : super(key: key);

  @override
  State<AuthSelectType> createState() => _AuthSelectTypeState();
}

class _AuthSelectTypeState extends State<AuthSelectType> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthState>();
    return Scaffold(
      backgroundColor: AppColors.registerBg,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                const SizedBox(
                  height: 164,
                ),
                Center(
                  child: SvgPicture.asset(
                    Svgs.logo,
                    width: 162,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AuthButton(
                    title: 'Sign in',
                    onPressed: () {
                      read.openSignIn();
                    }
                ),
                const SizedBox(
                  height: 8,
                ),
                AuthButton(
                    title: 'Sign up',
                    onPressed: () {
                      read.openSelectUserType();
                    }
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                    'Get read about ETM app!',
                  style: TextStyles.s14w600.copyWith(
                    color: Colors.white
                  ),
                ),
                const SizedBox(
                  height: 62,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
