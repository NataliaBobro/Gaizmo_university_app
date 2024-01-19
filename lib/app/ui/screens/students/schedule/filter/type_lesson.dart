import 'package:etm_crm/app/domain/states/student/student_schedule_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class TypeLesson extends StatefulWidget {
  const TypeLesson({Key? key}) : super(key: key);

  @override
  State<TypeLesson> createState() => _TypeLessonState();
}

class _TypeLessonState extends State<TypeLesson> {
  List<int> selected = [];

  @override
  void initState() {
    setState(() {
      selected = context.read<StudentScheduleState>().filterSchedule.type;
    });
    super.initState();
  }

  void changeFilter(Map<String, dynamic> value) {
    final hasAdd = selected.where((element) => element == value['id']);
    hasAdd.isNotEmpty ? selected.remove(value['id']) : selected.add(value['id']);
    setState(() {});
  }

  void addAll() {
    final listTypeServices = context.read<StudentScheduleState>().listTypeServices;
    for(var a = 0; a < listTypeServices.length; a++){
      selected.add(listTypeServices[a]['id']);
    }
    setState(() {});
  }

  void clear() {
    selected = [];
    setState(() {});
  }

  void apply() {
    context.read<StudentScheduleState>().changeFilterType(selected);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentScheduleState>();
    final service = state.listTypeServices;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: 'Filter',
                    action: CupertinoButton(
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
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        ...List.generate(
                            service.length,
                            (index) {
                              final hasSelected = selected.where((element) => element == service[index]['id']);
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
                                          service[index]['name'],
                                          style: TextStyles.s14w400.copyWith(
                                              color: const Color(0xFF242424)
                                          ),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      changeFilter(service[index]);
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
