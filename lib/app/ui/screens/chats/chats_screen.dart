import 'package:european_university_app/app/ui/screens/chats/submit_chat_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/get_constant.dart';
import '../../widgets/center_header.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('Chats')
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
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 24
                              ),
                              physics: const ClampingScrollPhysics(),
                              children: const [
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
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

