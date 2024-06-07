import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../app/app.dart';
import '../app/ui/navigation/routes.dart';


class AppFirebaseMessaging{
  static Future<void> init() async {

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message);
      if (message.data['action'] == 'new_message') {
        String chatId = message.data['chat_id'];
          Timer(const Duration(milliseconds: 500), () async {
            await navigateToChat(chatId);
          });
      }
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage?.data['action'] == 'new_message') {
      print(initialMessage?.data);
      String chatId = initialMessage?.data['chat_id'];
      Timer(const Duration(milliseconds: 2000), () async {
        await navigateToChat(chatId);
      });
    }
  }

  static Future<void> navigateToChat(String chatId) async {
    routemaster.push(AppRoutes.chats, queryParameters: {
      "id": chatId
    });
  }
}