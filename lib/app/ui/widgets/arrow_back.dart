import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/resources.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({Key? key}) : super(key: key);

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
              color: const Color(0xFFFFC700),
            ),
            onPressed: () {
              Navigator.pop(context);
            }
        )
      ],
    );
  }
}
