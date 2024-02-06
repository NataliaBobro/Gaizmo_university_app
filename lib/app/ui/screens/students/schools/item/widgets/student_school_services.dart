import 'package:etm_crm/app/domain/states/student/student_school_item_state.dart';
import 'package:etm_crm/app/ui/screens/students/schools/item/widgets/select_package_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/settings_input.dart';

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
                      (index) =>  SettingsInput(
                          title: "${state.servicesData?.category![index].name}",
                          onPress: () async {
                            state.openPage(
                                SelectPackageScreen(
                                    package: state.servicesData?.category?[index].services
                                )
                            );
                          }
                      )
              ),
              ...List.generate(
                  state.servicesData?.allService?.length ?? 0,
                      (index) => SettingsInput(
                        title: "${state.servicesData?.allService![index]?.name}",
                        onPress: () {
                          state.openPage(
                            SelectPackageScreen(
                                package: [
                                  state.servicesData?.allService?[index]
                                ]
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