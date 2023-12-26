import 'package:cached_network_image/cached_network_image.dart';
import 'package:etm_crm/app/domain/states/school/school_staff_item_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/add_document/add_document_widget.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                 title: 'No documets yet :(',
                 subtitle: 'Click the button below to add documents!',
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
             GridView.builder(
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
               itemCount: documents.length,
               itemBuilder: (context, index) {
                 return CupertinoButton(
                   padding: EdgeInsets.zero,
                   minSize: 0.0,
                   onPressed: () {

                   },
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: '${documents[index].patch}',
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
                         documents[index].name != null ?'${documents[index].name}' : '',
                         style: TextStyles.s12w400.copyWith(
                           color: Colors.black
                         ),
                       )
                     ],
                   ),
                 );
               },
             ),
           ],
         ),
       )
      ],
    );
  }
}
