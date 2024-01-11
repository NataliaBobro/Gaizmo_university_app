import 'package:cached_network_image/cached_network_image.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../resources/resources.dart';
import '../theme/text_styles.dart';

class ToolTipOnAdd extends StatefulWidget {
  const ToolTipOnAdd({
    Key? key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.onSelect,
    this.isOpen = false,
    this.onSearch,
    this.changeOpen,
    this.errors,
    this.titleStyle,
    this.style,
    this.selected,
    required this.onAdd
  }) : super(key: key);

  final String title;
  final String hintText;
  final UserData? selected;
  final Function onSelect;
  final List<UserData>? items;
  final Function? onSearch;
  final Function? changeOpen;
  final Function onAdd;

  final String? errors;
  final bool isOpen;
  final TextStyle? titleStyle;
  final TextStyle? style;

  @override
  State<ToolTipOnAdd> createState() => _ToolTipOnAddState();
}

class _ToolTipOnAddState extends State<ToolTipOnAdd> {
  JustTheController tooltipController = JustTheController();
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
          minSize: 0.0,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.selected != null ? "${widget.selected!.firstName}" : '',
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
        if(widget.isOpen) ...[
          SizedBox(
            height: 326,
            child: SelectSearch(
                items: widget.items ?? [],
                onSelect: (value) {
                  widget.onSelect(value);
                },
                onSearch: (value) {
                  if(widget.onSearch != null){
                    widget.onSearch!(value);
                  }
                },
              onAdd: () {
                  widget.onAdd();
              },
            ),
          )
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
    required this.items,
    this.isSearch = false,
    this.onSearch,
    required this.onAdd
  }) : super(key: key);

  final List<UserData> items;
  final Function onSelect;
  final Function? onSearch;
  final bool isSearch;
  final Function onAdd;

  @override
  State<SelectSearch> createState() => _SelectSearchState();
}

class _SelectSearchState extends State<SelectSearch> {
  String? search;

  List<UserData> searchByName(List<UserData> users, String searchName) {
    return users
        .where((user) =>
    user.firstName != null &&
        user.firstName!.toLowerCase().contains(searchName.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<UserData> items = widget.items;
    if(search != null){
      items = searchByName(widget.items, search!);
    }
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
              search = value;
              setState(() {});
            },
          ),
          CupertinoButton(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFC700),
                    borderRadius: BorderRadius.circular(100)
                ),
                child: SvgPicture.asset(
                  Svgs.plus,
                  width: 32,
                ),
              ),
              onPressed: () {
                widget.onAdd();
              }
          ),
          Expanded(
            child: ListView(
              children: [
                ...List.generate(
                    items.length,
                        (index) => CupertinoButton(
                        minSize: 0.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 24
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: items[index].avatar != null ?
                                CachedNetworkImage(
                                  imageUrl: '${items[index].avatar}',
                                  width: 24,
                                  errorWidget: (context, error, stackTrace) =>
                                  const SizedBox.shrink(),
                                  fit: BoxFit.cover,
                                ) : Container(
                                  width: 24,
                                  height: 24,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${widget.items[index].firstName}',
                                style: TextStyles.s14w400.copyWith(
                                    color: Colors.black
                                ),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          widget.onSelect(widget.items[index]);
                        }
                    )
                )
              ],
            ),
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

