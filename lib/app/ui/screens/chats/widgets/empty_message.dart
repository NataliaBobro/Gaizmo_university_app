import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../resources/resources.dart';
import '../../../theme/app_colors.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            SvgPicture.asset(
              Svgs.message,
              width: 150,
              color: AppColors.accentSoft,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              getConstant('Empty_chats'),
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF858484)
              ),
            )
          ],
        )
      ],
    );
  }
}
