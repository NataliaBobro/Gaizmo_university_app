import 'package:etm_crm/app/domain/states/student/StudentSchoolState.dart';
import 'package:etm_crm/app/ui/screens/students/schools/widgets/filter_item.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class StudentSchoolFilter extends StatefulWidget {
  const StudentSchoolFilter({Key? key}) : super(key: key);

  @override
  State<StudentSchoolFilter> createState() => _StudentSchoolFilterState();
}

class _StudentSchoolFilterState extends State<StudentSchoolFilter> {
  List<Map<String, dynamic>> listCity = [];
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    context.read<StudentSchoolState>().fetchDataFilter();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentSchoolState>();

    if(state.filterDataString?.city != null){
      final list = state.filterDataString?.city ?? [];
      for(var a = 0; a < list.length; a++){
        listCity.add({
          'id': a,
          'name': list[a]
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
                const CenterHeader(
                    title: 'Filter',
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        FilterItemButton(
                          title: 'City',
                          value: state.selectedFilterCity,
                          list: listCity,
                          change: (value) {
                            state.changeFilterCity(value);
                          },
                        )
                      ],
                    )
                ),
                AppButton(
                    title: 'Apply filter',
                    onPressed: () {
                      state.fetchList();
                      Navigator.pop(context);
                    }
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          )
      ),
    );
  }
}

class FilterItemButton extends StatefulWidget {
  const FilterItemButton({
    Key? key,
    required this.title,
    required this.value,
    required this.list,
    required this.change,
  }) : super(key: key);

  final String title;
  final List<Map<String, dynamic>>? value;
  final List<Map<String, dynamic>>? list;
  final Function change;

  @override
  State<FilterItemButton> createState() => _FilterItemButtonState();
}

class _FilterItemButtonState extends State<FilterItemButton> {
  @override
  Widget build(BuildContext context) {
    String valStr = '';
    final read = context.read<StudentSchoolState>();
    if(widget.value != null){
      for(var a = 0; a< widget.value!.length; a++){
        valStr = '$valStr ${widget.value![a]['name']},';
      }
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0.0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyles.s14w400.copyWith(
                color: const Color(0xFF242424)
              ),
            ),

            Container(
              constraints: const BoxConstraints(
                maxWidth: 225
              ),
              child: Text(
                valStr.isNotEmpty ? valStr : "All",
                style: TextStyles.s14w400.copyWith(
                    color: const Color(0xFF242424),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      onPressed: () {
        read.openPage(
            FilterItem(
                title: widget.title,
                list: widget.list ?? [],
                selected: widget.value ?? [],
                change: (value) {
                  widget.change(value);
                }
            )
        );
      }
    );
  }
}

