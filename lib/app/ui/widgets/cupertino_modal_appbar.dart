import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class CustomCupertinoModalAppBar extends StatefulWidget {
  const CustomCupertinoModalAppBar({
    Key? key,
    required this.title,
    this.ballancePeriod,
    this.titleStyle,
    this.titleIsFitted = false,
    this.isPriceList = false,
    this.isShareIconExist = true,
    this.isB2B = false,
    this.isBallance = false,
    this.isPenalty = false,
    this.child,
    this.color,
    this.dividerColor,
    this.onClose,
    this.leading,
    this.height = 54,
    this.callShare = true,
  }) : super(key: key);

  final String title;
  final String? ballancePeriod;
  final TextStyle? titleStyle;
  final bool titleIsFitted;
  final bool isPriceList;
  final bool isShareIconExist;
  final bool isB2B;
  final bool isBallance;
  final bool isPenalty;
  final Widget? child;
  final Color? color;
  final Color? dividerColor;
  final Function()? onClose;
  final Widget? leading;
  final double height;
  final bool callShare;

  @override
  State<CustomCupertinoModalAppBar> createState() =>
      _CustomCupertinoModalAppBarState();
}

class _CustomCupertinoModalAppBarState
    extends State<CustomCupertinoModalAppBar> {
  bool isDownloading = false;

  void onClose() {
    widget.onClose != null
        ? widget.onClose?.call()
        : Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          // #UI and #GestureArea
          children: [
            // #UI
            Container(
              height: widget.height,
              width: SizerUtil.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40)
                          .copyWith(top: 3),
                      child: Text(
                        widget.title,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: widget.titleStyle ??
                            TextStyles.s16w500.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ),
                  ),

                  // #button : close
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: SvgPicture.asset(
                        Svgs.close,
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: CupertinoButton(
                onPressed: onClose,
                padding: EdgeInsets.zero,
                child: const SizedBox(
                  height: 54,
                  width: 60,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          height: .5,
          color: AppColors.neutral400,
          thickness: .5,
        ),
      ],
    );
  }
}
