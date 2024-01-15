import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/text_styles.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class FilterItem extends StatefulWidget {
  const FilterItem({
    Key? key,
    required this.title,
    required this.list,
    required this.selected,
    required this.change
  }) : super(key: key);

  final String title;
  final List<Map<String, dynamic>> list;
  final List<Map<String, dynamic>>? selected;
  final Function change;

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  List<Map<String, dynamic>> selected = [];

  @override
  void initState() {
    if(widget.selected != null){
      selected = widget.selected!;
    }
    super.initState();
  }

  void changeFilter(Map<String, dynamic> value) {
    final hasAdd = selected.where((element) => element == value);
    hasAdd.isNotEmpty ? selected.remove(value) : selected.add(value);
    setState(() {});
  }

  void addAll() {
    selected = widget.list;
    setState(() {});
  }

  void clear() {
    selected = [];
    setState(() {});
  }

  void apply() {
    widget.change(selected);
    Navigator.pop(context);
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
                    title: 'Filter ',
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
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            ...List.generate(
                                widget.list.length,
                                    (index) {
                                  final hasSelected = selected.where((element) => element == widget.list[index]);
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
                                              widget.list[index]['name'],
                                              style: TextStyles.s14w400.copyWith(
                                                  color: const Color(0xFF242424)
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          changeFilter(widget.list[index]);
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
