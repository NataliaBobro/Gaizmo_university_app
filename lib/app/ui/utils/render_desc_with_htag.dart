import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../theme/text_styles.dart';

Widget makeHashTagsClickable(
    String? title,
    String text,
    bool isOpen,
    bool isProfile,
    Function(String) onHashTagClick,
    Function(String) onLoginClick,
    Function(bool) open,
    {Function(String)? onUserClick}
    )
{
  final pattern = RegExp(r"(@[\wА-ЯЁёіІїЇєЄ]+)|#\w+|#([а-яА-ЯЁёіІїЇєЄ]{1,30})");
  List<InlineSpan> textSpans = [];
  int start = 0;
  String renderText = text;
  bool isCollapsed = text.length > 80;

  if(isCollapsed && !isOpen){
    renderText = text.substring(0, 80);
  }

  if (title != null) {
    textSpans.add(
        TextSpan(
          text: '$title ',
          style: TextStyles.s13w700.copyWith(
              color: Colors.black,
              height: 1.5
          ),
          recognizer: TapGestureRecognizer()..onTap = () =>
              onLoginClick(title),
        )
    );
  }

  for (var match in pattern.allMatches(renderText)) {
    textSpans.add(
        TextSpan(
          text: renderText.substring(start, match.start),
          style: TextStyles.s13w400.copyWith(
              color: Colors.black,
              height: 1.5
          ),
      )
    );

    textSpans.add(TextSpan(
      text: match.group(0),
      style: TextStyles.s13w500.copyWith(
        color: isProfile? const Color(0xFF004C8B) : const Color(0xFF1FA1FF),
        height: 1.5,
      ),
      recognizer: TapGestureRecognizer()..onTap = () {
        if(match.group(0)?.contains('@') != false){
          onUserClick!('${match.group(0)}');
        }else{
          onHashTagClick('${match.group(0)}');
        }
      },
    ));
    start = match.end;
  }

  textSpans.add(
      TextSpan(
        text: renderText.substring(start),
        style: TextStyles.s13w400.copyWith(
            color: Colors.black,
            height: 1.5
        ),
      )
  );

  if(isCollapsed && !isOpen){
    textSpans.add(
        TextSpan(
          text: ' еще',
          style: TextStyles.s13w400.copyWith(
              color: const Color(0xFF6F6F6F),
              height: 1.5
          ),
            recognizer: TapGestureRecognizer()..onTap = () =>
                open(isOpen),
        )
    );
  }

  return RichText(
    text: TextSpan(children: textSpans),
  );
}

