import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/states/chats/chats_state.dart';
import '../../../theme/app_colors.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}
class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatsState>();
    final appState = context.watch<AppState>();
    return Column(
      children: [
        ...List.generate(
            state.chatList?.length ?? 0,
            (index) {
              final user = state.chatList?[index].recipients?.firstWhere((element) => element.id != appState.userData?.id);
              return CupertinoButton(
                minSize: 0.0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  state.openChat(context, user, chatId: state.chatList?[index].id);
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
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              children: [
                                if(user?.avatar != null) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xFF7D838A)
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.accentContainerSoft.withOpacity(.05),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: '${user?.avatar}',
                                        width: 60,
                                        height: 65,
                                        errorWidget: (context, error, stackTrace) =>
                                        const SizedBox.shrink(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ] else ...[
                                  Container(
                                    width: 60,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xFF7D838A)
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.accentContainerSoft.withOpacity(.05),
                                    ),
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        List<String> nameParts = ('${user?.firstName ?? ''}'
                                            ' ${user?.lastName ?? ''}').split(' ');

                                        String initials = '';
                                        for (var part in nameParts) {
                                          if (part.isNotEmpty) {
                                            initials += part[0];
                                          }
                                        }
                                        return Center(
                                          child: Text(
                                            initials,
                                            style: TextStyles.s18w500,
                                          ),
                                        );
                                      },

                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                                    style: TextStyles.s14w500.copyWith(
                                        color: AppColors.fgDefault
                                    ),
                                  ),
                                  Text(
                                    state.chatList?[index].lastMessage?.message ?? '',
                                    style: TextStyles.s12w400.copyWith(
                                        color: AppColors.fgMuted
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
        )
      ],
    );
  }
}
