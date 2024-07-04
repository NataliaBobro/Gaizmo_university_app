import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

import '../../../../../../../resources/resources.dart';
import '../../../../theme/app_colors.dart';
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
        color: AppColors.appButton
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
                    text: 'ЄВРОПЕЙСЬКИЙ УНІВЕРСИТЕТ',
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
                            color: Colors.white
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${userData?.balanceEtm} EU',
                            style: TextStyles.s10w500.copyWith(
                                color: Colors.white
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4
                            ),
                            width: 1,
                            height: 10,
                            color: Colors.white,
                          ),
                          Text(
                            '25 000 UAH',
                            style: TextStyles.s10w500.copyWith(
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
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
          UserViewAvatar(
              userData: userData
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
      ..color = Colors.white
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
