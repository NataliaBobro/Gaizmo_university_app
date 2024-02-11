import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/user_service.dart';
import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../auth_button.dart';
import '../center_header.dart';

class SettingsSalary extends StatefulWidget {
  const SettingsSalary({
    Key? key,
    required this.user
  }) : super(key: key);

  final UserData? user;

  @override
  State<SettingsSalary> createState() => _SettingsSalaryState();
}

class _SettingsSalaryState extends State<SettingsSalary> {
  MaskedTextController salary = MaskedTextController(mask: '0000000');

  @override
  void initState() {
    salary.text = '${widget.user?.salary}';
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
                const CenterHeader(
                    title: 'Settings'
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24
                            ),
                            physics: const ClampingScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              AppField(
                                  label: 'Salary',
                                  controller: salary
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: 'Save changes',
                              onPressed: () {
                                saveSalary();
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

  Future<void> saveSalary() async {
    if(salary.text.isEmpty) return;
    try{
      final result = await UserService.saveSalary(
          context,
          widget.user?.id,
          int.parse(salary.text)
      );
      if(result == true){
        widget.user?.salary = int.parse(salary.text);
        setState(() {});
        back();
      }
    }catch (e){
      print(e);
    }
  }

  void back() {
    Navigator.pop(context);
  }
}
