import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../domain/services/user_service.dart';
import '../theme/text_styles.dart';

class DocumentList extends StatefulWidget {
  const DocumentList({
    Key? key,
    required this.documents,
  }) : super(key: key);

  final List<Documents> documents;

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: 12
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 24,
          mainAxisExtent: 123
      ),
      itemCount: widget.documents.length,
      itemBuilder: (context, index) {
        return DocumentItem(
          document: widget.documents[index],
          onDelete: () {
            onDelete(widget.documents[index].id, index);
            Navigator.pop(context);
          }
        );
      },
    );
  }

  Future<void> onDelete(id, index) async{
    try{
      final result = await UserService.deleteDocument(context, id);
      if(result == true){
        widget.documents.removeAt(index);
        setState(() {});
      }
    }catch(e){
      print(e);
    }
  }
}

class DocumentItem extends StatefulWidget {
  const DocumentItem({
    Key? key,
    required this.document,
    required this.onDelete
  }) : super(key: key);

  final Documents document;
  final Function onDelete;

  @override
  State<DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedColor: const Color(0xFFF0F3F6),
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),
        closedElevation: 0.0,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return  CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0.0,
            onPressed: () {
              openContainer();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: '${widget.document.patch}',
                    width: double.infinity,
                    errorWidget: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.document.name != null ?'${widget.document.name}' : '',
                  style: TextStyles.s12w400.copyWith(
                      color: Colors.black
                  ),
                )
              ],
            ),
          );
        },
        openBuilder: (BuildContext context, VoidCallback _) {
          return Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    Navigator.pop(context);
                  },
                  child: CachedNetworkImage(
                    imageUrl: '${widget.document.patch}',
                    width: double.infinity,
                    errorWidget: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                    color: Colors.white.withOpacity(.4),
                    constraints: BoxConstraints(
                        maxWidth: SizerUtil.width - 50
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16
                    ).copyWith(
                        top: 60
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.document.name != null ?'${widget.document.name}' : '',
                          style: TextStyles.s16w500.copyWith(
                              color: Colors.black
                          ),
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            minSize: 0.0,
                            child: SvgPicture.asset(
                                Svgs.delete
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context);
                            }
                        )
                      ],
                    )
                ),
              )
            ],
          );
        }
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this document?'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                widget.onDelete();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

