import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class CenterHeader extends StatelessWidget {
  const CenterHeader({
    Key? key,
    required this.title,
    this.action
  }) : super(key: key);

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 8
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 16
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyles.s24w700.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16
                ),
                child: SvgPicture.asset(
                  Svgs.close,
                  width: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
          ),
          if(action != null) ...[
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: action!,
            )
          ]
        ],
      ),
    );
  }
}

class CenterHeaderWithAction extends StatelessWidget {
  const CenterHeaderWithAction({
    Key? key,
    required this.title,
    this.action,
  }) : super(key: key);

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 8
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )
      ),
      child: Container(
        width: SizerUtil.width,
        padding: const EdgeInsets.only(left: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.s24w700.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
            if(action != null) ...[
              action!
            ]
          ],
        ),
      ),
    );
  }
}
