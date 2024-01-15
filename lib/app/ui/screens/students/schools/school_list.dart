import 'package:etm_crm/app/domain/states/student/StudentSchoolState.dart';
import 'package:etm_crm/app/ui/screens/students/schools/widgets/student_school_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../resources/resources.dart';
import '../../../widgets/center_header.dart';
import '../../school/profile/branchs/branch_list.dart';

class SchoolList extends StatefulWidget {
  const SchoolList({Key? key}) : super(key: key);

  @override
  State<SchoolList> createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentSchoolState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                  title: 'Schools',
                  action: Row(
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            left: 20,
                            right: 12
                        ),
                        child: SvgPicture.asset(
                            Svgs.search
                        ),
                        onPressed: () {},
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            left: 12,
                            right: 24
                        ),
                        child: SvgPicture.asset(
                            Svgs.menu
                        ),
                        onPressed: () {
                          state.openPage(
                              StudentSchoolFilter()
                          );
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: state.isLoading ? const CupertinoActivityIndicator() :
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24
                      ),
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        ...List.generate(
                            state.listSchool?.users.length ?? 0,
                                (index) => BranchItemWidget(
                                branch: state.listSchool?.users[index],
                                onPressed: () {

                                }
                            )
                        )
                      ],
                    )
                ),

              ],
            ),
          )
      ),
    );
  }
}
