import 'package:etm_crm/app/domain/services/user_service.dart';
import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:etm_crm/app/ui/widgets/select_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../../../../resources/resources.dart';
import '../../theme/text_styles.dart';
import '../auth_button.dart';
import '../center_header.dart';
import '../take_photo_widget.dart';
import 'confirm_selected_file.dart';

class AddDocumentWidget extends StatefulWidget {
  const AddDocumentWidget({
    Key? key,
    required this.userId
  }) : super(key: key);

  final int? userId;

  @override
  State<AddDocumentWidget> createState() => _AddDocumentWidgetState();
}

class _AddDocumentWidgetState extends State<AddDocumentWidget> {
  TextEditingController docName = TextEditingController();
  int typeDoc = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'Add document'
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24
                            ),
                            physics: const ClampingScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              AppField(
                                label: 'Document name',
                                controller: docName
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SelectInput(
                                // errors: state.validateError?.errors.genderErrors?.first,
                                title: 'Choose type of document',
                                hintText: '',
                                hintStyle: TextStyles.s14w400.copyWith(
                                    color: const Color(0xFF848484)
                                ),
                                items: const [
                                  'Licence'
                                ],
                                selected: typeDoc,
                                labelStyle: TextStyles.s14w600.copyWith(
                                    color: const Color(0xFF242424)
                                ),
                                onSelect: (index) {
                                  setState(() {
                                    typeDoc = index;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        AppButton(
                            title: 'ADD DOCUMENT',
                            onPressed: () {
                              showBottomAddPhoto();
                            }
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }

  Future<void> showBottomAddPhoto() async {
    if(docName.text.isEmpty) return;
    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (_) {
        return  SizedBox(
          height: 313,
          child: SelectTypePhoto(
            addDocument: (File? file) {
              addDocument(file);
            }
          ),
        );
      },
    );
  }

  Future<void> addDocument(File? file) async {
    if(file == null) return;
    FormData formData = FormData();

    formData.files.add(
      MapEntry(
        'file',
        await MultipartFile.fromFile(file.path),
      ),
    );
    formData.fields.add(MapEntry('document_name', docName.text));
    formData.fields.add(MapEntry('doc_type', '$typeDoc'));

    downloadDocument(formData);
  }

  Future<void> downloadDocument(FormData formData)async {
    try{
      final result = await UserService.addDocument(
          context,
          widget.userId,
          formData
      );
      if(result == true){
        close();
      }
    } catch(e){
      print(e);
    }
  }

  void close() {
    Navigator.pop(context);
  }
}

class SelectTypePhoto extends StatefulWidget {
  const SelectTypePhoto({
    Key? key,
    required this.addDocument,
  }) : super(key: key);

  final Function addDocument;

  @override
  State<SelectTypePhoto> createState() => _SelectTypePhotoState();
}

class _SelectTypePhotoState extends State<SelectTypePhoto> {
  final List<AssetEntity> _medias = [];

  Future<void> loadAlbums() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();
    final List<AssetPathEntity> mediaDirectories = [];

    for (var album in albums) {
      final cont = await album.assetCountAsync;
      if(cont > 0) {
        mediaDirectories.add(album);
      }
    }
    if(mediaDirectories.isNotEmpty){
      loadImagesFromAlbum(mediaDirectories[0]);
    }
    setState(() {});
  }

  Future<void> loadImagesFromAlbum(AssetPathEntity album) async {
    _medias.clear();
    await downloadOffset(album, 0, 24);
  }

  Future<void> downloadOffset(AssetPathEntity album, int page, int size) async {
    List<AssetEntity> images = await album.getAssetListPaged(page: page, size: size);
    List<AssetEntity> filteredImages = images.where((asset) => asset.type == AssetType.image).toList();
    _medias.addAll(filteredImages);
    setState(() {});
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectImage(File(pickedFile.path));
    }
  }

  Future<void> selectImage(File? file) async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ConfirmSelectedFile(
                selectedFile: file,
                confirm: () {
                  addDocument(file);
                }
            )
        )
    );
  }

  void addDocument(file){
    widget.addDocument(file);
    Navigator.pop(context);
  }

  Future<void> takePhoto() async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => TakePhotoWidget(
              takePhoto: (File? file) {
                selectImage(file).then((value) {
                  Navigator.pop(context);
                });
              }
            )
        )
    );
  }


  @override
  void initState() {
    loadAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: List.generate(
                  _medias.length, (index) =>
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: CupertinoButton(
                        minSize: 0.0,
                        padding: EdgeInsets.zero,
                        onPressed: () async{
                          selectImage(
                              await _medias[index].file
                          );
                        },
                        child: AssetEntityImage(
                          _medias[index],
                          height: 160,
                          width: 90,
                          fit: BoxFit.cover,
                          isOriginal: false,
                          thumbnailFormat: ThumbnailFormat.jpeg,
                          thumbnailSize: const ThumbnailSize.square(250),
                        ),
                      ),
                    )
                ),
              )
            ],
          ),
        ),
        Container(
          height: 153,
          child: Column(
            children: [
              const SizedBox(
                height: 27,
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 13
                ),
                minSize: 0.0,
                onPressed: _getImage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Svgs.img,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Choose from gallery',
                      style: TextStyles.s12w600.copyWith(
                        color: Colors.black
                      ),
                    )
                  ],
                )
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(
                    vertical: 13
                ),
                minSize: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Svgs.photo,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Make a photo',
                      style: TextStyles.s12w600.copyWith(
                          color: Colors.black
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  takePhoto();
                }
              )
            ],
          ),
        )
      ],
    );
  }
}