import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SheetTopLine extends StatelessWidget {
  const SheetTopLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 34
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: const Color(0xFFC4C4C4).withOpacity(.21)
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 2,
            decoration: const BoxDecoration(
                color: Color(0xFFC4C4C4)
            ),
          ),
        ],
      )
    );
  }
}
