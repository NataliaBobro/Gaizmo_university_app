import 'package:etm_crm/app/domain/states/teacher/teacher_schedule_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class FilterClass extends StatefulWidget {
  const FilterClass({Key? key}) : super(key: key);

  @override
  State<FilterClass> createState() => _FilterClassState();
}

class _FilterClassState extends State<FilterClass> {
  List<int> selected = [];

  @override
  void initState() {
    setState(() {
      selected = context.read<TeacherScheduleState>().filterSchedule.selectClass;
    });
    super.initState();
  }

  void changeFilter(Map<String, dynamic> value) {
    final hasAdd = selected.where((element) => element == value['id']);
    hasAdd.isNotEmpty ? selected.remove(value['id']) : selected.add(value['id']);
    setState(() {});
  }

  void addAll() {
    final listClass = context.read<TeacherScheduleState>().listClass;
    for(var a = 0; a < listClass.length; a++){
      selected.add(listClass[a]['id']);
    }
    setState(() {});
  }

  void clear() {
    selected = [];
    setState(() {});
  }

  void apply() {
    context.read<TeacherScheduleState>().changeFilterClass(selected);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TeacherScheduleState>();
    final listClass = state.listClass;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: 'Filter',
                    action: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          child: Text(
                            selected.isEmpty ? 'All' : 'Clear',
                            style: TextStyles.s14w600.copyWith(
                                color: Colors.black
                            ),
                          ),
                          onPressed: () {
                            selected.isEmpty ? addAll() : clear();
                          },
                        )
                      ],
                    )
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        ...List.generate(
                            listClass.length,
                                (index) {
                              final hasSelected = selected.where((element) => element == listClass[index]['id']);
                              return Container(
                                color: hasSelected.isNotEmpty ? Colors.white : null,
                                child: CupertinoButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 18
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          listClass[index]['name'],
                                          style: TextStyles.s14w400.copyWith(
                                              color: const Color(0xFF242424)
                                          ),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      changeFilter(listClass[index]);
                                    }
                                ),
                              );
                            }
                        )
                      ],
                    )
                ),
                AppButton(
                    title: 'Apply filter',
                    onPressed: () {
                      apply();
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
