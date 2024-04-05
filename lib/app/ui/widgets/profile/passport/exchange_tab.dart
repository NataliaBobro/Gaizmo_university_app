import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../resources/resources.dart';
import '../../../theme/text_styles.dart';
import '../../custom_scroll_physics.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24
      ),
      physics: const BottomBouncingScrollPhysics(),
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 24
              ),
              child: Text(
                getConstant('Today'),
                style: TextStyles.s14w600.copyWith(
                    color: const Color(0xFF242424)
                ),
              ),
            ),
            const ExchangeItemList()
          ],
        )
      ],
    );
  }
}

class ExchangeItemList extends StatelessWidget {
  const ExchangeItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: 12
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 16,
          mainAxisExtent: 151
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ExchangeItem();
      },
    );
  }
}

class ExchangeItem extends StatelessWidget {
  const ExchangeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: 151,
          height: 151,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    Images.testExchange,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'EU/USD',
                    style: TextStyles.s8w600.copyWith(
                      color: Colors.black
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: SvgPicture.asset(
              Svgs.char
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: -16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      right: 24,
                      left: 24
                    ),
                    child: Text(
                      '\$25.345',
                      style: TextStyles.s14w600.copyWith(
                          color: Colors.black
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Text(
                      '+0,2%',
                      style: TextStyles.s8w500.copyWith(
                        color: const Color(0xFF27AE60)
                      ),
                    ),
                  )
                ],
              ),
              Text(
                'Last 24 hour',
                style: TextStyles.s8w500.copyWith(
                  color: const Color(0xFFACACAC)
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
