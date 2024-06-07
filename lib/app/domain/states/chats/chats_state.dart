import 'package:european_university_app/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

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
  List<File>? _attachment;

  ChatsState(this.context);

  bool get isLoading => _isLoading;
  TextEditingController get search => _search;
  ListUserData? get users => _users;
  bool get openClear => _openClear;
  ChatItem? get chat => _chat;
  List<File>? get attachment => _attachment;

  Future<void> openChat(BuildContext context, UserData? user)async {
      openPageChat(context);
      _chat = ChatItem(
        name: '${user?.lastName ?? ''} ${user?.firstName}',
        recipients: [
          user!
        ]
      );
      notifyListeners();

      try {
        final result = await ChatService.fetchChat(context, user.id);
        if(result != null) {
          _chat = result;
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

  Future<void> sendMessage(String value) async {
    if (value.length < 2) {
      _users = null;
      notifyListeners();
    }
    if(_users == null){
      _isLoading = true;
      notifyListeners();
    }

    _chat?.messages?.add(Messages(
      text: value,
      attachmentFile: attachment,
    ));
    notifyListeners();

    try {
      final result = await ChatService.sendMessage(
          context,
          _chat?.id,
          _chat?.recipients?.first.id,
          value,
          _attachment
      );
      if(result != null){
        _chat?.messages?.first.attachment = result.attachment;
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