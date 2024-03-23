import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/states/school/school_staff_item_state.dart';
import '../../../profile/widgets/general_info_tab.dart';

class StaffPersonalInfoTab extends StatefulWidget {
  const StaffPersonalInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  State<StaffPersonalInfoTab> createState() => _StaffPersonalInfoTabState();
}

class _StaffPersonalInfoTabState extends State<StaffPersonalInfoTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolStaffItemState>();
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        InfoValue(
            title: getConstant('Full_name'),
            value: "${state.staff?.firstName} ${state.staff?.lastName}"
        ),
        InfoValue(
            title: getConstant('Date_of_birth'),
            value: "${state.staff?.dateBirth}"
        ),
        InfoValue(
            title: getConstant('Phone_number'),
            value: "${state.staff?.phone}"
        ),
        InfoValue(
            title: getConstant('Email'),
            value: "${state.staff?.email}"
        ),
        // InfoValue(
        //     title: "Social links",
        //     value: "${widget.staff?.socialAccounts?.instagram}"
        // ),
        InfoValue(
            title: getConstant('Adress'),
            value: "${state.staff?.country}, ${state.staff?.city}"
        ),
      ],
    );
  }
}
