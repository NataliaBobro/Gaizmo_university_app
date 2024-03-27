import 'package:dio/dio.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/models/meta.dart';
import '../../../domain/models/user.dart';
import '../../../domain/services/school_service.dart';
import '../../utils/show_message.dart';


class SettingSchedule extends StatefulWidget {
  const SettingSchedule({
    Key? key,
    required this.user,
    required this.onUpdate
  }) : super(key: key);

  final UserData? user;
  final Function onUpdate;

  @override
  State<SettingSchedule> createState() => _SettingScheduleState();
}

class _SettingScheduleState extends State<SettingSchedule> {
  final List<int> listWorkDay = [];
  ValidateError? _validateError;
  final MaskedTextController scheduleFrom = MaskedTextController(
      mask: '00 : 00'
  );
  final MaskedTextController scheduleTo = MaskedTextController(
      mask: '00 : 00'
  );
  List<String> listDay = [
    'MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU',
  ];
  FocusNode scheduleFromFocusNode = FocusNode();
  FocusNode scheduleToFocusNode = FocusNode();
  bool isEdited = false;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    scheduleFromFocusNode.dispose();
    scheduleToFocusNode.dispose();
    super.dispose();
  }

  void onScheduleFromChanged() {
    String from = scheduleFrom.text;
    if(from.length == 7 && !isEdited){
      if(context.mounted){
        FocusScope.of(context).requestFocus(scheduleToFocusNode);
        isEdited = true;
        setState(() {});
      }
    }
    if(from.length == 6 && isEdited){
      isEdited = false;
    }
  }

  void initData(){
    List<WorkDay>? workDayUser = widget.user?.workDay;

    for(var a = 0; a < (workDayUser?.length ?? 0); a++){
      listWorkDay.add(workDayUser![a].day);
    }

    scheduleFrom.text = '${widget.user?.from}';
    scheduleTo.text = '${widget.user?.to}';
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
                const CenterHeaderWithAction(
                    title: 'Settings'
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
                                          bool isWork = listWorkDay.contains(index);
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
                                            focusNode: scheduleFromFocusNode,
                                            keyboardType: TextInputType.number,
                                            controller: scheduleFrom,
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
                                            controller: scheduleTo,
                                            focusNode: scheduleToFocusNode,
                                            keyboardType: TextInputType.number,
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
                                saveSchedule();
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
    bool contain = listWorkDay.contains(index);
    if(contain){
      listWorkDay.remove(index);
    }else{
      listWorkDay.add(index);
    }
    setState(() {});
  }

  Future<void> saveSchedule() async {
    _validateError = null;
    setState(() {});
    try {
      final result = await SchoolService.changeSchedule(
        context,
        listWorkDay,
        scheduleFrom.text.replaceAll(' ', ''),
        scheduleTo.text.replaceAll(' ', ''),
      );
      if(result == true){
        widget.onUpdate();
        close();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    } catch(e){
      print(e);
    }
  }

  void close() {
    Navigator.pop(context);
  }
}
