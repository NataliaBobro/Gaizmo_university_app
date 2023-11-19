import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

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
      child:  Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 3,
            color: const Color(0xFFFFC700)
          )
        ),
        child: Center(
          child: Text(
            '+Add LOGO',
            style: TextStyles.s12w600.copyWith(
              color: const Color(0xFFACACAC)
            ),
          ),
        ),
      ),
    );
  }
}
