import 'package:flutter/material.dart';

class ButtonGroups extends StatelessWidget {
  const ButtonGroups({Key? key, required this.childrens}) : super(key: key);

  final List<Widget> childrens;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10.0,
      spacing: 20.0,
      children: List.generate(
        childrens.length,
        (index) => childrens[index],
      ),
    );
  }
}
