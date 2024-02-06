import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../resources/resources.dart';


class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Vanessa Smith',
            style: TextStyles.s18w700.copyWith(
              color: const Color(0xFF242424)
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 270
            ),
            child: Text(
              '1st year student of European University Kiev, Ukraine',
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          if(isOpen) ...[
            RichText(
              text: TextSpan(
                  text: 'Mother: ',
                  style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                  children: [
                    TextSpan(
                      text: 'Anna Smith',
                      style: TextStyles.s14w400.copyWith(
                          color: const Color(0xFF242424)
                      ),
                    )
                  ]
              ),
            ),
            RichText(
              text: TextSpan(
                  text: 'Father: ',
                  style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                  children: [
                    TextSpan(
                      text: 'John Smith',
                      style: TextStyles.s14w400.copyWith(
                          color: const Color(0xFF242424)
                      ),
                    )
                  ]
              ),
            ),
          ],
          CupertinoButton(
            padding: const EdgeInsets.only(
              bottom: 9,
              right: 30,
              left: 30
            ),
            minSize: 0.0,
            child: Transform.rotate(
              angle: isOpen ? 0 : 3,
              child: SvgPicture.asset(
                  Svgs.open
              ),
            ),
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
            }
          )
        ],
      ),
    );
  }
}
