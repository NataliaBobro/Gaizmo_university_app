import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/models/chat.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/states/chats/chats_state.dart';
import '../../../theme/text_styles.dart';

class MessagesListView extends StatefulWidget {
  const MessagesListView({super.key});

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatsState>();
    final appState = context.watch<AppState>();
    final messages = state.listMessages?.data ?? [];

    return ListView(
      reverse: true,
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
                  final user = state.chat?.recipients?.firstWhere((element) => element.id == messages[index].userId);
                  bool isAuthor = appState.userData?.id ==  messages[index].userId;

                  return MessageBlock(messages: messages[index], user: user, isAuthor: isAuthor);
                },
              ),
        )
      ],
    );
  }
}


class MessageBlock extends StatefulWidget {
  const MessageBlock({
    super.key,
    required this.messages,
    required this.user,
    required this.isAuthor,
  });

  final Messages messages;
  final UserData? user;
  final bool isAuthor;

  @override
  State<MessageBlock> createState() => _MessageBlockState();
}

class _MessageBlockState extends State<MessageBlock> {
  @override
  Widget build(BuildContext context) {
    String inputDate = '${widget.messages.createdAt}';
    DateTime parsedDate = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd MMMM yyyy', 'en').format(parsedDate);
    String formattedTime = DateFormat.Hm('en').format(parsedDate);

    return Column(
      children: [
        if (!widget.isAuthor) ...[
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  color: AppColors.accentContainerSoft.withOpacity(.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  formattedDate,
                  style: TextStyles.s14w400
                      .copyWith(color: const Color(0xFF34373A)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: AppColors.accentContainerSoft.withOpacity(.05),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: widget.isAuthor
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!widget.isAuthor) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: '${widget.user?.avatar}',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MessageItemWidget(message: widget.messages, isAuthor: widget.isAuthor),
                Text(
                  formattedTime,
                  style: TextStyles.s16w400
                      .copyWith(color: const Color(0xFFA2ADB9)),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class MessageItemWidget extends StatefulWidget {
  const MessageItemWidget({
    super.key,
    required this.message,
    required this.isAuthor
  });

  final Messages message;
  final bool isAuthor;

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      constraints: BoxConstraints(maxWidth: SizerUtil.width - 128),
      decoration: BoxDecoration(
          color: widget.isAuthor
              ? AppColors.accentContainerSoft.withOpacity(.05)
              : AppColors.accentSoft,
          borderRadius: BorderRadius.only(
              topLeft: widget.isAuthor
                  ? const Radius.circular(10)
                  : Radius.zero,
              topRight: !widget.isAuthor
                  ? const Radius.circular(10)
                  : Radius.zero,
              bottomLeft: const Radius.circular(10),
              bottomRight: const Radius.circular(10))),
      padding: const EdgeInsets.all(16),
      child: Text(
        '${widget.message.message}',
        style: TextStyles.s16w400.copyWith(
            color: widget.isAuthor ? AppColors.fgMuted : Colors.white
        ),
      ),
    );
  }
}
