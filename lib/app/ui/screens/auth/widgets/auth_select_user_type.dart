import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/resources.dart';
import '../../../../domain/states/auth_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/arrow_back.dart';
import '../../../widgets/auth_button.dart';

class AuthSelectUserType extends StatefulWidget {
  const AuthSelectUserType({Key? key}) : super(key: key);

  @override
  State<AuthSelectUserType> createState() => _AuthSelectUserTypeState();
}

class _AuthSelectUserTypeState extends State<AuthSelectUserType> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();
    final read = context.read<AuthState>();
    return Scaffold(
      backgroundColor: AppColors.registerBg,
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: (details){
            if(details.delta.dx > 20){
              state.clear();
              Navigator.pop(context);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const ArrowBack(),
                  const SizedBox(
                    height: 138,
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
                      title: getConstant('IM_STUDENT'),
                      icon: Svgs.student,
                      onPressed: () {
                        read.changeUserType(3);
                      }
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppButton(
                      title: getConstant('School'),
                      icon: Svgs.schoolColor,
                      onPressed: () {
                        read.changeUserType(1);
                      }
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppButton(
                      title: getConstant('Teacher'),
                      icon: Svgs.teacher,
                      onPressed: () {
                        read.changeUserType(2);
                      }
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    '',
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
      ),
    );
  }
}
