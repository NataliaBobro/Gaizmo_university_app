import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/school/profile/branchs/item/widgets/document_view.dart';
import '../center_header.dart';

class SettingsDocument extends StatefulWidget {
  const SettingsDocument({
    Key? key,
    required this.user
  }) : super(key: key);

  final UserData? user;

  @override
  State<SettingsDocument> createState() => _SettingsDocumentState();
}

class _SettingsDocumentState extends State<SettingsDocument> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'My documents'
                ),
                Expanded(
                  child: DocumentWidget(
                    key: ValueKey(appState.userData?.documents?.length),
                    user: appState.userData,
                    onUpdate: () async {
                      appState.getUser();
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  void back() {
    Navigator.pop(context);
  }
}
