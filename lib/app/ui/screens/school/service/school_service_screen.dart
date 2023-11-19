import 'dart:async';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:etm_crm/app/domain/models/services.dart';
import 'package:etm_crm/app/domain/states/school/school_services_state.dart';
import 'package:etm_crm/app/ui/screens/school/service/widgets/services_header.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';

class SchoolServicesScreen extends StatefulWidget {
  const SchoolServicesScreen({Key? key}) : super(key: key);

  @override
  State<SchoolServicesScreen> createState() => _SchoolServicesScreenState();
}

class _SchoolServicesScreenState extends State<SchoolServicesScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolServicesState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const ServicesHeader(),
              if(state.servicesCategory.isNotEmpty || state.allServices.isNotEmpty) ...[
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      EmptyWidget(
                          isEmpty: false,
                          onPress: () {
                            state.openAddService();
                          }
                      ),
                      ...List.generate(
                          state.servicesCategory.length,
                          (index) => Accordion(
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
                              children: [
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
                                  ),
                                  content: ElementCategoryItem(
                                    item: state.servicesCategory[index].services,
                                    categoryIndex: index,
                                    margin: false
                                  ),
                                )
                              ]
                          )
                      ),
                      if(state.allServices.isNotEmpty) ...[
                        ...List.generate(
                          state.allServices.length,
                          (index) => ElementCategoryItem(
                            item: [state.allServices[index]],
                            categoryIndex: state.servicesCategory.length + index,
                          ),
                        )
                      ]
                    ],
                  ),
                )
              ] else ...[
                Expanded(
                  child: EmptyWidget(
                    title: 'No services yet :(',
                    subtitle: 'Click the button below to add services!',
                    isEmpty: state.servicesCategory.isEmpty && !state.isLoading,
                    onPress: () {
                      state.openAddService();
                    }
                  ),
                )
              ]
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
    this.margin = true,

  }) : super(key: key);

  final List<ServicesModel?>? item;
  final int? categoryIndex;
  final bool margin;

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
        paddingListHorizontal: 0.0,
        flipRightIconIfOpen: false,
        headerPadding: EdgeInsets.zero,
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
              isOpen: false,
              headerBackgroundColor: Colors.transparent,
              // Color(int.parse('${services[index]?.color}')).withOpacity(.6),
              contentVerticalPadding: 0,
              contentBorderWidth: 0,
              contentHorizontalPadding: widget.margin ? 16 : 0,
              contentBackgroundColor: const Color(0xFFF0F3F6),
              header: DraggableHeader(
                margin: widget.margin,
                color: Color(int.parse('${services[index]?.color}')).withOpacity(.6),
                child: SizedBox(
                  width: SizerUtil.width - (widget.margin ? 63 : 33),
                  child: Text(
                    itemName,
                    style: TextStyles.s14w600.copyWith(
                        color: const Color(0xFF242424)
                    ),
                  ),
                ),
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
    final duration = widget.item?.duration ?? 0;
    int durationHours = duration ~/ 60;
    int durationMinutes = duration % 60;

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
          ContentRowInfo(
            title: "Teacher",
            value: "${widget.item?.teacher?.firstName} ${widget.item?.teacher?.lastName}"
          ),
          const ContentRowInfo(
              title: "Branch",
              value: "All branches"
          ),
          const ContentRowInfo(
              title: "Number of students",
              value: "0"
          ),
          ContentRowInfo(
              title: "Validity",
              value: "${widget.item?.validity} ${widget.item?.validityType}"
          ),
          ContentRowInfo(
              title: "Service duration",
              value: (durationHours > 0 ? "$durationHours hour" : '') +
                  (durationMinutes > 0 ? " $durationMinutes minutes" : '')
          ),
          ContentRowInfo(
              title: "Cost",
              value: "${widget.item?.cost} ${widget.item?.currency?.symbol}"
          ),
          ContentRowInfo(
              title: "ETM",
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



