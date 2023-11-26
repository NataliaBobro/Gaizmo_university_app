import 'package:etm_crm/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../theme/text_styles.dart';

class SelectInputSearchField extends StatefulWidget {
  const SelectInputSearchField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.onSelect,
    this.isOpen = false,
    this.onSearch,
    this.changeOpen,
    this.selected,
    this.errors,
    this.titleStyle,
    this.style
  }) : super(key: key);

  final String title;
  final String hintText;
  final List<Map<String, dynamic>>? items;
  final Function onSelect;
  final Function? onSearch;
  final Function? changeOpen;
  final Map<String, dynamic>? selected;
  final String? errors;
  final bool isOpen;
  final TextStyle? titleStyle;
  final TextStyle? style;

  @override
  State<SelectInputSearchField> createState() => _SelectInputSearchFieldState();
}

class _SelectInputSearchFieldState extends State<SelectInputSearchField> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: widget.titleStyle ?? TextStyles.s14w400.copyWith(
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
              widget.changeOpen!();
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
        if(widget.isOpen == true) ...[
          SelectSearch(
              items: widget.items,
              onSelect: (value) {
                widget.onSelect(value);
              },
              onSearch: (value) {
                if(widget.onSearch != null){
                  widget.onSearch!(value);
                }
              }
          ),
        ],
        const SizedBox(
          height: 24,
        )
      ],
    );
  }
}

class SelectSearch extends StatefulWidget {
  const SelectSearch({
    Key? key,
    required this.onSelect,
    this.items,
    this.isSearch = false,
    this.onSearch,
  }) : super(key: key);

  final List<Map<String, dynamic>>? items;
  final Function onSelect;
  final Function? onSearch;
  final bool isSearch;

  @override
  State<SelectSearch> createState() => _SelectSearchState();
}

class _SelectSearchState extends State<SelectSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
      ),
      width: double.infinity,
      child: Column(
        children: [
          SearchField(
            onSearch: (value) {
              widget.onSearch!(value);
            },
          ),
          ...List.generate(
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
                  }
              )
          )

        ],
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


