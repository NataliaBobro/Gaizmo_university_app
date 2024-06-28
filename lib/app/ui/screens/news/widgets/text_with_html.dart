import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithTags extends StatefulWidget {
  const TextWithTags({super.key, required this.text});

  final String text;

  @override
  State<TextWithTags> createState() => _TextWithTagsState();
}

class _TextWithTagsState extends State<TextWithTags> {
  Future<void> _launchUrl(String? link) async {
    if(link != null){
      final newUrl = 'https://e-u.edu.ua${link
          .replaceAll('http://', '')
          .replaceAll('www.', '')
          .replaceAll('https://', '')}';

      if (!await launchUrl(Uri.parse(newUrl))) {
        throw Exception('Could not launch $newUrl');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Html(
      onLinkTap: (link, data, el) {
        _launchUrl(link);
      },
      data: widget.text,
      style: {
        "em": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(18),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "body": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(18),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "p": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(18),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "span": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(18),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "strong": Style(
          color: const Color(0xFF3B91ED),
          fontSize: FontSize(18),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
      },
    );
  }
}


class TextWithTagsTitle extends StatefulWidget {
  const TextWithTagsTitle({super.key, required this.text});

  final String text;

  @override
  State<TextWithTagsTitle> createState() => _TextWithTagsTitleState();
}

class _TextWithTagsTitleState extends State<TextWithTagsTitle> {

  @override
  Widget build(BuildContext context) {
    return Html(
      data: '${widget.text.trim().substring(0, 50)}...',
      style: {
        "em": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(12),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "body": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(12),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "p": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(12),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "span": Style(
          color: const Color(0xFFAEADAD),
          fontSize: FontSize(12),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "strong": Style(
          color: const Color(0xFF3B91ED),
          fontSize: FontSize(12),
          fontWeight: FontWeight.w400,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
      },
    );
  }
}