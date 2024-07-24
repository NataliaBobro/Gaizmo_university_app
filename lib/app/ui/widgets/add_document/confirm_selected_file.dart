import 'dart:io';

import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/resources.dart';

class ConfirmSelectedFile extends StatefulWidget {
  const ConfirmSelectedFile({
    Key? key,
    required this.selectedFile,
    required this.confirm
  }) : super(key: key);

  final File? selectedFile;
  final Function confirm;

  @override
  State<ConfirmSelectedFile> createState() => _ConfirmSelectedFileState();
}

class _ConfirmSelectedFileState extends State<ConfirmSelectedFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242424),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  minSize: 0.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14
                  ),
                  child: SvgPicture.asset(
                    Svgs.close,
                    color: Colors.white,
                    width: 32,
                  ),
                )
              ],
            ),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 500
              ),
              width: double.infinity,
              child: Image.file(
                widget.selectedFile!
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                      minSize: 0.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18
                      ),
                      child: Text(
                        getConstant('Take another photo'),
                        style: TextStyles.s12w600.copyWith(
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),
                  CupertinoButton(
                      minSize: 0.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18
                      ),
                      child: Text(
                        getConstant('Add this photo'),
                        style: TextStyles.s12w600.copyWith(
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        widget.confirm();
                        Navigator.pop(context);
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
