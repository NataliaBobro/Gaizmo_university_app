import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';
import '../../theme/text_styles.dart';
import '../../utils/get_constant.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const Header(),
                Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 48,
                        horizontal: 40
                      ),
                      children: List.generate(
                          10, 
                          (index) => ProgressItem(
                            index: index
                          )
                      ),
                    )
                )
              ],
            ),

          )
      ),
    );
  }
}

class ProgressItem extends StatefulWidget {
  const ProgressItem({
    super.key,
    required this.index
  });

  final int index;

  @override
  State<ProgressItem> createState() => _ProgressItemState();
}

class _ProgressItemState extends State<ProgressItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.index % 2 == 0 ?
          Alignment.centerLeft :
          Alignment.centerRight,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                    Images.logoMini
                ),
              )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 18
            ),
            child: Text(
              '${getConstant('Award')} ${widget.index + 1}',
              style: TextStyles.s18w600,
            ),
          )
        ],
      ),
    );
  }
}


class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 8
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 16
            ),
            alignment: Alignment.center,
            child: Text(
              getConstant('Awards'),
              style: TextStyles.s24w700.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

