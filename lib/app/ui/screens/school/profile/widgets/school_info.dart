import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchoolInfo extends StatefulWidget {
  const SchoolInfo({Key? key}) : super(key: key);

  @override
  State<SchoolInfo> createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final school = appState.userData?.school;
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
              '${school?.house} ${school?.street} ${school?.city}, ${school?.country}',
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
