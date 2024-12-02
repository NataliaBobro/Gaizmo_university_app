import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class TypeLesson extends StatefulWidget {
  const TypeLesson({
    Key? key,
    required this.selected,
    required this.list,
    required this.onChange,
    this.isMultipart = true,
  }) : super(key: key);

  final List<int> selected;
  final List<Map<String, dynamic>> list;
  final Function onChange;
  final bool isMultipart;

  @override
  State<TypeLesson> createState() => _TypeLessonState();
}

class _TypeLessonState extends State<TypeLesson> {
  List<int> selected = [];

  @override
  void initState() {
    setState(() {
      selected = widget.selected;
    });
    super.initState();
  }

  void changeFilter(Map<String, dynamic> value) {
    if(!widget.isMultipart){
      selected = [];
    }
    final hasAdd = selected.where((element) => element == value['id']);
    hasAdd.isNotEmpty ? selected.remove(value['id']) : selected.add(value['id']);
    setState(() {});
  }

  void addAll() {
    final listTypeServices = widget.list;
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
    widget.onChange(selected);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.list;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: getConstant('Type_of_lesson'),
                    action: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(widget.isMultipart)...[
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
                        ]
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
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: SizerUtil.width - 50
                                              ),
                                              child: Text(
                                                service[index]['name'],
                                                style: TextStyles.s14w400.copyWith(
                                                    color: const Color(0xFF242424)
                                                ),
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
