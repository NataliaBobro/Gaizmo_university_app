import 'package:european_university_app/app/ui/screens/chats/sceletons/chat_list_sceleton.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/chat_list.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/empty_message.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/list_search_users.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/search_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/states/chats/chats_state.dart';
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
    final state = context.watch<ChatsState>();

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
                              physics: const ClampingScrollPhysics(),
                              children: [
                                SearchInput(
                                  placeholder: getConstant('Search'),
                                  controller: state.search,
                                  fetchSearch: (val) {
                                    state.fetchSearch(val);
                                  },
                                  onTap: () {
                                    state.openClearButton();
                                  },
                                  clearTextField: () {
                                    state.clearTextField();
                                  },
                                  openClear: state.openClear,
                                  closeClearButton: () {
                                    state.closeClearButton();
                                  },
                                ),
                                if(state.isLoading) ...[
                                  const ChatListSceleton(),
                                ] else if(state.users != null) ...[
                                  const ListSearchUsers()
                                ] else ...[
                                  if(state.chatList?.data != null) ...[
                                    const ChatList()
                                  ]else ...[
                                    const EmptyMessage()
                                  ]
                                ]
                              ],
                            ),
                          ),
                        ),
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

