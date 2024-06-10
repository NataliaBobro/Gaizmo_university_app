import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/states/chats/chats_state.dart';

class MessagesListView extends StatefulWidget {
  const MessagesListView({super.key});

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatsState>();
    final messages = state.listMessages?.data ?? [];

    return ListView(
      padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24
      ),
      physics: const ClampingScrollPhysics(),
      children: [
        ...List.generate(
          messages.length,
              (index) => Builder(
                builder: (BuildContext context) {
                  // final user = state.chatList?.data[index].recipients?.firstWhere((element) => element.id == messages[index].);
                  // return MessageBlock(messages: messages[index], user: user);
                  return Container();
                },
              ),
        )
      ],
    );
  }
}
