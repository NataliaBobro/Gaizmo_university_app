import 'package:european_university_app/app/ui/utils/get_constant.dart';
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

class PresentsItemList extends StatefulWidget {
  const PresentsItemList({Key? key}) : super(key: key);

  @override
  State<PresentsItemList> createState() => _PresentsItemListState();
}

class _PresentsItemListState extends State<PresentsItemList> {

  final list = [
    {
      'image': Images.testPresents,
      'name': 'T-shirt',
    },
    {
      'image': Images.cap,
      'name': 'Cap',
    },
    {
      'image': Images.mug,
      'name': 'Mug',
    },
    {
      'image': Images.note,
      'name': 'Note',
    },
    {
      'image': Images.testPresents,
      'name': 'T-shirt',
    },
    {
      'image': Images.cap,
      'name': 'Cap',
    }
  ];
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
      itemCount: list.length,
      itemBuilder: (context, index) {
        return PresentsItem(
          item: list[index]
        );
      },
    );
  }
}

class PresentsItem extends StatelessWidget {
  const PresentsItem({
    Key? key,
    required this.item
  }) : super(key: key);

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 151,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          child: ClipRRect(
            child: Image.asset(
              '${item['image']}',
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
              '${item['name']}',
              style: TextStyles.s10w600.copyWith(
                color: const Color(0xFF242424)
              ),
            ),
            Text(
              '100 EU',
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
