import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../../resources/resources.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 50
            ),
            width: 120,
            height: 120,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(100)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                Images.testAva,
                width: 112,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 18,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC700),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'ETM',
                      style: TextStyles.s10w600.copyWith(
                          color: const Color(0xFFFFC700)
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7
                    ),
                    child: Text(
                      '150',
                      style: TextStyles.s10w600.copyWith(
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
