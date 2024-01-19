import 'package:etm_crm/app/domain/services/favorite_service.dart';
import 'package:etm_crm/app/domain/states/student/pay_lesson_state.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';

class PayLessonScreen extends StatefulWidget {
  const PayLessonScreen({Key? key}) : super(key: key);

  @override
  State<PayLessonScreen> createState() => _PayLessonScreenState();
}

class _PayLessonScreenState extends State<PayLessonScreen> {
  List<int> countsLesson = [50, 10, 1];
  int? selected;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PayLessonState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color(0xFFF0F3F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CenterHeader(
                title: 'Service packages',
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 26
                      ),
                      children: [
                        ...List.generate(
                            countsLesson.length,
                            (index) => ButtonPayItemLesson(
                              id: state.servicesModel?.id,
                              count: countsLesson[index],
                              serviceName: state.servicesModel?.name,
                              price: state.servicesModel?.cost,
                              onSelect: selected == index,
                              changeSelect: () {
                                setState(() {
                                  selected = index;
                                });
                              }
                            )
                        )
                      ],
                    ),
                    Positioned(
                        bottom: 50,
                        left: 0,
                        right: 0,
                        child: IgnorePointer(
                          ignoring: selected == null,
                          child: AppButton(
                            title: 'pay package',
                            onPressed: () async {
                              if(selected != null){
                                state.payService(
                                    countsLesson[selected!]
                                );
                              }
                            }
                          ),
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


class ButtonPayItemLesson extends StatefulWidget {
  const ButtonPayItemLesson({
    Key? key,
    required this.id,
    required this.serviceName,
    required this.price,
    required this.onSelect,
    required this.changeSelect,
    required this.count,
  }) : super(key: key);

  final String? serviceName;
  final int? id;
  final int? price;
  final int count;
  final bool onSelect;
  final Function changeSelect;

  @override
  State<ButtonPayItemLesson> createState() => _ButtonPayItemLessonState();
}

class _ButtonPayItemLessonState extends State<ButtonPayItemLesson> {
  bool hasFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0.0,
        onPressed: () {
          widget.changeSelect();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFD0E3F2).withOpacity(widget.onSelect ? .4 : 1),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.count} ${widget.serviceName} lessons",
                    style: TextStyles.s14w500.copyWith(
                      color: const Color(0xFF242424)
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.only(
                      left: 15,
                      bottom: 0
                    ),
                    minSize: 0.0,
                    child: SvgPicture.asset(
                      Svgs.heart,
                      color: hasFavorite ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      addFavorite();
                    }
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "1 lesson ${widget.price} hrn",
                style: TextStyles.s12w400.copyWith(
                  color: const Color(0xFF848484)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addFavorite()async {
    try{
      final result = await FavoriteService.add(context, widget.id);
      if(result == true){
        hasFavorite = true;
        setState(() {});
      }
    }catch(e){
      print(e);
    }
  }
}
