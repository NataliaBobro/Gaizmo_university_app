import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/states/school/school_profile_state.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../theme/app_colors.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        context.read<SchoolProfileState>().uploadAvatar(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatar = context.watch<AppState>().userData?.avatar;
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 24, bottom: 16),
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
          child: avatar == null ? Center(
            child: Text(
              '+Add LOGO',
              style: TextStyles.s12w600.copyWith(
                  color: const Color(0xFFACACAC)
              ),
            ),
          ) : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              key: Key(avatar),
              cacheKey: avatar,
              imageUrl: avatar,
              width: 120,
              memCacheWidth: 120,
              maxWidthDiskCache: 120,
              errorWidget: (context, error, stackTrace) =>
              const SizedBox.shrink(),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
