import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<AppState>().userData;
    return ListView(
      padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24
      ),
      children: [
        CharItem(
          value: 80,
          label: "Balance",
          valueStr: "${userData?.balanceEtm} ETM",
          color: 0xFFC2C4F9,
        ),
        CharItem(
          value: 80,
          label: "My rating",
          valueStr: "Better than 50% users",
          color: 0xFFBCF3A9,
        ),
      ],
    );
  }
}

class CharItem extends StatefulWidget {
  const CharItem({
    Key? key,
    required this.value,
    required this.label,
    required this.valueStr,
    required this.color
  }) : super(key: key);

  final int value;
  final String label;
  final String valueStr;
  final int color;

  @override
  State<CharItem> createState() => _CharItemState();
}

class _CharItemState extends State<CharItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyles.s12w600.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: SizerUtil.width - 40
          ),
          child: Row(
            children: [
              Container(
                  width: widget.value.toDouble(),
                  height: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(widget.color)
                  )
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                widget.valueStr,
                style: TextStyles.s12w600.copyWith(
                    color: const Color(0xFF242424)
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

