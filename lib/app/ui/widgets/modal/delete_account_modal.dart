import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../theme/text_styles.dart';

Future<void> showDeleteDialog(BuildContext context) async {
  await showPlatformDialog(
    context: context,
    builder: (context) => BasicDialogAlert(
      content: const Text(
        "Do you really want\n to delete account?",
        style: TextStyles.s17w600,
      ),
      actions: <Widget>[
        BasicDialogAction(
          title: const Text("Yes"),
          onPressed: () {
            Navigator.pop(context);
            context.read<AppState>().deleteAccount();
          },
        ),
        BasicDialogAction(
          title: const Text("No"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}