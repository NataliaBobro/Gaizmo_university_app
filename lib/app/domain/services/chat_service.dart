import 'package:dio/dio.dart';
import 'dart:io';
import 'package:european_university_app/app/domain/models/chat.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../../data/api_client.dart';
import '../../ui/utils/get_token.dart';

class ChatService {
  static Future<ListUserData?> search(
      BuildContext context,
      String? query
      ) async {

    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/chats/search',
      queryParameters: {
        'q': query
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListUserData.fromJson(data);
  }

  static Future<ListMessages?> fetchChat(
      BuildContext context,
      int? userId,
      int? chatId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/chats/fetch-chat-message',
      queryParameters: {
        'user_id': userId,
        'chat_id': chatId,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListMessages.fromJson(data);
  }

  static Future<ListMessages?> fetchChatAi(
      BuildContext context,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/chats/fetch-chat-message-ai',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListMessages.fromJson(data);
  }

  static Future<ChatListItem?> fetchChatList(BuildContext context,) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/chats/list',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ChatListItem.fromJson(data);
  }

  static Future<Messages?> sendMessage(
      BuildContext context,
      int? chatId,
      int? recipientId,
      String? value,
      List<File>? attachment,
      ) async {

    final token = getToken(context);
    if(token == null) return null;

    FormData formData = FormData();
    if(chatId != null){
      formData.fields.add(MapEntry('chat_id', '$chatId'));
    }
    if(recipientId != null){
      formData.fields.add(MapEntry('recipient_id', '$recipientId'));
    }
    formData.fields.add(MapEntry('message', '$value'));

    if(attachment != null) {
      for (var a = 0; a < attachment.length; a++){
        formData.files.add(
          MapEntry('attachments[]', await MultipartFile.fromFile(attachment[a].path),),
        );
      }
    }

    final response = await ApiClient().dio.post(
      '/chats/send-message',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: formData
    );
    final data = response.data as Map<String, dynamic>;
    return Messages.fromJson(data);
  }
}
