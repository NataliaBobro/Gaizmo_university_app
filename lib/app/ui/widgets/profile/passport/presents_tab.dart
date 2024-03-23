import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';

import '../../../../../../resources/resources.dart';
import '../../../theme/text_styles.dart';
import '../../custom_scroll_physics.dart';

class PresentsScreen extends StatelessWidget {
  const PresentsScreen({Key? key}) : super(key: key);

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
                getConstant('Presents'),
                style: TextStyles.s14w600.copyWith(
                    color: const Color(0xFF242424)
                ),
              ),
            ),
            const PresentsItemList()
          ],
        )
      ],
    );
  }
}

class PresentsItemList extends StatelessWidget {
  const PresentsItemList({Key? key}) : super(key: key);

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
          crossAxisSpacing: 25,
          mainAxisSpacing: 16,
          mainAxisExtent: 179
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const PresentsItem();
      },
    );
  }
}

class PresentsItem extends StatelessWidget {
  const PresentsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 151,
          height: 151,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          child: ClipRRect(
            child: Image.asset(
              Images.testPresents,
              width: 151,
              height: 151,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'T-shirt',
              style: TextStyles.s10w600.copyWith(
                color: const Color(0xFF242424)
              ),
            ),
            Text(
              '100 ETM',
              style: TextStyles.s10w600.copyWith(
                  color: const Color(0xFF242424)
              ),
            )
          ],
        )
      ],
    );
  }
}
