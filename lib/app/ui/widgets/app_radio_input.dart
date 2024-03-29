import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppRadioInput extends StatefulWidget {
  const AppRadioInput({
    Key? key,
    required this.value,
    required this.label,
    required this.onChange,
  }) : super(key: key);

  final bool? value;
  final String label;
  final Function onChange;

  @override
  State<AppRadioInput> createState() => _AppRadioInputState();
}

class _AppRadioInputState extends State<AppRadioInput> {
  bool hasOn = false;

  @override
  void initState() {
    hasOn = widget.value ?? false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: TextStyles.s14w600.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
            Switch(
              value: hasOn,
              activeColor: const Color(0xFFFFC700),
              onChanged: (bool value) {
                setState(() {
                  hasOn = value;
                  widget.onChange(value);
                });
              },
            )
          ],
        ),
        Container(
          color: const Color(0xFF848484),
          height: 1,
          width: double.infinity,
        )
      ],
    );
  }
}
