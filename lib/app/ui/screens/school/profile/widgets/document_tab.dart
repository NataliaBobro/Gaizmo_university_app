import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app.dart';
import '../../../../widgets/add_document/add_document_widget.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/document_list.dart';

class DocumentTab extends StatefulWidget {
  const DocumentTab({Key? key}) : super(key: key);

  @override
  State<DocumentTab> createState() => _DocumentTabState();
}

class _DocumentTabState extends State<DocumentTab> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final documents = appState.userData?.documents ?? [];

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
                  title: getConstant('No_documents_yet'),
                  subtitle: getConstant('Click_the_button_below_to_add_documents'),
                  onPress: () {
                    appState.openPage(
                        context,
                        AddDocumentWidget(
                            userId: appState.userData?.id
                        )
                    ).whenComplete(() {
                      appState.getUser();
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

