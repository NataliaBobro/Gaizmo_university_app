import 'dart:async';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../app/app.dart';
import '../app/domain/states/chats/chats_state.dart';
import '../app/ui/navigation/routes.dart';

class AppFirebaseMessaging {
  static Future<void> init(ChatsState read, UserData? userData) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data['action'] == 'send_message') {
        print('--------init---------111');
        int chatId = int.parse(message.data['chat_id']);
        print(chatId);
        await addMessageToChat(read, message.data);
        Timer(const Duration(milliseconds: 500), () async {
          await navigateToChat(chatId);
        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data['action'] == 'send_message') {
        print('--------init---------222');
        print(message.data);
        await addMessageToChat(read, message.data);
      }
    });

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage?.data['action'] == 'send_message') {
      print('--------init---------333');
      print(initialMessage?.data);
      await addMessageToChat(read, initialMessage?.data);
      int chatId = int.parse(initialMessage?.data['chat_id']);
      Timer(const Duration(milliseconds: 2000), () async {
        await navigateToChat(chatId);
      });
    }

    setFirebase(userData?.notifications == 1 ? true : false);
  }

  static Future<void> setFirebase(bool onShow) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: onShow,
      badge: onShow,
      sound: onShow,
    );
  }

  static Future<void> addMessageToChat(ChatsState read, data) async {
    int chatId = int.parse(data['chat_id']);
    String text = data['message'];
    int recipientId = int.parse(data['recipient_id']);
    read.addMessage(text: text, chatId: chatId, recipientId: recipientId, type: data['type']);
  }

  static Future<void> navigateToChat(int chatId) async {
    routemaster.push(AppRoutes.chats, queryParameters: {"id": '$chatId'});
  }

  static Future<void> logout() async {
    await FirebaseMessaging.instance.deleteToken();
    FirebaseMessaging.onMessage.listen(null);
    FirebaseMessaging.onMessageOpenedApp.listen(null);
  }
}