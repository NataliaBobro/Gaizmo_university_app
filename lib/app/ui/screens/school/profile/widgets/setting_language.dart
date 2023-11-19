import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:flutter/material.dart';

class SettingLanguage extends StatefulWidget {
  const SettingLanguage({Key? key}) : super(key: key);

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const CenterHeader(
                  title: 'Settings'
              ),
              Expanded(
                child: ListView(
                  children: [

                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
