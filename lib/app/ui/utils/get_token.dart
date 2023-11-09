import 'package:etm_crm/app/ui/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../app.dart';

String? getToken(BuildContext context) {
  final token = Hive.box('settings').get('token', defaultValue: null);
  if (token == null) {
    showMessage('Token is incorrect please auth again!');
    context.read<AppState>().onLogout();
    return null;
  }
  return token;
}
