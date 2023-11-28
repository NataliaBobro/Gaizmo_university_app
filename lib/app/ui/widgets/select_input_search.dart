import 'package:etm_crm/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../theme/text_styles.dart';

class SelectInputSearch extends StatefulWidget {
  const SelectInputSearch({
    Key? key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.onSelect,
    this.isSearch = false,
    this.onSearch,
    this.selected,
    this.errors,
    this.labelStyle,
    this.style
  }) : super(key: key);

  final String title;
  final String hintText;
  final List<Map<String, dynamic>>? items;
  final Function onSelect;
  final Function? onSearch;
  final Map<String, dynamic>? selected;
  final String? errors;
  final bool isSearch;
  final TextStyle? labelStyle;
  final TextStyle? style;

  @override
  State<SelectInputSearch> createState() => _SelectInputSearchState();
}

class _SelectInputSearchState extends State<SelectInputSearch> {
  final tooltipController = JustTheController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: widget.labelStyle ?? TextStyles.s14w400.copyWith(
              color: const Color(0xFF848484)
          ),
        ),
        CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.selected != null ? widget.selected!['name'] : '',
                    style: widget.style ?? TextStyles.s14w400.copyWith(
                        color: Colors.white
                    ),
                  ),
                ),
                SvgPicture.asset(
                    Svgs.openSelect
                )
              ],
            ),
            onPressed: () {
              tooltipController.showTooltip();
            }
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: widget.errors == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
        ),
        if(widget.errors != null) ...[
          Container(
            padding: const EdgeInsets.only(
                top: 4
            ),
            alignment: Alignment.centerRight,
            child: Text(
              '${widget.errors}',
              style: TextStyles.s12w400.copyWith(
                  color: const Color(0xFFFFC700)
              ),
            ),
          ),
        ],
        SelectSearchJustTheTooltip(
          tooltipController: tooltipController,
          items: widget.items,
          onSelect: (value) {
            widget.onSelect(value);
          },
        ),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }
}

class SelectSearchJustTheTooltip extends StatefulWidget {
  const SelectSearchJustTheTooltip({
    Key? key,
    required this.tooltipController,
    required this.onSelect,
    this.items,
  }) : super(key: key);

  final List<Map<String, dynamic>>? items;
  final Function onSelect;
  final JustTheController tooltipController;

  @override
  State<SelectSearchJustTheTooltip> createState() => _SelectSearchJustTheTooltipState();
}

class _SelectSearchJustTheTooltipState extends State<SelectSearchJustTheTooltip> {
  @override
  void initState() {
    super.initState();
  }
  Path _customTailBuilder() {
    return Path()..close();
  }

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      margin: const EdgeInsets.symmetric(
        horizontal: 24
      ),
      borderRadius: BorderRadius.circular(20),
      isModal: true,
      tailBuilder: (_, __, ___) => _customTailBuilder(),
      controller: widget.tooltipController,
      content: SizedBox(
        key: ValueKey(widget.items),
        width: double.infinity,
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              widget.items?.length ?? 0 ,
                  (index) => CupertinoButton(
                  minSize: 0.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 24
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Text(
                      '${widget.items![index]['name']}',
                      style: TextStyles.s14w400.copyWith(
                          color: Colors.black
                      ),
                    ),
                  ),
                  onPressed: () {
                    widget.onSelect(widget.items![index]);
                    widget.tooltipController.hideTooltip();
                  }
              )
          ),
        ),
      ),
      child: Material(
        color: Colors.grey.shade800,
        shape: const CircleBorder(),
        elevation: 4.0,
      ),
    );
  }
}

class RenderList extends StatelessWidget {
  const RenderList({
    Key? key,
    required this.items,
    required this.tooltipController,
    required this.onSelect,

  }) : super(key: key);

  final  List<Map<String, dynamic>>? items;
  final  JustTheController tooltipController;
  final  Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          items?.length ?? 0 ,
          (index) => CupertinoButton(
          minSize: 0.0,
          padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 24
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: Text(
              '${items![index]['name']}',
              style: TextStyles.s14w400.copyWith(
                  color: Colors.black
              ),
            ),
          ),
          onPressed: () {
            onSelect(items![index]);
            tooltipController.hideTooltip();
          }
      )
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    required this.onSearch
  }) : super(key: key);

  final Function onSearch;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 24
      ),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: Color(0xFF848484)
              )
          )
      ),
      child: TextField(
        onChanged: (value) {
          widget.onSearch(value);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            hintText: 'Search',
            hintStyle: TextStyles.s14w400.copyWith(
                color: const Color(0xFFACACAC)
            )
        ),
      ),
    );
  }
}


