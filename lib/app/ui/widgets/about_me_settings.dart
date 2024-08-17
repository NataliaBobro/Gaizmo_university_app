import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'auth_button.dart';
import 'center_header.dart';

class AboutMeSettings extends StatefulWidget {
  const AboutMeSettings({
    Key? key,
    required this.user,
    required this.onSave
  }) : super(key: key);

  final UserData? user;
  final Function onSave;

  @override
  State<AboutMeSettings> createState() => _AboutMeSettingsState();
}

class _AboutMeSettingsState extends State<AboutMeSettings> {
  TextEditingController about = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData(){
    if(widget.user?.about != null){
      about.text = "${widget.user?.about}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: getConstant('About_me')
                ),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              hasBorder: false,
                              multiLine: 137,
                              label: getConstant('About_me'),
                              controller: about,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: AppButton(
                      title: getConstant('SAVE_CHANGES'),
                      onPressed: () {
                        widget.onSave(about.text);
                        close();
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  void close() {
    Navigator.pop(context);
  }
}
