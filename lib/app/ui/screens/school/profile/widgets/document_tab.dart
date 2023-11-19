import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocumentTab extends StatefulWidget {
  const DocumentTab({Key? key}) : super(key: key);

  @override
  State<DocumentTab> createState() => _DocumentTabState();
}

class _DocumentTabState extends State<DocumentTab> {
  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
        isEmpty: true,
        title: 'No documets yet :(',
        subtitle: 'Click the button below to add documents!',
        onPress: () {}
    );
  }
}

