import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/select_bottom_sheet_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_button.dart';
import 'center_header.dart';

class SelectSchoolCategory extends StatefulWidget {
  const SelectSchoolCategory({
    Key? key,
    required this.onSelect,
    this.selected
  }) : super(key: key);

  final Function onSelect;
  final Map<String, dynamic>? selected;

  @override
  State<SelectSchoolCategory> createState() => _SelectSchoolCategoryState();
}

class _SelectSchoolCategoryState extends State<SelectSchoolCategory> {
  Map<String, dynamic>? selected;
  List< Map<String, dynamic>> listSelected = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final categorySchool = context.read<AppState>().metaAppData?.categorySchool ?? [];
    for(var a = 0; a < categorySchool.length; a++){
      listSelected.add({
        "id": categorySchool[a].id,
        "name": categorySchool[a].translate?.value
      });
    }
    if(widget.selected != null){
      selected = widget.selected;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('School_category')
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              SelectBottomSheetInput(
                                  label: getConstant('Choose_category'),
                                  labelModal: getConstant('Choose_category'),
                                  selected: selected,
                                  items: listSelected,
                                  horizontalPadding: 0,
                                  onSelect: (value) {
                                    selected = value;
                                    setState(() {});
                                  }
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: getConstant('SAVE_CHANGES'),
                              onPressed: () {
                                widget.onSelect(selected);
                                Navigator.pop(context);
                              }
                          ),
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
