import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';

import '../../../resources/resources.dart';

class TakePhotoWidget extends StatefulWidget {
  const TakePhotoWidget({
    Key? key,
    required this.takePhoto
  }) : super(key: key);

  final Function takePhoto;

  @override
  State<TakePhotoWidget> createState() => _TakePhotoWidgetState();
}

class _TakePhotoWidgetState extends State<TakePhotoWidget> {
  CameraController? cameraController;
  FlashMode flashMode = FlashMode.off;
  List<CameraDescription>? _cameras;
  bool initCamera = false;


  Future<void> getCameras() async {
    _cameras = await availableCameras();
    setState(() {});
    final len = _cameras?.length ?? 0;
    if(len > 0){
      cameraController = CameraController(_cameras![0], ResolutionPreset.max);
      cameraController?.initialize().then((_) {
        initCamera = true;
        setState(() {});
      }).catchError((Object e) {
        print(e);
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    getCameras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242424),
      body: SafeArea(
        child: Column(
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
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.black,
                      width: SizerUtil.width,
                      height: SizerUtil.height - 220,
                      child: initCamera ? CameraPreview(cameraController!) : null,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        minSize: 0.0,
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          Svgs.cameraButton
                        ),
                        onPressed: () {
                          takePhoto();
                        }
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void takePhoto() async {
    if (initCamera && cameraController!.value.isInitialized) {
      final XFile imageFile = await cameraController!.takePicture();
      widget.takePhoto(File(imageFile.path));
    }
  }
}
