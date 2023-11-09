import 'package:flutter/material.dart';

class CustomDivider extends StatefulWidget {
  const CustomDivider({
    Key? key,
    this.isError = false
  }) : super(key: key);

  final bool isError;

  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: widget.isError ?
        const Color(0xFFEB5757) :
        const Color(0xFFC4C4C4).withOpacity(.21),
    );
  }
}
