import 'package:etm_crm/resources/app_firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('constants');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppFirebaseMessaging.init();

  runApp(const App());
}
