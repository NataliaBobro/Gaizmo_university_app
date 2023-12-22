import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/empty_widget.dart';

class StaffDocumentsTab extends StatefulWidget {
  const StaffDocumentsTab({
    Key? key,
    required this.staff
  }) : super(key: key);

  final UserData? staff;

  @override
  State<StaffDocumentsTab> createState() => _StaffDocumentsTabState();
}

class _StaffDocumentsTabState extends State<StaffDocumentsTab> {
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
