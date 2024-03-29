import 'package:european_university_app/app/domain/states/school/school_schedule_state.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class FilterTeacher extends StatefulWidget {
  const FilterTeacher({Key? key}) : super(key: key);

  @override
  State<FilterTeacher> createState() => _FilterTeacherState();
}

class _FilterTeacherState extends State<FilterTeacher> {
  List<int> selected = [];

  @override
  void initState() {
    setState(() {
      selected = context.read<SchoolScheduleState>().filterSchedule.teacher;
    });
    super.initState();
  }

  void changeFilter(Map<String, dynamic> value) {
    final hasAdd = selected.where((element) => element == value['id']);
    hasAdd.isNotEmpty ? selected.remove(value['id']) : selected.add(value['id']);
    setState(() {});
  }

  void addAll() {
    final listTeacher = context.read<SchoolScheduleState>().listTeacher;
    for(var a = 0; a < listTeacher.length; a++){
      selected.add(listTeacher[a]['id']);
    }
    setState(() {});
  }

  void clear() {
    selected = [];
    setState(() {});
  }

  void apply() {
    context.read<SchoolScheduleState>().changeFilterTeacher(selected);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolScheduleState>();
    final teachers = state.listTeacher;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('Filter'),
                    action: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          child: Text(
                            selected.isEmpty ? getConstant('All') : getConstant('Clear'),
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
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            ...List.generate(
                                teachers.length,
                                    (index) {
                                  final hasSelected = selected.where((element) => element == teachers[index]['id']);
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
                                              teachers[index]['name'],
                                              style: TextStyles.s14w400.copyWith(
                                                  color: const Color(0xFF242424)
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          changeFilter(teachers[index]);
                                        }
                                    ),
                                  );
                                }
                            )
                          ],
                        )
                      ],
                    )
                ),
                AppButton(
                    title: getConstant('APPLY_FILTER'),
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
