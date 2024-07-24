import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
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

    return Column(
      children: List.generate(
          widget.documents.length,
          (index) => DocumentItem(
              document: widget.documents[index],
              onDelete: () {
                onDelete(widget.documents[index].id, index);
                Navigator.pop(context);
              }
          )
      ),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedColor: const Color(0xFFF0F3F6),
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),
        closedElevation: 0.0,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(
                bottom: 16
            ),
            height: 96,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                      imageUrl: '${widget.document.patch}',
                      width: 120,
                      height: 80,
                      errorWidget: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, error, stackTrace) =>
                      const CupertinoActivityIndicator()
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.document.name != null ?'${widget.document.name}' : '',
                        style: TextStyles.s14w500.copyWith(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis
                        ),
                        maxLines: 2,
                      ),
                      const Spacer(),
                      Text(
                        widget.document.notes != null ?'${widget.document.notes}' : '',
                        style: TextStyles.s12w400.copyWith(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis
                        ),
                        maxLines: 2,
                      ),
                    ],
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
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: '${widget.document.patch}',
                      width: double.infinity,
                      errorWidget: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                      fit: BoxFit.contain,
                    ),
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
                        Expanded(
                          child: Text(
                            widget.document.name != null ?'${widget.document.name}' : '',
                            style: TextStyles.s24w500.copyWith(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis
                            ),
                            maxLines: 3,
                          ),
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            minSize: 0.0,
                            child: SvgPicture.asset(
                              Svgs.remove,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context);
                            }
                        )
                      ],
                    )
                ),
              ),
              if(widget.document.notes != null) ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      color: Colors.white.withOpacity(.4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16
                      ).copyWith(
                          top: 60
                      ),
                      child: Text(
                        '${widget.document.notes}',
                        style: TextStyles.s14w500.copyWith(
                            color: Colors.black
                        ),
                      )
                  ),
                )
              ]
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
          title: Text(getConstant('Delete Confirmation')),
          content: Text(getConstant('Are you sure you want to delete?')),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(getConstant('Close')),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                widget.onDelete();
              },
              child: Text(getConstant('Delete')),
            ),
          ],
        );
      },
    );
  }
}

