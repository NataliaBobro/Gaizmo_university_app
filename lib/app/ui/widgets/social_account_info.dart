import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/resources.dart';
import '../theme/text_styles.dart';
import '../utils/url_launch.dart';

class SocialAccountInfo extends StatelessWidget {
  const SocialAccountInfo({
    Key? key,
    required this.socialAccounts
  }) : super(key: key);

  final SocialAccounts? socialAccounts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18
      ),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            child: Text(
              'Social links',
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF848484)
              ),
            ),
          ),
          if(socialAccounts?.instagram != null) ...[
            CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0.0,
                child: Image.asset(
                  Images.inst,
                  width: 16,
                ),
                onPressed: () {
                  launchUrlParse(socialAccounts?.instagram);
                }
            )
          ]

        ],
      ),
    );
  }
}