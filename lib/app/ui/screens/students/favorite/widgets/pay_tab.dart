import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/student/favorite_state.dart';
import '../../../school/service/school_service_screen.dart';
import 'favorite_tab.dart';

class PayTab extends StatefulWidget {
  const PayTab({Key? key}) : super(key: key);

  @override
  State<PayTab> createState() => _PayTabState();
}

class _PayTabState extends State<PayTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavoriteState>();
    final services = state.payLessons?.services ?? [];

    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Accordion(
            onDelete: (index) {
              state.deleteFavorite(context, services[index], true);
            },
            isFullActionButton: true,
            paddingListTop: 0.0,
            disableScrolling: true,
            headerBorderWidth: 0,
            contentBorderWidth: 0,
            headerBorderRadius: 15,
            scaleWhenAnimating: false,
            openAndCloseAnimation: true,
            paddingListHorizontal: 16,
            paddingListBottom: 0.0,
            flipRightIconIfOpen: false,
            headerPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16
            ),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: List.generate(
                services.length,
                    (index) => AccordionSection(
                  isOpen: false,
                  headerBackgroundColor:
                  Color(int.parse('${services[index]?.color}')).withOpacity(.6),
                  contentVerticalPadding: 0,
                  rightIcon: Container(),
                  contentBorderWidth: 0,
                  contentHorizontalPadding: 0.0,
                  contentBackgroundColor: const Color(0xFFF0F3F6),
                  header: HeaderFavorite(
                      service: services[index]
                  ),
                  content: ContentService(
                      item: services[index]
                  ),
                )
            )
        )
      ],
    );
  }
}

