import 'dart:async';

import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../../../resources/app_firebase_messaging.dart';
import '../../../ui/screens/chats/chat_item_screen.dart';
import '../../models/chat.dart';
import '../../services/chat_service.dart';

class ChatsState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  final TextEditingController _search = TextEditingController();
  ListUserData? _users;
  bool _openClear = false;
  ChatItem? _chat;
  ListMessages? _listMessages;
  ChatListItem? _chatList;
  List<File>? _attachment;

  ChatsState(this.context){
    Future.microtask(() async {
      fetchChatList();
      initFirebase();
    });
  }

  bool get isLoading => _isLoading;
  TextEditingController get search => _search;
  ListUserData? get users => _users;
  bool get openClear => _openClear;
  ChatItem? get chat => _chat;
  ChatListItem? get chatList => _chatList;
  List<File>? get attachment => _attachment;
  ListMessages? get listMessages => _listMessages;

  void initFirebase() {
    AppFirebaseMessaging.init(this);
  }

  Future<void> fetchChatList()async {
    final user = context.read<AppState>().userData;
    if(user?.id == null) return;

      _isLoading = true;
      notifyListeners();
      try {
        final result = await ChatService.fetchChatList(context);
        if(result != null) {
          _chatList = result;
        }
      } catch (e) {
        print(e);
      } finally {
        _isLoading = false;
        notifyListeners();
      }
  }

  Future<void> openChat(BuildContext context, UserData? user, {int? chatId})async {
    notifyListeners();
      final authUser = context.read<AppState>().userData;
      openPageChat(context);
      _chat = ChatItem(
        id: chatId,
        name: '${user?.lastName ?? ''} ${user?.firstName}',
        recipients: [
          user!,
          authUser!
        ]
      );
      notifyListeners();

      try {
        final result = await ChatService.fetchChat(context, user.id, chatId);
        if(result != null) {
          _listMessages = result;
        }
      } catch (e) {
        print(e);
      } finally {
        _isLoading = false;
        notifyListeners();
      }
  }

  Future<void> openPageChat(BuildContext context) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ChatItemScreen(),
      ),
    );
  }


  Future<void> fetchSearch(String value) async {
    if (value.length < 2) {
      _users = null;
      notifyListeners();
    }
    if(_users == null){
      _isLoading = true;
      notifyListeners();
    }

    try {
      final result = await ChatService.search(context, value);
      if(result != null) {
        _users = result;
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addMessage({String? text, int? chatId, int? recipientId}) {
    int? chatUpdatedId = _chat?.id;
    int? recipientUpdateId = recipientId;

    if(recipientId == null){
      final user = context.read<AppState>().userData;
      recipientUpdateId = user?.id;
    }

    if(chatId != null){
      chatUpdatedId = chatId;
    }

    if(chatUpdatedId == _chat?.id){
      // AppFirebaseMessaging.setFirebase(false);

      _listMessages?.data?.insert(
          0,
          Messages(
              message: text,
              attachmentFile: attachment,
              userId: recipientUpdateId,
              createdAt: DateTime.now().toString()
          )
      );
    }
    final chat = _chatList?.data.where((element) => element.id == chatUpdatedId);
    if((chat?.length ?? 0) > 0){
      _chatList?.data.where((element) => element.id == chatUpdatedId).first.lastMessage?.message = text;
    }else{
      fetchChatList();
    }
    notifyListeners();
  }

  Future<void> sendMessage(String value) async {
    if (value.length < 2) {
      _users = null;
      notifyListeners();
    }
    if(_users == null){
      _isLoading = true;
      notifyListeners();
    }
    addMessage(text: value);

    try {
      final result = await ChatService.sendMessage(
          context,
          _chat?.id,
          _chat?.recipients?.first.id,
          value,
          _attachment
      );
      if(result != null){
        _chat?.lastMessage?.attachment = result.attachment;
        if(_chat?.id == null){
          fetchChatList();
          _chat?.id = result.id;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void closeClearButton() {
    if (openClear) {
      _openClear = !_openClear;
      _search.clear();
      _users = null;
      FocusScope.of(context).unfocus();
      notifyListeners();
    }
  }

  void updateChatsState(){
    _search.clear();
    _listMessages = null;
    _chatList = null;
    _chat = null;
    fetchChatList();
  }

  void openClearButton() {
    if (!openClear) {
      _openClear = !_openClear;
      notifyListeners();
    }
  }

  void clearTextField() {
    _search.clear();
    _users = null;
    notifyListeners();
  }
}