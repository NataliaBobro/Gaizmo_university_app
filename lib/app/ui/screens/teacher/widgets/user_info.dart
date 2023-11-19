import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<AppState>().userData;
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            '${userData?.firstName} ${userData?.lastName}',
            style: TextStyles.s18w700.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            constraints: const BoxConstraints(
                maxWidth: 300
            ),
            child: Text(
              'Teaching marketing at European University\n Kiev, Ukraine',
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
