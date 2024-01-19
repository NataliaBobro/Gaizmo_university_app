import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/render_work_day.dart';
import '../../../../../../widgets/info_value.dart';

class BranchGeneralInfoTab extends StatefulWidget {
  const BranchGeneralInfoTab({
    Key? key,
    required this.tabController,
    required this.branch
  }) : super(key: key);

  final TabController tabController;
  final UserData? branch;

  @override
  State<BranchGeneralInfoTab> createState() => _BranchGeneralInfoTabState();
}

class _BranchGeneralInfoTabState extends State<BranchGeneralInfoTab> {
  @override
  Widget build(BuildContext context) {
    final school = widget.branch;

    return ListView(
      physics: const BottomBouncingScrollPhysics(),
      children: [
        Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            InfoValue(
                title: "Phone number",
                value: "${school?.phone}"
            ),
            InfoValue(
                title: "E-mail",
                value: "${school?.email}"
            ),
            InfoValue(
                title: "Category",
                value: "${school?.school?.category?.translate?.value}"
            ),
            if(school?.school?.siteName != null) ...[
              InfoValue(
                  title: "Site address",
                  value: "${school?.school?.siteName}"
              ),
            ],
            if(school?.workDay != null && school?.school?.from != null
                  && school?.school?.to != null) ...[
              Builder(
                builder: (context) {
                  try{
                    return InfoValue(
                        title: "Working hours",
                        value: "${convertDaysToFormat(school?.workDay ?? [])} "
                            "${(school?.school?.from)?.replaceAll(" ", "")} - "
                            "${(school?.school?.to)?.replaceAll(" ", "")}"
                    );
                  }catch(_){
                    return Container();
                  }
                },
              )
            ]
          ],
        )
      ],
    );
  }
}
