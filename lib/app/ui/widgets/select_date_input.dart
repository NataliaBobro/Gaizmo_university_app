import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class SelectDateInput extends StatefulWidget {
  const SelectDateInput({
    Key? key,
    required this.onChange,
    this.errors,
    this.hintStyle,
    this.labelStyle,
    this.value,
    this.dropdownColor = Colors.black,
  }) : super(key: key);

  final Function(DateTime? date) onChange;
  final String? errors;
  final String? value;
  final Color dropdownColor;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  @override
  State<SelectDateInput> createState() => _SelectDateInputState();
}

class _SelectDateInputState extends State<SelectDateInput> {
  int? selectDate;
  int? selectYear;
  String? selectMonths;

  DateTime date = DateTime.now().add(const Duration(days: -1));

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData(){
    if(widget.value != null){
      try{
        final dateParse = widget.value?.split('-');
        // selectDate = int.parse('${dateParse?[2]}');
        // selectYear = int.parse('${dateParse?[0]}');
        // selectMonths = months.elementAt(int.parse('${dateParse?[1]}') - 1);
      } catch (e){
        print(e);
      }
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getConstant('Date_of_birth'),
              style: widget.labelStyle ?? TextStyles.s14w400.copyWith(
                  color: const Color(0xFF848484)
              ),
            ),
            CupertinoButton(
              onPressed: () => _showDialog(
                CupertinoDatePicker(
                  initialDateTime: date,
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => date = newDate);
                    widget.onChange(newDate);
                  },
                ),
              ),
              child: Text(
                '${(date.day).toString().padLeft(2, '0')}.'
                    '${(date.month).toString().padLeft(2, '0')}.'
                    '${(date.year).toString().padLeft(2, '0')}',
                style: TextStyles.s16w400.copyWith(
                  color: AppColors.appTitle,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: widget.errors == null ?
          const Color(0xFF848484) :
          AppColors.appButton,
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
                  color: AppColors.appButton
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
