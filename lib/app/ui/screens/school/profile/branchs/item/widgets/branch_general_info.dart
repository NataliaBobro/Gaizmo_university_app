import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/custom_scroll_physics.dart';
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
                title: getConstant('Phone_number'),
                value: "${school?.phone}"
            ),
            InfoValue(
                title: getConstant('Email'),
                value: "${school?.email}"
            ),
            InfoValue(
                title: getConstant('Category'),
                value: "${school?.school?.category?.translate?.value}"
            ),
            if(school?.school?.siteName != null) ...[
              InfoValue(
                  title: getConstant('Site_address'),
                  value: "${school?.school?.siteName}"
              ),
            ],
            if(school?.workDay != null && school?.school?.from != null
                  && school?.school?.to != null) ...[
              Builder(
                builder: (context) {
                  try{
                    return InfoValue(
                        title: getConstant('Working_hours'),
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
