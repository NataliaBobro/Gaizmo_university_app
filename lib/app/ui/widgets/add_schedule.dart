import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:sizer/sizer.dart';

import '../theme/text_styles.dart';
import 'auth_button.dart';
import 'center_header.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({
    Key? key,
    required this.selectedDay,
    required this.onSelect,
    required this.to,
    required this.from
  }) : super(key: key);

  final List<int> selectedDay;
  final Function onSelect;
  final MaskedTextController to;
  final MaskedTextController from;

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  List<int> selectedDay = [];
  List<String> listDay = [
    'MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU',
  ];
  MaskedTextController scheduleFrom = MaskedTextController(
      mask: '00 : 00'
  );
  MaskedTextController scheduleTo = MaskedTextController(
      mask: '00 : 00'
  );

  @override
  void initState() {
    selectedDay = widget.selectedDay;
    super.initState();
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
                const CenterHeader(
                    title: 'Schedule'
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose working days',
                                    style: TextStyles.s14w600.copyWith(
                                        color: const Color(0xFF242424)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                          listDay.length,
                                              (index) {
                                            bool isWork = selectedDay.contains(index);
                                            return Container(
                                              padding: EdgeInsets.only(left: index == 0 ? 0 : 16),
                                              child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  minSize: 0.0,
                                                  child: Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        color: isWork ?
                                                        const Color(0xFFFFC700) : Colors.white
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        listDay[index],
                                                        style: TextStyles.s12w600.copyWith(
                                                            color: isWork ?
                                                            Colors.white : Colors.black
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    changeWorkDay(index);
                                                  }
                                              ),
                                            );
                                          }
                                      )
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'Choose working hours',
                                    style: TextStyles.s14w600.copyWith(
                                        color: const Color(0xFF242424)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: SizerUtil.width / 2
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'From',
                                          style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF727272)
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 11,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: widget.from,
                                            style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF242424),
                                            ),
                                            decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 28
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 0,
                                                vertical: 0,
                                              ),
                                              hintStyle: TextStyles.s14w300.copyWith(
                                                color: const Color(0xFF242424),
                                              ),
                                              hintText: '__ : __',
                                              fillColor: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'to',
                                          style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF727272)
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 11,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: widget.to,
                                            style: TextStyles.s14w300.copyWith(
                                              color: const Color(0xFF242424),
                                            ),
                                            decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 28
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 0,
                                                vertical: 0,
                                              ),
                                              hintStyle: TextStyles.s14w300.copyWith(
                                                color: const Color(0xFF242424),
                                              ),
                                              hintText: '__ : __',
                                              fillColor: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: 'Save changes',
                              onPressed: () {
                                widget.onSelect(selectedDay);
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
  void changeWorkDay(index){
    bool contain = selectedDay.contains(index);
    if(contain){
      selectedDay.remove(index);
    }else{
      selectedDay.add(index);
    }
    setState(() {});
  }
}
