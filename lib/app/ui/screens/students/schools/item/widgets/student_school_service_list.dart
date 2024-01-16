import 'package:etm_crm/app/domain/models/services.dart';
import 'package:etm_crm/app/domain/states/student/student_school_item_state.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/item/widgets/branch_settings_tab.dart';
import 'package:etm_crm/app/ui/screens/students/schools/item/widgets/service_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/center_header.dart';

class StudentSchoolServiceList extends StatefulWidget {
  const StudentSchoolServiceList({
    Key? key,
    required this.list
  }) : super(key: key);

  final List<ServicesModel?>? list;

  @override
  State<StudentSchoolServiceList> createState() => _StudentSchoolServiceListState();
}

class _StudentSchoolServiceListState extends State<StudentSchoolServiceList> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<StudentSchoolItemState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                  title: 'Services',
                ),
                Expanded(
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            ...List.generate(
                                widget.list?.length ?? 0,
                                (index) => SettingsInput(
                                    title: "${widget.list![index]?.name}",
                                    onPress: () {
                                      read.openPage(
                                        ServiceItem(
                                          serviceId: widget.list![index]?.id
                                        )
                                      );
                                    }
                                )
                            )
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
