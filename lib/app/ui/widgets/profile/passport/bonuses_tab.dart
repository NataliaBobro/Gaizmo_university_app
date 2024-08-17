import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../resources/resources.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';
import '../../custom_scroll_physics.dart';

class BonusesScreen extends StatelessWidget {
  const BonusesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BonusesInfo(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
                horizontal: 24
            ),
            physics: const BottomBouncingScrollPhysics(),
            children: const [

            ],
          ),
        )
      ],
    );
  }
}

class BonusesInfo extends StatefulWidget {
  const BonusesInfo({super.key});

  @override
  State<BonusesInfo> createState() => _BonusesInfoState();
}

class _BonusesInfoState extends State<BonusesInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Svgs.present,
            width: 35,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getConstant('Collect points and get bonuses!'),
                style: TextStyles.s14w600.copyWith(
                  color: AppColors.fgDefault
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                getConstant('1 lesson = 100 points'),
                style: TextStyles.s14w400.copyWith(
                    color: AppColors.fNeutral800
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

