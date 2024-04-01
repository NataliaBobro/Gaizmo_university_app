import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../change_avatar_widget.dart';

class ProfileAvatarWithETM extends StatefulWidget {
  const ProfileAvatarWithETM({Key? key}) : super(key: key);

  @override
  State<ProfileAvatarWithETM> createState() => _ProfileAvatarWithETMState();
}

class _ProfileAvatarWithETMState extends State<ProfileAvatarWithETM> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Stack(
        children: [
          ChangeAvatarWidget(
            userId: appState.userData?.id,
            avatar: appState.userData?.avatar,
            onUpdate: () async {
              await appState.getUser();
              setState(() {});
            },
          ),
          Positioned(
            left: 0,
            top: 18,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.appButton,
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
                      'EU',
                      style: TextStyles.s10w600.copyWith(
                          color: AppColors.appButton
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7
                    ),
                    child: Text(
                      '${appState.userData?.balanceEtm}',
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
