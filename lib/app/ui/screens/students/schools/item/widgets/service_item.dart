import 'package:etm_crm/app/domain/services/student_service.dart';
import 'package:etm_crm/app/ui/screens/students/schools/item/widgets/pay_lesson_screen.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/models/services.dart';
import '../../../../../../domain/states/student/pay_lesson_state.dart';
import '../../../../../widgets/button_teacher_students.dart';
import '../../../../../widgets/center_header.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({
    Key? key,
    required this.serviceId
  }) : super(key: key);

  final int? serviceId;

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  ServicesModel? servicesModel;
  Map<String, List<DayItem>> groupedSchedule = {};
  int? openSection;

  @override
  void initState() {
    fetchService();
    super.initState();
  }

  Future<void> fetchService() async {

    try{
      final result = await StudentService.fetchServiceItem(context, widget.serviceId);
      if(result != null){
        servicesModel = result;
        renderSchedule(result);
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {});
    }
  }

  void renderSchedule(result) {
    if(result?.lessons != null){
      List<List<DayItem>?> scheduleList = [];
      for(var a = 0; a < (result?.lessons?.length ?? 0); a++){
        scheduleList.add(result?.lessons![a].day);
      }

      for (var schedule in scheduleList) {
        if (schedule != null) {
          for (var dayItem in schedule) {
            groupedSchedule.putIfAbsent(dayItem.name, () => []).add(dayItem);
          }
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color(0xFF242424),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ColoredBox(
                color: Color(0xFFF0F3F6),
                child: CenterHeader(
                  title: 'Lesson',
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFFF0F3F6),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                "${servicesModel?.name}",
                                style: TextStyles.s18w700.copyWith(
                                    color: const Color(0xFF242424)
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ButtonTeacher(
                                  teacher: servicesModel?.teacher
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ButtonStudents(
                                  students: [
                                    servicesModel?.teacher,
                                    servicesModel?.teacher,
                                    servicesModel?.teacher,
                                    servicesModel?.teacher
                                  ]
                              ),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 24
                          ),
                          child: Column(
                            children: [
                              ExpansionPanelList(
                                  dividerColor: const Color(0xFF242424),
                                  elevation: 1,
                                  expandedHeaderPadding: EdgeInsets.zero,
                                  expansionCallback: (int index, bool isExpanded) {
                                    setState(() {
                                      if(!isExpanded) {
                                        openSection = index;
                                      }else{
                                        openSection = null;
                                      }
                                    });
                                  },
                                  children: [
                                    ExpansionPanel(
                                        backgroundColor: const Color(0xFF242424),
                                        headerBuilder: (BuildContext context, bool isExpanded) {
                                          return Text(
                                            'Scedule',
                                            style: TextStyles.s14w400.copyWith(
                                                color: Colors.white
                                            ),
                                          );
                                        },
                                        body: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16
                                          ),
                                          child: ScheduleLesson(
                                              key: ValueKey(groupedSchedule.length),
                                              schedule: groupedSchedule,
                                              lessons: servicesModel?.lessons,
                                              duration: servicesModel?.duration
                                          ),
                                        ),
                                        isExpanded: openSection == 0
                                    )
                                  ]
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: AppButton(
                        title: 'Pay lesson',
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (context) => PayLessonState(context, servicesModel),
                                    child: const PayLessonScreen(),
                                  )
                              )
                          );
                        }
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleLesson extends StatefulWidget {
  const ScheduleLesson({
    Key? key,
    required this.schedule,
    required this.lessons,
    required this.duration
  }) : super(key: key);

  final Map<String, List<DayItem>> schedule;
  final List<Lesson>? lessons;
  final int? duration;

  @override
  State<ScheduleLesson> createState() => _ScheduleLessonState();
}

class _ScheduleLessonState extends State<ScheduleLesson> {
  List<Item> data = [];
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    data = generateItems(widget.schedule);
    setState(() {});
  }

  List<Item> generateItems(Map<String, List<DayItem>> schedule) {
    List<Item> dataWidget= [];
    schedule.forEach((day, items) {
      dataWidget.add(
          Item(
            headerValue: day,
            expandedValue: RenderDayTime(
                items: items,
                lessons: widget.lessons,
                duration: widget.duration,
            ),
          )
      );
    });
    return dataWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      dividerColor: const Color(0xFF242424),
      elevation: 1,
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index].isExpanded = !isExpanded;
        });
      },
      children: data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: const Color(0xFF242424),
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 17
              ),
              child: Text(
                item.headerValue,
                style: TextStyles.s14w400.copyWith(
                    color: Colors.white
                ),
              ),
            );
          },
          body: item.expandedValue,
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}


class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}

class RenderDayTime extends StatelessWidget {
  const RenderDayTime({
    Key? key,
    required this.items,
    required this.lessons,
    this.duration = 0
  }) : super(key: key);

  final List<DayItem> items;
  final List<Lesson>? lessons;
  final int? duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          items.length,
          (index) {
            TimeOfDay startTime = TimeOfDay.fromDateTime(DateTime.parse("2022-01-18 ${lessons?[index].startLesson}"));
            TimeOfDay endTime = startTime.replacing(
              hour: startTime.hour + (duration ?? 0) ~/ 60,
              minute: startTime.minute + (duration ?? 0) % 60,
            );
            return Container(
              padding: const EdgeInsets.only(
                bottom: 8
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "${startTime.format(context)} - ${endTime.format(context)}",
                style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFFABB1B6)
                ),
              ),
            );
          }
      ),
    );
  }
}
