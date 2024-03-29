import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../../../domain/services/user_service.dart';
import '../../../../../../utils/show_message.dart';
import '../../../../../../widgets/snackbars.dart';


class BranchAvatar extends StatefulWidget {
  const BranchAvatar({
    Key? key,
    required this.userData,
    this.hasAdd = true
  }) : super(key: key);

  final UserData? userData;
  final bool hasAdd;

  @override
  State<BranchAvatar> createState() => _BranchAvatarState();
}

class _BranchAvatarState extends State<BranchAvatar> {

  Future<void> _getImage() async {
    if(!widget.hasAdd) return;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        uploadAvatar(File(pickedFile.path));
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
          child: widget.userData?.avatar == null ? Center(
            child: Text(
              !widget.hasAdd ? "" : '+Add LOGO',
              style: TextStyles.s12w600.copyWith(
                  color: const Color(0xFFACACAC)
              ),
            ),
          ) : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              key: Key('${widget.userData?.avatar}'),
              cacheKey: widget.userData?.avatar,
              imageUrl: '${widget.userData?.avatar}',
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

  Future<void> uploadAvatar(File file) async {
    try {
      final result = await UserService.uploadAvatar(context, widget.userData?.id, file);
      if(result != null){
        widget.userData?.avatar = result;
      }
    } on DioError catch (e) {
      showMessage(e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      setState(() {});
    }
  }
}
