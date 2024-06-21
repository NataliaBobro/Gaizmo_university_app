import 'package:european_university_app/app/ui/screens/chats/sceletons/chat_list_sceleton.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/chat_list.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/empty_message.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/list_search_users.dart';
import 'package:european_university_app/app/ui/screens/chats/widgets/search_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../resources/resources.dart';
import '../../../domain/states/chats/chats_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
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
                                const AIChat(),
                                if(state.isLoading) ...[
                                  const ChatListSceleton(),
                                ] else if(state.users != null) ...[
                                  const ListSearchUsers()
                                ] else ...[
                                  if((state.chatList?.length ?? 0) > 0) ...[
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

class AIChat extends StatefulWidget {
  const AIChat({super.key});

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatsState>();

    return CupertinoButton(
      minSize: 0.0,
      padding: EdgeInsets.zero,
      onPressed: () {
        state.openChatAssistant(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
        ).copyWith(
            bottom: 8
        ),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        Images.ai,
                        width: 50,
                        height: 70,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EU Assistant',
                          style: TextStyles.s14w500.copyWith(
                              color: AppColors.fgDefault
                          ),
                        ),
                        Text(
                          state.aiChat?.lastMessage?.message ?? '',
                          style: TextStyles.s12w400.copyWith(
                              color: AppColors.fgMuted,
                              overflow: TextOverflow.ellipsis
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
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

