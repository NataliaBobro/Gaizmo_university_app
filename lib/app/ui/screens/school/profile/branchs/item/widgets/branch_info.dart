import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../../../../../domain/models/user.dart';

class BranchInfo extends StatefulWidget {
  const BranchInfo({
    Key? key,
    required this.branch
  }) : super(key: key);

  final UserData? branch;

  @override
  State<BranchInfo> createState() => _BranchInfoState();
}

class _BranchInfoState extends State<BranchInfo> {
  @override
  Widget build(BuildContext context) {
    final school = widget.branch?.school;
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            '${school?.name}',
            style: TextStyles.s18w700.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            constraints: const BoxConstraints(
                maxWidth: 270
            ),
            child: Text(
              '${school?.house ?? ""} ${school?.street ?? ""} ${school?.city ?? ""} ${school?.country ?? ""}',
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
