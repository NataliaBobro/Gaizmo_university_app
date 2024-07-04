import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/states/chats/chats_state.dart';
import '../../../theme/app_colors.dart';

class ListSearchUsers extends StatefulWidget {
  const ListSearchUsers({super.key});

  @override
  State<ListSearchUsers> createState() => _ListSearchUsersState();
}

class _ListSearchUsersState extends State<ListSearchUsers> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatsState>();
    return Column(
      children: [
        ...List.generate(
            state.users?.users.length ?? 0,
            (index) => CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                state.openChat(context, state.users?.users[index]);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                ).copyWith(
                    bottom: 8
                ),
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              if(state.users?.users[index].avatar != null) ...[
                                CachedNetworkImage(
                                  imageUrl: '${state.users?.users[index].avatar}',
                                  width: 60,
                                  height: 60,
                                  errorWidget: (context, error, stackTrace) =>
                                  const SizedBox.shrink(),
                                  fit: BoxFit.cover,
                                )
                              ] else ...[
                                Container(
                                  width: 60,
                                  height: 60,
                                  color: AppColors.accentContainerSoft.withOpacity(.05),
                                )
                              ]
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.users?.users[index].firstName ?? ''} ${state.users?.users[index].lastName ?? ''}',
                                  style: TextStyles.s14w500.copyWith(
                                    color: AppColors.fgDefault
                                  ),
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
            )
        )
      ],
    );
  }
}
