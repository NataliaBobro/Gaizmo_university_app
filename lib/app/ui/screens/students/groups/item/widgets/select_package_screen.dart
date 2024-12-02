import 'package:european_university_app/app/domain/models/services.dart';
import 'package:european_university_app/app/domain/services/favorite_service.dart';
import 'package:european_university_app/app/ui/screens/students/groups/item/widgets/service_item.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../domain/states/student/student_groups_state.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../chats/widgets/search_input.dart';

class SelectPackageScreen extends StatefulWidget {
  const SelectPackageScreen({
    Key? key,
    required this.index,
    this.isAllService = false
  }) : super(key: key);

  final int index;
  final bool? isAllService;

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  int? selected;
  List<ServicesModel?>? package;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentGroupsState>();
    package = widget.isAllService == true ?
      [state.servicesData?.allService?[widget.index]] :
      state.servicesData?.category?[widget.index].services;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color(0xFFF0F3F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CenterHeader(
                title: getConstant('Service_packages'),
                onBack: () {
                  state.closeClearButton();
                },
              ),
              SearchInput(
                placeholder: getConstant('Search'),
                controller: state.search,
                fetchSearch: (val) {
                  state.fetchService(search: val);
                },
                onTap: () {
                  state.openClearButton();
                },
                clearTextField: () {
                  state.clearTextField();
                },
                openClear: state.openClear,
                closeClearButton: () {
                  state.closeClearButton();
                },
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16
                      ).copyWith(
                        bottom: 100
                      ),
                      children: [
                        ...List.generate(
                            package?.length ?? 0,
                            (index) => ButtonPayItemLesson(
                              package: package?[index],
                              onSelect: selected == package?[index]?.id,
                              changeSelect: () {
                                setState(() {
                                  selected = package?[index]?.id;
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
                            title: getConstant('Select_package'),
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
            vertical: 16
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
                      "${widget.package?.name}",
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
