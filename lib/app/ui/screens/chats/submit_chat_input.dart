import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/resources.dart';
import '../../../domain/states/chats/chats_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';

class SubmitChatInput extends StatefulWidget {
  const SubmitChatInput({super.key});

  @override
  State<SubmitChatInput> createState() => _SubmitChatInputState();
}

class _SubmitChatInputState extends State<SubmitChatInput> {
  TextEditingController message = TextEditingController();
  String value = '';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatsState>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.appButton.withOpacity(.1),
        ),
        Container(
          color: AppColors.appButton.withOpacity(0.04),
          child: Column(
            children: [
              const SizedBox(height: 8),
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 8),
                physics: const NeverScrollableScrollPhysics(),
                child: Row(
                  children: [
                    CupertinoButton(
                        minSize: 0.0,
                        padding: const EdgeInsets.only(
                            left: 26, top: 10, bottom: 10, right: 15),
                        child: SvgPicture.asset(
                          Svgs.attach,
                          width: 20,
                        ),
                        onPressed: () {}),
                    Expanded(
                      child: TextField(
                        controller: message,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyles.s16w400.copyWith(

                        ),
                        onChanged: (val) {
                          setState(() {
                            value = val;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          hintStyle: TextStyles.s16w400.copyWith(
                            color: const Color(0xFF828282),
                          ),
                          hintText: getConstant('Enter_message_text'),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    CupertinoButton(
                        minSize: 0.0,
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10, right: 26),
                        onPressed: value.isNotEmpty ? () {
                          setState(() {
                            message.clear();
                            state.sendMessage(value);
                            value = '';
                          });
                        } : null,
                        child: SvgPicture.asset(
                          Svgs.send,
                          width: 20,
                        )
                      ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
