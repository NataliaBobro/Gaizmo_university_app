import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../resources/resources.dart';

class ServicesHeader extends StatelessWidget {
  const ServicesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              top: 16,
              bottom: 24
            ),
            child: Text(
                'Services',
              style: TextStyles.s24w700.copyWith(
                color: const Color(0xFF242424)
              ),
            ),
          ),
          Row(
            children: [
              CupertinoButton(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 20,
                  right: 12
                ),
                child: SvgPicture.asset(
                  Svgs.search
                ),
                onPressed: () {},
              ),
              CupertinoButton(
                padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 12,
                    right: 24
                ),
                child: SvgPicture.asset(
                    Svgs.menu
                ),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
