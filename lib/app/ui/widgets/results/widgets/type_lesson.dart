import 'package:european_university_app/app/domain/states/my_results_state.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../center_header.dart';


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
      selected = context.read<MyResultsState>().filterSchedule.type;
    });
    super.initState();
  }

  void changeFilter(Map<String, dynamic> value) {
    context.read<MyResultsState>().changeFilterType(value['id']);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    final state = context.watch<MyResultsState>();
    final service = state.listTypeServices;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'Add result',
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
              ],
            ),
          )
      ),
    );
  }
}
