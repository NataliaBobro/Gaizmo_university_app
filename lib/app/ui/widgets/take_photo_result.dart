import 'package:camera/camera.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';

import '../../../resources/resources.dart';

class TakePhotoResultWidget extends StatefulWidget {
  const TakePhotoResultWidget({
    Key? key,
    required this.takePhoto
  }) : super(key: key);

  final Function takePhoto;

  @override
  State<TakePhotoResultWidget> createState() => _TakePhotoResultWidgetState();
}

class _TakePhotoResultWidgetState extends State<TakePhotoResultWidget> {
  CameraController? cameraController;
  FlashMode flashMode = FlashMode.off;
  List<CameraDescription>? _cameras;
  bool initCamera = false;
  bool _isFrontCamera = false;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.takePhoto(File(pickedFile.path));
    }
  }


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

  void toggleCamera() async {
    if (initCamera && cameraController?.value.isInitialized == true) {
      CameraDescription newCameraDescription = _isFrontCamera
          ? _cameras![0]
          : _cameras![1];

      await cameraController?.setDescription(newCameraDescription);
      _isFrontCamera = !_isFrontCamera;
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242424),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
                CupertinoButton(
                  onPressed: () {
                    toggleCamera();
                  },
                  minSize: 0.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14
                  ),
                  child: SvgPicture.asset(
                    Svgs.replaceCamera,
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
                      bottom: 90
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
                  right: 44,
                  left: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          minSize: 55,
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                  Svgs.cameraMask
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                getConstant('Masks'),
                                style: TextStyles.s14w400.copyWith(
                                  color: Colors.white
                                ),
                              )
                            ],
                          ),
                          onPressed: () {

                          }
                      ),
                      CupertinoButton(
                          minSize: 0.0,
                          padding: EdgeInsets.zero,
                          child: SvgPicture.asset(
                              Svgs.cameraButton
                          ),
                          onPressed: () {
                            takePhoto();
                          }
                      ),
                      CupertinoButton(
                          minSize: 55,
                          padding: EdgeInsets.zero,
                          onPressed: _getImage,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                  Svgs.cameraPicture
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                getConstant('Gallery'),
                                style: TextStyles.s14w400.copyWith(
                                    color: Colors.white
                                ),
                              )
                            ],
                          )
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
