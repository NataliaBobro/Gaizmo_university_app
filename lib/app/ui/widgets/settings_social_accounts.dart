import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:etm_crm/app/ui/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import '../../domain/services/user_service.dart';
import '../utils/show_message.dart';
import 'auth_button.dart';
import 'center_header.dart';

class SettingsSocialAccounts extends StatefulWidget {
  const SettingsSocialAccounts({
    Key? key,
    required this.user,
    this.onSave
  }) : super(key: key);

  final UserData? user;
  final Function? onSave;

  @override
  State<SettingsSocialAccounts> createState() => _SettingsSocialAccountsState();
}

class _SettingsSocialAccountsState extends State<SettingsSocialAccounts> {
  TextEditingController instagramField = TextEditingController();
  TextEditingController facebookField = TextEditingController();
  TextEditingController linkedinField = TextEditingController();
  TextEditingController twitterField = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData(){
    if(widget.user?.socialAccounts?.instagram != null){
      instagramField.text = "${widget.user?.socialAccounts?.instagram}";
    }
    if(widget.user?.socialAccounts?.facebook != null){
      facebookField.text = "${widget.user?.socialAccounts?.facebook}";
    }
    if(widget.user?.socialAccounts?.linkedin != null){
      linkedinField.text = "${widget.user?.socialAccounts?.linkedin}";
    }
    if(widget.user?.socialAccounts?.twitter != null){
      twitterField.text = "${widget.user?.socialAccounts?.twitter}";
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
                const CenterHeaderWithAction(
                    title: 'Settings'
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
                              label: 'Instagram link',
                              controller: instagramField,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'Facebook link',
                              controller: facebookField,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'Linkedin link',
                              controller: linkedinField,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'Twitter link',
                              controller: twitterField,
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
                      title: 'Save changes',
                      onPressed: () {
                        saveSocialLinks();
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Future<void> saveSocialLinks() async {
    try {
      final result = await UserService.changeSocialAccounts(
          context,
          widget.user?.id,
          instagramField.text,
          facebookField.text,
          linkedinField.text,
          twitterField.text
      );
      if(result == true){
        widget.user?.socialAccounts?.instagram = instagramField.text;
        widget.user?.socialAccounts?.facebook = facebookField.text;
        widget.user?.socialAccounts?.linkedin = linkedinField.text;
        widget.user?.socialAccounts?.twitter = twitterField.text;

        if(widget.onSave != null){
          widget.onSave!(
              widget.user?.id,
              instagramField.text,
              facebookField.text,
              linkedinField.text,
              twitterField.text
          );
        }
        close();
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      setState(() {});
    }
  }

  void close() {
    Navigator.pop(context);
  }
}
