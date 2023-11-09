import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../resources/resources.dart';
import '../theme/text_styles.dart';

class SelectDateInput extends StatefulWidget {
  const SelectDateInput({
    Key? key,
    required this.onChange,
    this.errors,
  }) : super(key: key);

  final Function(int? day, String? mon, int? year) onChange;
  final String? errors;

  @override
  State<SelectDateInput> createState() => _SelectDateInputState();
}

class _SelectDateInputState extends State<SelectDateInput> {
  int? selectDate;
  int? selectYear;
  String? selectMonths;

  final List<String> months = List.generate(12, (index) {
    final month = DateTime(2023, index + 1);
    return DateFormat.MMMM().format(month);
  });
  final List<int> date = List.generate(31, (index) {
    return index + 1;
  });
  final List<int> year = List.generate(DateTime.now().year - 1970, (index) {
    return 1970 + index;
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of birth',
          style: TextStyles.s14w400.copyWith(
              color: const Color(0xFF848484)
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    icon: SvgPicture.asset(
                      Svgs.openSelect,
                      width: 20,
                    ),
                    hint: Text(
                      'Date',
                      style: TextStyles.s14w400.copyWith(
                          color: Colors.white
                      ),
                    ),
                    dropdownColor: Colors.black,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                          maxHeight: 25
                      ),
                      fillColor: Colors.transparent,

                    ),
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    items: date
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          '$e',
                          style: TextStyles.s14w400.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectDate = value;
                      });
                      widget.onChange(
                          selectDate, selectMonths, selectYear
                      );
                    },
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: widget.errors == null ?
                      const Color(0xFF848484) : const Color(0xFFFFC700),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    icon: SvgPicture.asset(
                      Svgs.openSelect,
                      width: 20,
                    ),
                    hint: Text(
                      'Mounth',
                      style: TextStyles.s14w400.copyWith(
                          color: Colors.white
                      ),
                    ),
                    dropdownColor: Colors.black,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                          maxHeight: 25
                      ),
                      fillColor: Colors.transparent,

                    ),
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    items: months
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyles.s14w400.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectMonths = value;
                      });
                      widget.onChange(
                          selectDate, selectMonths, selectYear
                      );
                    },
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: widget.errors == null ?
                    const Color(0xFF848484) : const Color(0xFFFFC700),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    icon: SvgPicture.asset(
                      Svgs.openSelect,
                      width: 20,
                    ),
                    hint: Text(
                      'Year',
                      style: TextStyles.s14w400.copyWith(
                          color: Colors.white
                      ),
                    ),
                    dropdownColor: Colors.black,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                          maxHeight: 25
                      ),
                      fillColor: Colors.transparent,

                    ),
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    items: year
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          '$e',
                          style: TextStyles.s14w400.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectYear = value;
                      });
                      widget.onChange(
                          selectDate, selectMonths, selectYear
                      );
                    },
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: widget.errors == null ?
                    const Color(0xFF848484) : const Color(0xFFFFC700),
                  ),
                ],
              ),
            ),
          ],
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
      ],
    );
  }
}
