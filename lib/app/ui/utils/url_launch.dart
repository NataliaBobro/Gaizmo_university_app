import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlParse(String? link) async {
  if(link != null){
    final newUrl = 'https://${link
        .replaceAll('http://', '')
        .replaceAll('www.', '')
        .replaceAll('https://', '')}';

    if (!await launchUrl(Uri.parse(newUrl))) {
      throw Exception('Could not launch $newUrl');
    }
  }
}