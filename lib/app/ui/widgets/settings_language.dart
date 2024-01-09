import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:etm_crm/app/ui/widgets/select_bottom_sheet_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingLanguage extends StatefulWidget {
  const SettingLanguage({
    Key? key,
    required this.saveLanguage,
    this.selectLanguage
  }) : super(key: key);

  final Function saveLanguage;
  final int? selectLanguage;

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  Map<String, dynamic>? selectLanguage;

  List<Map<String, dynamic>> get listLanguage {
    List<Map<String, dynamic>> list = [];
    final appStateLanguage = context.read<AppState>().metaAppData?.language;
    for(var a = 0; a < (appStateLanguage?.length ?? 0); a++){
      list.add(
        {
          "id": appStateLanguage?[a].id,
          "name": appStateLanguage?[a].name
        },
      );
    }
    return list;
  }

  @override
  void initState() {
    selectLanguage = listLanguage.firstWhere((element) => element['id'] == widget.selectLanguage);
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
                        Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            SelectBottomSheetInput(
                                label: "Choose language",
                                labelModal: "Choose language",
                                selected: selectLanguage,
                                items: listLanguage,
                                onSelect: (value) {
                                  selectLanguage = value;
                                  setState(() {});
                                }
                            ),
                          ],
                        ),
                        if(selectLanguage != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: AppButton(
                                title: 'Save changes',
                                onPressed: () {
                                  Navigator.pop(context);
                                  widget.saveLanguage(
                                      selectLanguage
                                  );

                                }
                            ),
                          )
                        ]
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
