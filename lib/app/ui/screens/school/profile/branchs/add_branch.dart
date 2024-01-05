import 'package:etm_crm/app/ui/widgets/add_schedule.dart';
import 'package:etm_crm/app/ui/widgets/app_horizontal_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../../app.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../widgets/settings_tab.dart';

class AddBranch extends StatefulWidget {
  const AddBranch({Key? key}) : super(key: key);

  @override
  State<AddBranch> createState() => _AddBranchState();
}

class _AddBranchState extends State<AddBranch> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController site = TextEditingController();
  MaskedTextController phone = MaskedTextController(mask: '+00 (000) 000 00 00', text: '+38 (0');
  List<int> listWorkDay = [];
  MaskedTextController scheduleFrom = MaskedTextController(
      mask: '00 : 00'
  );
  MaskedTextController scheduleTo = MaskedTextController(
      mask: '00 : 00'
  );


  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeader(
                    title: 'Add branch'
                ),
                Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        AppHorizontalField(
                            label: "Name of school",
                            controller: name,
                            changeClear: () {
                              name.clear();
                              setState(() {});
                            }
                        ),
                        AppHorizontalField(
                            label: "Phone number",
                            controller: phone,
                            changeClear: () {
                              phone.clear();
                              setState(() {});
                            }
                        ),
                        AppHorizontalField(
                            label: "E-mail",
                            controller: email,
                            changeClear: () {
                              email.clear();
                              setState(() {});
                            }
                        ),
                        AppHorizontalField(
                            label: "Site address",
                            controller: site,
                            changeClear: () {
                              site.clear();
                              setState(() {});
                            }
                        ),
                        SettingsInput(
                            title: "Schedule",
                            onPress: () async {
                              appState.openPage(
                                  context,
                                  AddSchedule(
                                    selectedDay: listWorkDay,
                                    to: scheduleTo,
                                    from: scheduleFrom,
                                    onSelect: (newWork) {
                                      listWorkDay = newWork;
                                      setState(() {});
                                    }
                                  )
                              );
                            }
                        ),
                        SettingsInput(
                            title: "School category",
                            onPress: () async {

                            }
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: AppButton(
                      title: 'Save changes',
                      onPressed: () {
                        // widget.onSelect(selectedDay);
                        // Navigator.pop(context);
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
