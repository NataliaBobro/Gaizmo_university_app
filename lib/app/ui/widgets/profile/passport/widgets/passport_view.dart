import 'package:cached_network_image/cached_network_image.dart';
import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

import '../../../../../../../resources/resources.dart';
import '../../../../theme/text_styles.dart';

class PassportView extends StatefulWidget {
  const PassportView({Key? key}) : super(key: key);

  @override
  State<PassportView> createState() => _PassportViewState();
}

class _PassportViewState extends State<PassportView> {
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<AppState>().userData;

    return Container(
      padding: const EdgeInsets.all(16),
      height: 176,
      width: SizerUtil.width - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF242424)
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: TextStyles.s8w600.copyWith(
                        color: Colors.white
                    ),
                    text: 'ETM ',
                    children: [
                      TextSpan(
                          text: '|',
                          style: TextStyles.s8w600.copyWith(
                              color: const Color(0xFFFFC700)
                          )
                      ),
                      const TextSpan(
                          text: ' Edu Tech Mant'
                      ),

                    ]
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              SvgPicture.asset(
                Svgs.myIdCard
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getConstant('Current_Balance'),
                        style: TextStyles.s8w500.copyWith(
                            color: const Color(0xFF848484)
                        ),
                      ),
                      Text(
                        '${userData?.balanceEtm} ETM',
                        style: TextStyles.s10w500.copyWith(
                            color: Colors.white
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(
                    width: 41,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getConstant('Socilal_Rating'),
                        style: TextStyles.s8w500.copyWith(
                            color: const Color(0xFF848484)
                        ),
                      ),
                      SocialRating(
                        userData: userData
                      )
                    ],
                  )
                ],
              ),
              Expanded(child: Container()),
              Text(
                '${userData?.firstName} ${userData?.lastName}',
                style: TextStyles.s8w400.copyWith(
                  color: Colors.white
                ),
              )
            ],
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You are better\nthen 50% users',
                style: TextStyles.s8w500.copyWith(
                  color: const Color(0xFFFFC700)
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              UserViewAvatar(
                userData: userData
              )
            ],
          )
        ],
      ),
    );
  }
}

class UserViewAvatar extends StatelessWidget {
  const UserViewAvatar({
    Key? key,
    required this.userData
  }) : super(key: key);

  final UserData? userData;

  @override
  Widget build(BuildContext context) {
    return userData?.avatar != null ? ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
        ),
          child: Stack(
            children: [
              CachedNetworkImage(
                key: Key("${userData?.avatar}"),
                cacheKey: "${userData?.avatar}",
                imageUrl: "${userData?.avatar}",
                width: 55,
                height: 55,
                memCacheWidth: 55,
                maxWidthDiskCache: 55,
                errorWidget: (context, error, stackTrace) =>
                const SizedBox.shrink(),
                fit: BoxFit.cover,
              ),
              CustomPaint(
                size: const Size(56, 56),
                painter: BorderPainter(),
              ),
            ],
          )
      ),
    ): Container();
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFFFC700)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    double radius = math.min(size.width / 2, size.height / 2);
    double arcAngle = math.pi * 1;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
      -math.pi / -2,
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class SocialRating extends StatelessWidget {
  const SocialRating({
    Key? key,
    required this.userData
  }) : super(key: key);

  final UserData? userData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '25',
          style: TextStyles.s10w500.copyWith(
            color: Colors.white
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        SvgPicture.asset(
          Svgs.heart,
          width: 16,
          color: const Color(0xFFEB5757),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '100',
          style: TextStyles.s10w500.copyWith(
              color: Colors.white
          ),
        ),
        SvgPicture.asset(
          Svgs.view,
          width: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '15',
          style: TextStyles.s10w500.copyWith(
              color: Colors.white
          ),
        ),
        SvgPicture.asset(
          Svgs.repost,
          width: 16,
        ),
      ],
    );
  }
}
