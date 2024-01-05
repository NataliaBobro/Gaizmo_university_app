import 'package:etm_crm/app/ui/screens/school/profile/branchs/add_branch.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app.dart';
import '../../../../widgets/center_header.dart';

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'Branches'
                ),
                Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const SizedBox(
                          height: 220,
                        ),
                        EmptyWidget(
                            isEmpty: true,
                            title: "No branches yet!",
                            subtitle: "Click the button below to add branch",
                            onPress: () {
                              appState.openPage(
                                  context,
                                  const AddBranch()
                              );
                            }
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
