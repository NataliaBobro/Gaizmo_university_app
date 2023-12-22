import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/material.dart';

import '../../../profile/widgets/general_info_tab.dart';

class StaffPersonalInfoTab extends StatefulWidget {
  const StaffPersonalInfoTab({
    Key? key,
    required this.staff
  }) : super(key: key);

  final UserData? staff;

  @override
  State<StaffPersonalInfoTab> createState() => _StaffPersonalInfoTabState();
}

class _StaffPersonalInfoTabState extends State<StaffPersonalInfoTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        InfoValue(
            title: "Full name",
            value: "${widget.staff?.firstName} ${widget.staff?.lastName} ${widget.staff?.surname}"
        ),
        InfoValue(
            title: "Date of birth",
            value: "${widget.staff?.dateBirth}"
        ),
        InfoValue(
            title: "Phone number",
            value: "${widget.staff?.phone}"
        ),
        InfoValue(
            title: "E-mail",
            value: "${widget.staff?.email}"
        ),
        // InfoValue(
        //     title: "Social links",
        //     value: "${widget.staff?.socialAccounts?.instagram}"
        // ),
        InfoValue(
            title: "Adress",
            value: "${widget.staff?.country}, ${widget.staff?.city}"
        ),
      ],
    );
  }
}
