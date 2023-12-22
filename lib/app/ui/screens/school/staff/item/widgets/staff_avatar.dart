import 'package:flutter/material.dart';

import '../../../../../../../resources/resources.dart';

class StaffAvatar extends StatefulWidget {
  const StaffAvatar({Key? key}) : super(key: key);

  @override
  State<StaffAvatar> createState() => _StaffAvatarState();
}

class _StaffAvatarState extends State<StaffAvatar> {
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
        ],
      ),
    );
  }
}

