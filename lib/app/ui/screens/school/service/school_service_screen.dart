import 'dart:async';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:european_university_app/app/domain/models/services.dart';
import 'package:european_university_app/app/ui/screens/school/service/widgets/services_header.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../../domain/states/services_state.dart';
import '../../../utils/show_message.dart';

class SchoolServicesScreen extends StatefulWidget {
  const SchoolServicesScreen({Key? key}) : super(key: key);

  @override
  State<SchoolServicesScreen> createState() => _SchoolServicesScreenState();
}

class _SchoolServicesScreenState extends State<SchoolServicesScreen> {
  bool viewOnDelete = false;
  dynamic onConfirmDelete;


  void changeViewDelete(servicesCategory){
    setState(() {
      viewOnDelete = !viewOnDelete;
      onConfirmDelete = servicesCategory;
    });
  }

  Future<void> deleteService() async {
    viewOnDelete = false;
    if(onConfirmDelete is ServicesCategory){
      ServicesCategory category = onConfirmDelete;
      if((category.services?.length ?? 0) == 0){
        context.read<ServicesState>().deleteCategory(onConfirmDelete);
      }else{
        showMessage('Remove the services first', color: AppColors.appButton);
      }
    }else{
      context.read<ServicesState>().deleteService(onConfirmDelete);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ServicesState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const ServicesHeader(),
              Expanded(
                child: Stack(
                  children: [
                    if(state.isLoading) ...[
                      const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    ] else ...[
                      if(state.servicesCategory.isNotEmpty || state.allServices.isNotEmpty) ...[
                        ListView(
                          physics: const ClampingScrollPhysics(),
                          children: [
                            EmptyWidget(
                                isEmpty: false,
                                onPress: () {
                                  state.openAddOrEditService();
                                }
                            ),
                            Accordion(
                                onDelete: (index) {
                                  changeViewDelete(state.servicesCategory[index]);
                                },
                                onEdit: (index) {
                                  state.onEdit(state.servicesCategory[index]);
                                },
                                paddingListTop: 0.0,
                                disableScrolling: true,
                                headerBorderWidth: 0,
                                contentBorderWidth: 3,
                                scaleWhenAnimating: false,
                                openAndCloseAnimation: true,
                                paddingListHorizontal: 16,
                                rightIcon: SvgPicture.asset(
                                    Svgs.map
                                ),
                                paddingListBottom: 0.0,
                                flipRightIconIfOpen: false,
                                headerPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 13
                                ),
                                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                                children: List.generate(
                                    state.servicesCategory.length, (index) =>
                                    AccordionSection(
                                      isOpen: false,
                                      headerBackgroundColor:
                                      Color(int.parse('${state.servicesCategory[index].color}')).withOpacity(.6),
                                      contentVerticalPadding: 4,
                                      contentBorderWidth: 0,
                                      contentHorizontalPadding: 0.0,
                                      contentBackgroundColor: const Color(0xFFF0F3F6),
                                      header: Text(
                                        "${index + 1}. ${state.servicesCategory[index].name}",
                                        style: TextStyles.s14w600.copyWith(
                                            color: const Color(0xFF242424)
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onDelete: (index) {
                                        changeViewDelete(
                                            state.servicesCategory[index]
                                        );
                                      },
                                      onEdit: (service) {
                                        state.onEdit(service);
                                      },
                                      content: ElementCategoryItem(
                                        onDelete: (service) {
                                          changeViewDelete(service);
                                        },
                                        onEdit: (service) {
                                          state.onEdit(service);
                                        },
                                        isChild: true,
                                        item: state.servicesCategory[index].services,
                                        categoryIndex: index,
                                      ),
                                    )
                                )
                            ),
                            if(state.allServices.isNotEmpty) ...[
                              ...List.generate(
                                state.allServices.length,
                                    (index) => ElementCategoryItem(
                                  onDelete: (service) {
                                    changeViewDelete(service);
                                  },
                                  onEdit: (service) {
                                    state.onEdit(service);
                                  },
                                  item: [state.allServices[index]],
                                  categoryIndex: state.servicesCategory.length + index,
                                ),
                              )
                            ]
                          ],
                        )
                      ] else ...[
                        EmptyWidget(
                            title: getConstant('No_services_yet_'),
                            subtitle: getConstant('Click_the_button_below_to_add_services'),
                            isEmpty: state.servicesCategory.isEmpty && !state.isLoading,
                            onPress: () {
                              state.openAddOrEditService();
                            }
                        )
                      ],
                    ],
                    if(viewOnDelete) ...[
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            changeViewDelete(null);
                          },
                          child: Container(
                            width: SizerUtil.width,
                            color: Colors.black.withOpacity(.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 55,
                                      vertical: 24
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 53
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        getConstant('Are you sure you want to delete the service?'),
                                        style: TextStyles.s14w600,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CupertinoButton(
                                              padding: EdgeInsets.zero,
                                              minSize: 0.0,
                                              onPressed: () {
                                                deleteService();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 18,
                                                    vertical: 4
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: const Color(0xFF242424)
                                                    )
                                                ),
                                                child: Text(
                                                  getConstant('Yes'),
                                                  style: TextStyles.s12w600.copyWith(
                                                      color: const Color(0xFF242424)
                                                  ),
                                                ),
                                              )
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          CupertinoButton(
                                              padding: EdgeInsets.zero,
                                              minSize: 0.0,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 18,
                                                    vertical: 4
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: AppColors.appButton,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: AppColors.appButton,
                                                    )
                                                ),
                                                child: Text(
                                                  getConstant('No'),
                                                  style: TextStyles.s12w600.copyWith(
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                changeViewDelete(null);
                                              }
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ElementCategoryItem extends StatefulWidget {
  const ElementCategoryItem({
    Key? key,
    required this.item,
    this.categoryIndex,
    this.isChild = false,
    required this.onDelete,
    required this.onEdit

  }) : super(key: key);

  final List<ServicesModel?>? item;
  final int? categoryIndex;
  final bool isChild;
  final Function onDelete;
  final Function onEdit;

  @override
  State<ElementCategoryItem> createState() => _ElementCategoryItemState();
}

class _ElementCategoryItemState extends State<ElementCategoryItem> {
  @override
  Widget build(BuildContext context) {
    final services = widget.item ?? [];
    return Accordion(
        disableScrolling: true,
        headerBorderWidth: 0,
        contentBorderWidth: 3,
        contentHorizontalPadding: 0,
        scaleWhenAnimating: false,
        openAndCloseAnimation: true,
        paddingListBottom: 0.0,
        paddingListTop: 0.0,
        rightIcon: SvgPicture.asset(
          Svgs.map,
          color: Colors.transparent,
          width: 0,
        ),
        onDelete: (index) {
          widget.onDelete(services[index]);
        },
        onEdit: (index) {
          widget.onEdit(services[index]);
        },
        paddingListHorizontal: widget.isChild ? 0 : 16.0,
        flipRightIconIfOpen: false,
        headerPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: List.generate(
          services.length,
          (index) {
            String itemName = '${(widget.categoryIndex ?? 0) + 1}';
            if(services[index]?.serviceCategory != null) {
              itemName = '$itemName.${index + 1}';
            }
            itemName = '$itemName ${services[index]?.name}';
            return AccordionSection(
              onDelete: (index) {
                widget.onDelete(
                  services[index]
                );
              },
              onEdit: () {
                widget.onEdit(
                  services[index]
                );
              },
              isOpen: false,
              headerBackgroundColor:
              Color(int.parse('${services[index]?.color}')).withOpacity(.6),
              contentBorderWidth: 0,
              contentHorizontalPadding: 0,
              contentBackgroundColor: const Color(0xFFF0F3F6),
              header: Text(
                itemName,
                style: TextStyles.s14w600.copyWith(
                    color: const Color(0xFF242424)
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              content: ContentService(
                  item: services[index]
              ),
            );
          }
        )
    );
  }
}

class ContentService extends StatefulWidget {
  const ContentService({
    Key? key,
    required this.item
  }) : super(key: key);

  final ServicesModel? item;

  @override
  State<ContentService> createState() => _ContentServiceState();
}

class _ContentServiceState extends State<ContentService> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse('${widget.item?.color}')).withOpacity(.4)
      ),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 6,
          ),
          if(widget.item?.branch != null) ...[
            ContentRowInfo(
                title: getConstant('Branch'),
                value: '${widget.item?.branch?.name}'
            ),
          ],
          ContentRowInfo(
              title: getConstant('Number_of_students'),
              value: '${widget.item?.payUsers?.length ?? 0}'
          ),
          if(widget.item?.validity != null) ...[
            ContentRowInfo(
                title: getConstant('Validity'),
                value: "${widget.item?.validity} ${getConstant('${widget.item?.validityType}')}"
            )
          ],
          // ContentRowInfo(
          //     title: getConstant('Cost'),
          //     value: "${widget.item?.cost} ${widget.item?.currency?.symbol}"
          // ),
          ContentRowInfo(
              title: "EU",
              value: "${widget.item?.etm}"
          ),
        ],
      ),
    );
  }
}

class ContentRowInfo extends StatelessWidget {
  const ContentRowInfo({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 11
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: TextStyles.s12w400.copyWith(
                color: const Color(0xFF848484)
            ),
          ),
          Text(
            '$value',
            style: TextStyles.s12w400.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
        ],
      ),
    );
  }
}


class DraggableHeader extends StatefulWidget {
  const DraggableHeader({
    Key? key,
    required this.child,
    required this.color,
    required this.margin
  }) : super(key: key);

  final Widget child;
  final Color color;
  final bool margin;

  @override
  State<DraggableHeader> createState() => _DraggableHeaderState();
}

class _DraggableHeaderState extends State<DraggableHeader> {
  double xPos = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 38,
          width: SizerUtil.width,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: xPos,
          child: GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                xPos += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details) {
              Timer(const Duration(seconds: 2), () {
                setState(() {
                  xPos = 0.0;
                });
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(10)
              ),
              margin: widget.margin ? const EdgeInsets.symmetric(
                horizontal: 16
              ) : null,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  widget.child
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}



