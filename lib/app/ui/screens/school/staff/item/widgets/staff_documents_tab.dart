import 'package:european_university_app/app/domain/states/school/school_staff_item_state.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/add_document/add_document_widget.dart';
import 'package:european_university_app/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/document_list.dart';
import '../../../../../widgets/empty_widget.dart';

class StaffDocumentsTab extends StatefulWidget {
  const StaffDocumentsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<StaffDocumentsTab> createState() => _StaffDocumentsTabState();
}

class _StaffDocumentsTabState extends State<StaffDocumentsTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolStaffItemState>();
    final documents = state.staff?.documents ?? [];
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
                   state.openPage(
                       AddDocumentWidget(
                           userId: state.staff?.id
                       )
                   ).whenComplete(() {
                     state.updateStaff();
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
