import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../../../../../../domain/states/school/school_profile_state.dart';
import '../../../../../theme/text_styles.dart';

class StaffAvatar extends StatefulWidget {
  const StaffAvatar({
    Key? key,
    required this.staff,
    required this.onUpload,
  }) : super(key: key);

  final UserData? staff;
  final Function onUpload;

  @override
  State<StaffAvatar> createState() => _StaffAvatarState();
}

class _StaffAvatarState extends State<StaffAvatar> {

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        context.read<SchoolProfileState>()
            .uploadAvatar(File(pickedFile.path), uploadUserId: widget.staff?.id).then((value) {
          widget.onUpload();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  color: const Color(0xFFFFC700)
              )
          ),
          child: widget.staff?.avatar == null ? Center(
            child: Text(
              '+Add LOGO',
              style: TextStyles.s12w600.copyWith(
                  color: const Color(0xFFACACAC)
              ),
            ),
          ) : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              key: Key('${widget.staff?.avatar}'),
              cacheKey: '${widget.staff?.avatar}',
              imageUrl: '${widget.staff?.avatar}',
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

