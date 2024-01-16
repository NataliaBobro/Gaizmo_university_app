import 'package:etm_crm/app/domain/models/services.dart';
import 'package:etm_crm/app/domain/states/student/student_school_item_state.dart';
import 'package:etm_crm/app/ui/screens/students/schools/item/widgets/service_item.dart';
import 'package:etm_crm/app/ui/screens/students/schools/item/widgets/student_school_service_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../school/profile/branchs/item/widgets/branch_settings_tab.dart';

class StudentSchoolServices extends StatefulWidget {
  const StudentSchoolServices({Key? key}) : super(key: key);

  @override
  State<StudentSchoolServices> createState() => _StudentSchoolServicesState();
}

class _StudentSchoolServicesState extends State<StudentSchoolServices> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentSchoolItemState>();
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ...List.generate(
                  state.servicesData?.category?.length ?? 0,
                      (index) => CategoryServiceItem(
                      item: state.servicesData?.category![index]
                  )
              ),
              ...List.generate(
                  state.servicesData?.allService?.length ?? 0,
                      (index) => SettingsInput(
                        title: "${state.servicesData?.allService![index]?.name}",
                        onPress: () {
                          state.openPage(
                              ServiceItem(
                                  serviceId: state.servicesData?.allService![index]?.id
                              )
                          );
                        }
                    )
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CategoryServiceItem extends StatefulWidget {
  const CategoryServiceItem({
    Key? key,
    required this.item
  }) : super(key: key);

  final ServicesCategory? item;

  @override
  State<CategoryServiceItem> createState() => _CategoryServiceItemState();
}

class _CategoryServiceItemState extends State<CategoryServiceItem> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<StudentSchoolItemState>();
    return SettingsInput(
        title: "${widget.item?.name}",
        onPress: () async {
          read.openPage(
              StudentSchoolServiceList(
                list: widget.item?.services
              )
          );
        }
    );
  }
}

