import 'package:european_university_app/app/ui/screens/chats/submit_chat_input.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/messages_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/states/chats/chats_state.dart';
import '../../utils/get_constant.dart';
import '../../widgets/center_header.dart';

class ChatItemScreen extends StatefulWidget {
  const ChatItemScreen({super.key});

  @override
  State<ChatItemScreen> createState() => _ChatItemScreenState();
}

class _ChatItemScreenState extends State<ChatItemScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatsState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: state.chat?.name ?? getConstant('Chats')
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: MessagesListView(),
                          ),
                        ),
                        const SubmitChatInput()
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}

class SearchChats extends StatefulWidget {
  const SearchChats({super.key});

  @override
  State<SearchChats> createState() => _SearchChatsState();
}

class _SearchChatsState extends State<SearchChats> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoSearchTextField();
  }
}

