import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/user_service.dart';
import 'package:flutter/material.dart';


import 'app_radio_input.dart';
import 'auth_button.dart';
import 'center_header.dart';


class NotificationsSettings extends StatefulWidget {
  const NotificationsSettings({
    Key? key,
    required this.student,
    required this.onUpdate
  }) : super(key: key);

  final UserData? student;
  final Function onUpdate;

  @override
  State<NotificationsSettings> createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  bool hasOn = false;

  @override
  void initState() {
    hasOn = widget.student?.notifications == 1;
    super.initState();
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
                const CenterHeaderWithAction(
                    title: 'Settings'
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(24),
                            physics: const ClampingScrollPhysics(),
                            children: [
                              AppRadioInput(
                                value: hasOn,
                                label: "Pause all notifications",
                                onChange: (value) {
                                  setState(() {
                                    hasOn = value;
                                  });
                                }
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: 'Save changes',
                              onPressed: () {
                                save();
                              }
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }

  Future<void> save() async {
    try{
      final result = await UserService.changeNotifications(context, hasOn);
      if(result == true){
        widget.onUpdate();
        close();
      }
    }catch(e){
      print(e);
    }
  }

  void close() {
    Navigator.pop(context);
  }
}
