import 'package:etm_crm/app/domain/states/student/favorite_state.dart';
import 'package:etm_crm/app/ui/screens/students/favorite/favorite_screen.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../../resources/resources.dart';


class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'My Profile',
              style: TextStyles.s24w700.copyWith(
                color: const Color(0xFF242424)
              ),
            ),
          ),
          Row(
            children: [
              CupertinoButton(
                minSize: 0.0,
                padding: const EdgeInsets.only(right: 2, left: 20, top: 4, bottom: 4),
                child: SvgPicture.asset(
                    Svgs.notify
                ),
                onPressed: () async {

                }
              ),
              CupertinoButton(
                  minSize: 0.0,
                  padding: const EdgeInsets.only(right: 24, left: 2, top: 4, bottom: 4),
                  child: SvgPicture.asset(
                      Svgs.heart
                  ),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => FavoriteState(context),
                              child: const FavoriteScreen(),
                            )
                        )
                    );
                  }
              ),
            ],
          )
        ],
      ),
    );
  }
}