import 'package:dotted_border/dotted_border.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../resources/resources.dart';
import '../theme/text_styles.dart';

class Dropzone extends StatefulWidget {
  const Dropzone({
    Key? key,
    required this.selectImage,
    this.file
  }) : super(key: key);

  final File? file;
  final Function selectImage;

  @override
  State<Dropzone> createState() => _DropzoneState();
}

class _DropzoneState extends State<Dropzone> {
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (mounted) {
          widget.selectImage(File(pickedFile.path));
          setState(() {});
        }
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [4],
      color: const Color(0xFF34373A),
      strokeWidth: 1.0,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: widget.file != null ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.file(
              widget.file!,
              width: 40,
              height: 48,
              fit: BoxFit.cover,
            ),
            Text(
              '${(widget.file?.path)?.substring((widget.file?.path.length ?? 20) - 20, widget.file?.path.length)}',
              style:
              TextStyles.s14w400.copyWith(color: const Color(0xFF34373A)),
            ),
            CupertinoButton(
                child: SvgPicture.asset(Svgs.delete),
                onPressed: () {
                  widget.selectImage(null);
                })
          ],
        ) :
        Row(
          children: [
            CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0.0,
                onPressed: _pickImage,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.appButton,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    getConstant('Select_image'),
                    style: TextStyles.s14w400
                        .copyWith(color: Colors.white),
                  ),
                )),
            const SizedBox(
              width: 8,
            ),
            Text(
              '.png, .jpg, .jpeg',
              style:
              TextStyles.s14w400.copyWith(color: const Color(0xFF34373A)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
        ,
      ),
    );
  }
}
