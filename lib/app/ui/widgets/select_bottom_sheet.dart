import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class SelectBottomSheet extends StatelessWidget {
  const SelectBottomSheet({
    Key? key,
    required this.list,
    required this.title,
    required this.onPress
  }) : super(key: key);

  final List<String> list;
  final String title;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 14
            ),
            child: Text(
              title,
              style: TextStyles.s14w400.copyWith(
                  color: Colors.black
              ),
            ),
          ),
          ...List.generate(
              list.length,
                  (index) => CupertinoButton(
                minSize: 0.0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  onPress!(index);
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  // color: state.selectLang == index ?
                  // const Color.fromRGBO(36, 36, 36, 0.30) :
                  // null,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14
                  ),
                  child: Text(
                    getConstant(list[index]),
                    style: TextStyles.s14w400.copyWith(
                        color: Colors.black
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
