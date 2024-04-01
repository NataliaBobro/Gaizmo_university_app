import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/resources.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    Key? key,
    this.onArrowBack
  }) : super(key: key);

  final Function? onArrowBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoButton(
            minSize: 0.0,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SvgPicture.asset(
              Svgs.back,
              color: AppColors.appButton,
            ),
            onPressed: () {
              if(onArrowBack != null){
                onArrowBack!();
              }
              Navigator.pop(context);
            }
        )
      ],
    );
  }
}
