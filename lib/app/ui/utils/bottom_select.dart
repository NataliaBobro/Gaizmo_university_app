import 'package:flutter/material.dart';

import '../widgets/select_bottom_sheet.dart';

Future<void> openShowBottomSelect(
    BuildContext context,
    String title,
    List<String> list,
    {
      Function? onPress
    }
    ) async {
  await showModalBottomSheet(
    context: context,
    enableDrag: true,
    isDismissible: true,
    useRootNavigator: true,
    barrierColor: Colors.black.withOpacity(.75),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (_) {
      final height = (list.length * 48) + 68;
      return SizedBox(
        height: height.toDouble(),
        child: SelectBottomSheet(
            list: list,
            title: title,
            onPress: onPress
        ),
      );
    },
  );
}