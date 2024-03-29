import 'package:european_university_app/app/ui/widgets/center_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> launchUrlParse(String? link) async {
  if(link != null){
    final newUrl = 'https://${link
        .replaceAll('http://', '')
        .replaceAll('www.', '')
        .replaceAll('https://', '')}';

    launchUrl(Uri.parse(newUrl)).whenComplete(() {

    });
  }
}

Future<void> openWebView(BuildContext context, String? link) async {
  if(link != null){
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => MyWebView(initialUrl: link,)
        )
    );
  }
}

class MyWebView extends StatefulWidget {
  const MyWebView({
    Key? key,
    required this.initialUrl
  }) : super(key: key);

  final String initialUrl;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CenterHeader(title: 'Pay'),
            Expanded(
              child: WebView(
                initialUrl: widget.initialUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _webViewController = webViewController;
                },
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
              ),
            )
          ],
        )
      ),
    );
  }
}


