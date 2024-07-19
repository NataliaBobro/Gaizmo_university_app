import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
    String userDesk = '';
    if(userData?.school != null){
      userDesk = '${userData?.school?.name}\n';
    }

    if(userData?.city != null){
      userDesk = '$userDesk${userData?.city},';
    }
    if(userData?.country != null){
      userDesk = '$userDesk ${userData?.country}';
    }

    return Container(
      height: 90,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: SizerUtil.width - 50
            ),
            child: Text(
              '${userData?.firstName} ${userData?.lastName}',
              style: TextStyles.s18w700.copyWith(
                  color: const Color(0xFF242424)
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            constraints:  BoxConstraints(
              maxWidth: SizerUtil.width - 50,
              minHeight: 40,
              maxHeight: 40
            ),
            child: Text(
              userDesk,
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
