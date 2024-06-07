import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:european_university_app/app/ui/utils/input_formatters.dart';

import '../../../../../resources/resources.dart';
import '../../../theme/text_styles.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.fetchSearch,
    required this.onTap,
    required this.clearTextField,
    required this.openClear,
    required this.closeClearButton,
    this.autofocus = false,
    this.onCancelPressed,
  });

  final String placeholder;
  final TextEditingController controller;
  final Function fetchSearch;
  final Function onTap;
  final Function clearTextField;
  final Function closeClearButton;
  final bool openClear;
  final bool autofocus;
  final VoidCallback? onCancelPressed;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                autofocus: widget.autofocus,
                inputFormatters: [
                  EmojiInputFormatter(),
                  NonAsianInputFormatter(),
                ],
                autocorrect: false,
                style: TextStyles.s16w400.copyWith(
                  color: AppColors.fgDefault,
                ),
                onChanged: (val) {
                  widget.fetchSearch(val);
                },
                onTap: () {
                  widget.onTap();
                },
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  hintStyle: TextStyles.s16w400.copyWith(
                    color: const Color(0xFF828282),
                  ),
                  hintText: widget.placeholder,
                  fillColor: AppColors.accentContainerSoft.withOpacity(.05),
                  suffixIcon:
                      widget.openClear && widget.controller.text.isNotEmpty
                          ? CupertinoButton(
                              onPressed: () {
                                widget.clearTextField();
                              },
                              minSize: 0.0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset(
                                Svgs.clear,
                                width: 20,
                                height: 20,
                              ),
                            )
                          : null,
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SvgPicture.asset(
                      Svgs.search,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
              ),
            ),
            widget.openClear || widget.onCancelPressed != null
                ? Row(
                    key: UniqueKey(),
                    children: [
                      CupertinoButton(
                        minSize: 0.0,
                        padding:
                            const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                        onPressed: () {
                          if (widget.onCancelPressed != null) {
                            widget.onCancelPressed?.call();
                          } else {
                            widget.closeClearButton();
                          }
                        },
                        child: Text(
                          getConstant('Close'),
                          style: TextStyles.s15w500.copyWith(
                            color: const Color(0xFF1167C3),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
