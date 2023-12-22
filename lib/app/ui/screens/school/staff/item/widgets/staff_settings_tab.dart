import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/states/school/school_staff_item_state.dart';
import 'package:etm_crm/app/ui/screens/school/staff/item/widgets/staff_personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../profile/widgets/settings_tab.dart';

class StaffSettingsTab extends StatefulWidget {
  const StaffSettingsTab({
    Key? key,
    required this.staff
  }) : super(key: key);

  final UserData? staff;

  @override
  State<StaffSettingsTab> createState() => _StaffSettingsTabState();
}

class _StaffSettingsTabState extends State<StaffSettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        SettingsInput(
            title: "Personal info",
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => SchoolStaffItemState(context, widget.staff),
                    child: const StaffPersonalInfoScreen(),
                  ),
                ),
              );
            }
        ),
        SettingsInput(
            title: "Category",
            onPress: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //       value: read,
              //       child: const SettingsSocialAccounts(),
              //     ),
              //   ),
              // );
            }
        ),
        SettingsInput(
            title: "Schedule",
            onPress: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //       value: read,
              //       child: const SettingsSocialAccounts(),
              //     ),
              //   ),
              // );
            }
        ),
        SettingsInput(
            title: "My social accounts",
            onPress: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //       value: read,
              //       child: const SettingsSocialAccounts(),
              //     ),
              //   ),
              // );
            }
        ),
      ],
    );
  }
}
