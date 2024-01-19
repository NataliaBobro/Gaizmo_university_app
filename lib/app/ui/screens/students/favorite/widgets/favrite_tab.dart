import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:etm_crm/app/domain/models/services.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/student/favorite_state.dart';
import '../../profile/widgets/service_item_content.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({Key? key}) : super(key: key);

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavoriteState>();
    final services = state.favoriteLessons?.services ?? [];

    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Accordion(
            onDelete: (index) {
              state.deleteFavorite(services[index]);
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
                  rightIcon: PayButton(
                      service: services[index]
                  ),
                  contentBorderWidth: 0,
                  contentHorizontalPadding: 0.0,
                  contentBackgroundColor: const Color(0xFFF0F3F6),
                  header: HeaderFavorite(
                    service: services[index]
                  ),
                  content: ServiceItemContent(
                      service: services[index]
                  ),
                )
            )
        )
      ],
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({
    Key? key,
    required this.service
  }) : super(key: key);

  final ServicesModel? service;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0.0,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFC700),
          borderRadius: BorderRadius.circular(50)
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 4
        ),
        child: Text(
          'PAY',
          style: TextStyles.s14w600.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      onPressed: () {}
    );
  }
}


class HeaderFavorite extends StatelessWidget {
  const HeaderFavorite({
    Key? key,
    required this.service
  }) : super(key: key);

  final ServicesModel? service;

  @override
  Widget build(BuildContext context) {
    final currency = service?.currency?.name;
    final cost = service?.cost;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${service?.name}",
          style: TextStyles.s14w600.copyWith(
            color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '$cost $currency / 1 lesson 100 $currency',
          style: TextStyles.s12w400.copyWith(
              color: const Color(0xFF848484)
          ),
        )
      ],
    );
  }
}

