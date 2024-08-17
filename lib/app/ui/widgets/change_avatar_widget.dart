import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../domain/services/user_service.dart';
import '../theme/text_styles.dart';

class ChangeAvatarWidget extends StatefulWidget {
  const ChangeAvatarWidget({
    Key? key,
    required this.userId,
    required this.avatar,
    required this.onUpdate
  }) : super(key: key);

  final int? userId;
  final String? avatar;
  final Function onUpdate;

  @override
  State<ChangeAvatarWidget> createState() => _ChangeAvatarWidgetState();
}

class _ChangeAvatarWidgetState extends State<ChangeAvatarWidget> {

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        uploadAvatar(File(pickedFile.path));
      });
    }
  }

  Future<void> uploadAvatar(File file) async {
    try {
      final result = await UserService.uploadAvatar(context, widget.userId, file);
      if(result != null){
        widget.onUpdate();
      }
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30
      ),
      child: CupertinoButton(
        minSize: 0.0,
        padding: EdgeInsets.zero,
        onPressed: _getImage,
        child:  Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  width: 3,
                  color: AppColors.appButton
              )
          ),
          child: widget.avatar == null ? Center(
            child: Text(
              getConstant('+Add'),
              style: TextStyles.s12w600.copyWith(
                  color: const Color(0xFFACACAC)
              ),
            ),
          ) : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              key: Key("${widget.avatar}"),
              cacheKey: "${widget.avatar}",
              imageUrl: "${widget.avatar}",
              width: 120,
              memCacheWidth: 120,
              maxWidthDiskCache: 120,
              errorWidget: (context, error, stackTrace) =>
              const SizedBox.shrink(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

