import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../../resources/resources.dart';

class BranchHeader extends StatefulWidget {
  const BranchHeader({Key? key}) : super(key: key);

  @override
  State<BranchHeader> createState() => _BranchHeaderState();
}

class _BranchHeaderState extends State<BranchHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
                      right: 10
                  ),
                  child: SvgPicture.asset(
                      Svgs.back
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
              Text(
                getConstant('Branch'),
                style: TextStyles.s24w700.copyWith(
                    color: const Color(0xFF242424)
                ),
              ),
            ],
          ),
          Row(
            children: [
              CupertinoButton(
                  minSize: 0.0,
                  padding: const EdgeInsets.only(right: 2, left: 20, top: 4, bottom: 4),
                  child: SvgPicture.asset(
                      Svgs.share
                  ),
                  onPressed: () {}
              ),
              CupertinoButton(
                  minSize: 0.0,
                  padding: const EdgeInsets.only(right: 24, left: 2, top: 4, bottom: 4),
                  child: SvgPicture.asset(
                      Svgs.notify
                  ),
                  onPressed: () {}
              ),
            ],
          )
        ],
      ),
    );
  }
}
