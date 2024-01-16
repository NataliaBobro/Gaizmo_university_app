import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderSearchField extends StatelessWidget {
  const HeaderSearchField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14
        ),
        child: CupertinoSearchTextField(
          autofocus: true,
          controller: controller,
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ),
    );
  }
}
