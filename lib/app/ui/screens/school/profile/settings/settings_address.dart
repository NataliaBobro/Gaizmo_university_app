import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/school/school_profile_state.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';

class SettingsAddress extends StatefulWidget {
  const SettingsAddress({Key? key}) : super(key: key);

  @override
  State<SettingsAddress> createState() => _SettingsAddressState();
}

class _SettingsAddressState extends State<SettingsAddress> {
  String? openField;

  void changeOpen(value){
    if(openField == value){
      openField = null;
    }else{
      openField = value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolProfileState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: getConstant('Address')
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
                              label: getConstant('Country'),
                              controller: state.country,
                              error: state.validateError?.errors.country?.first,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: getConstant('City'),
                              controller: state.city,
                              error: state.validateError?.errors.city?.first,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: getConstant('Street'),
                              controller: state.street,
                              error: state.validateError?.errors.street?.first,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: getConstant('House'),
                              controller: state.house,
                              error: state.validateError?.errors.house?.first,
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
                        state.saveAddress();
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
