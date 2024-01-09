import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/states/school/school_branch_state.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../widgets/add_document/add_document_widget.dart';
import '../../../../../../widgets/custom_scroll_physics.dart';
import '../../../../../../widgets/document_list.dart';


class BranchDocumentTab extends StatefulWidget {
  const BranchDocumentTab({
    Key? key,
    required this.branch
  }) : super(key: key);

  final UserData? branch;

  @override
  State<BranchDocumentTab> createState() => _BranchDocumentTabState();
}

class _BranchDocumentTabState extends State<BranchDocumentTab> {
  List<Documents> documents = [];
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    documents = widget.branch?.documents ?? [];
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
                            userId: widget.branch?.id
                        )
                    ).whenComplete(() async {
                      final branch = await context.read<SchoolBranchState>().updateBranch(
                        widget.branch?.id
                      );
                      documents = branch?.documents ?? [];
                      setState(() {});
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

