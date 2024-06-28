import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../domain/states/student/student_groups_state.dart';
import '../../../utils/get_constant.dart';
import '../../../widgets/center_header.dart';
import '../../../widgets/settings_input.dart';
import 'item/widgets/select_package_screen.dart';

class StudentGroupsList extends StatefulWidget {
  const StudentGroupsList({super.key});

  @override
  State<StudentGroupsList> createState() => _StudentGroupsListState();
}

class _StudentGroupsListState extends State<StudentGroupsList> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentGroupsState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('Groups')
                ),
                Expanded(
                  child: !state.isLoading ? ListView(
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
                  ) : const SkeletonLoader(),
                )
              ],
            ),
          )
      ),
    );
  }
}

class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({super.key});

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(color: Colors.white),
          child: SkeletonItem(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 2,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: true,
                                    height: 10,
                                    borderRadius: BorderRadius.circular(8),
                                    minLength: MediaQuery.of(context).size.width / 2,
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

