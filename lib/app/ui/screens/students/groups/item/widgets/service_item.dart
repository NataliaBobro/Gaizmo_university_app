import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/domain/services/student_service.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../domain/models/services.dart';
import '../../../../../../domain/services/pay_service.dart';
import '../../../../../../domain/states/student/favorite_state.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/button_teacher_students.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../../widgets/custom_expansion_panel.dart';
import '../../../favorite/favorite_screen.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  final int? serviceId;

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  ServicesModel? servicesModel;
  Map<String, List<DayItem>> groupedSchedule = {};
  List<UserData?> listUser = [];
  int? openSection = 0;
  bool loading = false;
  bool loadingService = false;

  @override
  void initState() {
    fetchService();
    super.initState();
  }

  Future<void> fetchService() async {
    loadingService = true;
    setState(() {});
    try{
      final result = await StudentService.fetchServiceItem(context, widget.serviceId);
      if(result != null){
        servicesModel = result;
        renderSchedule(result);
        if(servicesModel?.payUsers != null){
          for(var a = 0; a < (servicesModel?.payUsers?.length ?? 0); a++){
            listUser.add(servicesModel?.payUsers?[a].user);
          }
        }
      }
    }catch(e){
      print(e);
    }finally{
      loadingService = false;
      setState(() {});
    }
  }

  Future<void> payService(int? serviceId) async {
    loading = true;
    setState(() {});
    final result = await PayService.selectService(
      context,
      serviceId,
    );
    if(result != null && result['success'] == true){
      openPayed();
    }
  }

  void close() {
    Navigator.pop(context);
  }

  Future<void> openPayed() async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => FavoriteState(context),
              child: const FavoriteScreen(initTab: 1),
            )
        )
    );
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
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              color: const Color(0xFFF0F3F6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColoredBox(
                    color: const Color(0xFFF0F3F6),
                    child: CenterHeader(
                      title: getConstant('lesson'),
                    ),
                  ),
                  Expanded(
                    child: loadingService ?
                      const Center(
                        child: CupertinoActivityIndicator(color: Colors.white, radius: 20,),
                      ) :
                      Stack(
                      children: [
                        ListView(
                          physics: const ClampingScrollPhysics(),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: AppColors.appButton,
                                                borderRadius: BorderRadius.circular(100)
                                            ),
                                            child: SvgPicture.asset(
                                              Svgs.profesor,
                                              width: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: SizerUtil.width - 115
                                            ),
                                            child: Text(
                                              "${servicesModel?.name}",
                                              style: TextStyles.s18w700.copyWith(
                                                  color: const Color(0xFF242424)
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if(servicesModel?.desc != null)...[
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          servicesModel?.desc ?? '',
                                          style: TextStyles.s14w400.copyWith(
                                              color: const Color(0xFF242424)
                                          ),
                                        )
                                      ],
                                      if(servicesModel?.image != null) ...[
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                            imageUrl: '${servicesModel?.image}',
                                            width: double.infinity,
                                            errorWidget: (context, error, stackTrace) =>
                                            const SizedBox.shrink(),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                      if(listUser.isNotEmpty) ...[
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        ButtonStudents(
                                            students: listUser
                                        ),
                                      ],
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 24
                                    ),
                                    child: Column(
                                      children: [
                                        CustomExpansionPanelList(
                                            borderColor: AppColors.appButton,
                                            dividerColor: Colors.transparent,
                                            elevation: 0,
                                            expansionCallback: (int index, bool isExpanded) {
                                              setState(() {
                                                if(openSection == index) {
                                                  openSection = null;
                                                }else{
                                                  openSection = index;
                                                }
                                              });
                                            },
                                            children: [
                                              CustomExpansionPanel(
                                                  canTapOnHeader: false,
                                                  headerBuilder: (BuildContext context, bool isExpanded) {
                                                    return Container(
                                                      padding: const EdgeInsets.only(top: 16),
                                                      child: Text(
                                                        getConstant('Schedule'),
                                                        style: TextStyles.s14w600.copyWith(
                                                          color: AppColors.appButton
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  body: Column(
                                                    children: [
                                                      ScheduleLesson(
                                                          key: ValueKey(groupedSchedule.length),
                                                          schedule: groupedSchedule,
                                                          lessons: servicesModel?.lessons,
                                                          duration: servicesModel?.duration
                                                      )
                                                    ],
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
                            ),
                            const SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                        Positioned(
                            bottom: 50,
                            left: 0,
                            right: 0,
                            child: AppButton(
                                title: getConstant('Select_package'),
                                onPressed: () async {
                                  payService(widget.serviceId);
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
          if(loading)...[
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white.withOpacity(.5),
                child: const CupertinoActivityIndicator(color: Colors.black, radius: 30,),
              ),
            )
          ]
        ],
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
    return CustomExpansionPanelList(
      borderColor: const Color(0xFFACACAC),
      dividerColor: Colors.transparent,
      elevation: 0,
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index].isExpanded = isExpanded;
        });
      },
      children: data.map<CustomExpansionPanel>((Item item) {
        return CustomExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Svgs.calendar,
                    width: 22,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    getConstant(item.headerValue),
                    style: TextStyles.s14w400,
                  )
                ],
              ),
            );
          },
          body: Container(
            padding: const EdgeInsets.only(
              left: 25
            ),
            child: item.expandedValue,
          ),
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
              hour: startTime.hour + ((startTime.minute + (lessons?[index].duration ?? 0)) ~/ 60),
              minute: (startTime.minute + (lessons?[index].duration ?? 0)) % 60,
            );

            return Container(
              padding: const EdgeInsets.only(
                bottom: 6,
                top: 6
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "${startTime.format(context)} - ${endTime.format(context)}",
                style: TextStyles.s14w400
              ),
            );
          }
      ),
    );
  }
}
