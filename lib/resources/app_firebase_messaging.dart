import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../app/app.dart';
import '../app/domain/states/chats/chats_state.dart';
import '../app/ui/navigation/routes.dart';

class AppFirebaseMessaging {
  static Future<void> init(ChatsState read) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('-onMessageOpenedApp----');
      print(message.data);
      if (message.data['action'] == 'send_message') {
        String chatId = message.data['chat_id'];
        Timer(const Duration(milliseconds: 500), () async {
          await navigateToChat(chatId);
        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data['action'] == 'send_message') {
        int chatId = int.parse(message.data['chat_id']);
        String text = message.data['message'];
        int recipientId = int.parse(message.data['recipient_id']);
        await addMessageToChat(read, chatId, recipientId, text);
      }
    });

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage?.data['action'] == 'send_message') {
      String chatId = initialMessage?.data['chat_id'];
      Timer(const Duration(milliseconds: 2000), () async {
        await navigateToChat(chatId);
      });
    }

    setFirebase(true);
  }

  static Future<void> setFirebase(bool onShow) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: onShow,
      badge: onShow,
      sound: onShow,
    );
  }

  static Future<void> addMessageToChat(ChatsState read, int chatId, recipientId, text) async {
    read.addMessage(text: text, chatId: chatId, recipientId: recipientId);
  }

  static Future<void> navigateToChat(String chatId) async {
    routemaster.push(AppRoutes.chats, queryParameters: {"id": chatId});
  }

  static Future<void> logout() async {
    await FirebaseMessaging.instance.deleteToken();
    FirebaseMessaging.onMessage.listen(null);
    FirebaseMessaging.onMessageOpenedApp.listen(null);
  }
}