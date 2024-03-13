import 'package:etm_crm/app/domain/models/services.dart';
import 'package:etm_crm/app/domain/services/favorite_service.dart';
import 'package:etm_crm/app/ui/screens/students/schools/item/widgets/service_item.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../domain/states/student/student_school_item_state.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';

class SelectPackageScreen extends StatefulWidget {
  const SelectPackageScreen({
    Key? key,
    required this.package
  }) : super(key: key);

  final List<ServicesModel?>? package;

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  int? selected;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentSchoolItemState>();
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
                            widget.package?.length ?? 0,
                            (index) => ButtonPayItemLesson(
                              package: widget.package?[index],
                              onSelect: selected == widget.package?[index]?.id,
                              changeSelect: () {
                                setState(() {
                                  selected = widget.package?[index]?.id;
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
                            disabled: selected == null,
                            title: 'pay package',
                            onPressed: () async {
                              if(selected != null){
                                state.openPage(
                                  ServiceItem(
                                      serviceId: selected
                                  )
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
    required this.onSelect,
    required this.changeSelect,
    required this.package,
  }) : super(key: key);

  final ServicesModel? package;
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
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 250
                    ),
                    child: Text(
                      "${widget.package?.numberVisits} ${widget.package?.name} lessons",
                      style: TextStyles.s14w500.copyWith(
                          color: const Color(0xFF242424)
                      ),
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
                      color: (widget.package?.isFavorites ?? 0) > 0 ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      if((widget.package?.isFavorites ?? 0) > 0){
                        removeFavorite();
                      }else{
                        addFavorite();
                      }
                    }
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "1 lesson ${widget.package?.cost} hrn",
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
      final result = await FavoriteService.add(context, widget.package?.id);
      if(result == true){
        widget.package?.isFavorites = 1;
        hasFavorite = true;
        setState(() {});
      }
    }catch(e){
      print(e);
    }
  }

  Future<void> removeFavorite()async {
    try{
      final result = await FavoriteService.remove(context, widget.package?.id);
      if(result == true){
        widget.package?.isFavorites = 0;
        hasFavorite = false;
        setState(() {});
      }
    }catch(e){
      print(e);
    }
  }
}
