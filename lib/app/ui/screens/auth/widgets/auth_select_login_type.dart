import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/resources.dart';
import '../../../theme/app_colors.dart';

class AuthSelectLoginType extends StatefulWidget {
  const AuthSelectLoginType({Key? key}) : super(key: key);

  @override
  State<AuthSelectLoginType> createState() => _AuthSelectLoginTypeState();
}

class _AuthSelectLoginTypeState extends State<AuthSelectLoginType> {
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
                AppButton(
                    title: 'Sign in',
                    onPressed: () {
                      read.openSignIn();
                    }
                ),
                const SizedBox(
                  height: 8,
                ),
                AppButton(
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
                  height: 24,
                ),
                const SelectLangButton(),
                const SizedBox(
                  height: 24,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SelectLangButton extends StatefulWidget {
  const SelectLangButton({Key? key}) : super(key: key);

  @override
  State<SelectLangButton> createState() => _SelectLangButtonState();
}

class _SelectLangButtonState extends State<SelectLangButton> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 12
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SvgPicture.asset(
                    '${state.languageList()[state.selectLang]['icon']}',
                    width: 24,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '${state.languageList()[state.selectLang]['name']}',
                  style: TextStyles.s12w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                )
              ],
            ),
          ),
          onPressed: () {
            state.openShowBottomSelectLang();
          }
      ),
    );
  }
}

class SelectLangBottomSheet extends StatelessWidget {
  const SelectLangBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<AuthState>();
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 14
            ),
            child: Text(
              'Languages',
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF848484)
              ),
            ),
          ),
          ...List.generate(
              state.languageList().length,
                  (index) => CupertinoButton(
                minSize: 0.0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  state.changeLang(index);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: state.selectLang == index ?
                  const Color.fromRGBO(36, 36, 36, 0.30) :
                  null,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SvgPicture.asset(
                          '${state.languageList()[index]['icon']}',
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${state.languageList()[index]['name']}',
                        style: TextStyles.s12w600.copyWith(
                            color: const Color(0xFF242424)
                        ),
                      )
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
