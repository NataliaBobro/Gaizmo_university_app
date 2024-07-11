import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import '../../theme/text_styles.dart';

Future<void> showDeleteDialog(
    BuildContext context,
    Function onDelete
    ) async {
  await showPlatformDialog(
    context: context,
    builder: (context) => BasicDialogAlert(
      content: Text(
        getConstant('really_delete_account'),
        style: TextStyles.s17w600,
      ),
      actions: <Widget>[
        BasicDialogAction(
          title: Text(getConstant('Yes')),
          onPressed: () {
            Navigator.pop(context);
            onDelete();
          },
        ),
        BasicDialogAction(
          title: Text(getConstant('No')),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}