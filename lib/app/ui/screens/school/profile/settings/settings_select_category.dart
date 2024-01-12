import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app.dart';
import '../../../../../domain/states/school/school_profile_state.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/select_bottom_sheet_input.dart';

class SettingsSelectCategory extends StatefulWidget {
  const SettingsSelectCategory({Key? key}) : super(key: key);

  @override
  State<SettingsSelectCategory> createState() => _SettingsSelectCategoryState();
}

class _SettingsSelectCategoryState extends State<SettingsSelectCategory> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolProfileState>();
    List<Map<String, dynamic>> listSchoolType = [];

    if(context.read<AppState>().metaAppData?.categorySchool != null){
      final cat = context.read<AppState>().metaAppData?.categorySchool ?? [];
      for(var a = 0; a < cat.length; a++){
        listSchoolType.add({
          "id":   cat[a].id,
          "name": cat[a].translate?.value,
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeaderWithAction(
                    title: 'Settings'
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            SelectBottomSheetInput(
                                label: "Choose school category",
                                labelModal: "School category",
                                selected: state.schoolCategory,
                                items: listSchoolType,
                                onSelect: (value) {
                                  state.changeSchoolCategory(value);
                                }
                            ),
                          ],
                        ),
                        if(state.schoolCategory?['id'] !=
                            context.watch<AppState>().userData?.school?.category?.id) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: AppButton(
                                title: 'Save changes',
                                onPressed: () {
                                  state.saveCategory();
                                }
                            ),
                          )
                        ]
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
