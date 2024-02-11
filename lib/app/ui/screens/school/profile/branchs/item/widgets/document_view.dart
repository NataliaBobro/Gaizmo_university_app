import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../widgets/add_document/add_document_widget.dart';
import '../../../../../../widgets/custom_scroll_physics.dart';
import '../../../../../../widgets/document_list.dart';


class DocumentWidget extends StatefulWidget {
  const DocumentWidget({
    Key? key,
    required this.user,
    required this.onUpdate,
  }) : super(key: key);

  final UserData? user;
  final Function onUpdate;

  @override
  State<DocumentWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  List<Documents> documents = [];
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    documents = widget.user?.documents ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();

    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BottomBouncingScrollPhysics(),
            children: [
              if(documents.isEmpty) ...[
                const SizedBox(
                  height: 115,
                ),
              ],
              EmptyWidget(
                  isEmpty: documents.isEmpty,
                  title: 'No documets yet :(',
                  subtitle: 'Click the button below to add documents!',
                  onPress: () {
                    appState.openPage(
                        context,
                        AddDocumentWidget(
                            userId: widget.user?.id
                        )
                    ).whenComplete(() async {
                      widget.onUpdate();
                    });
                  }
              ),
              DocumentList(
                documents: documents,
              )
            ],
          ),
        )
      ],
    );
  }
}

