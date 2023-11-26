import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/school/school_profile_state.dart';
import '../../../../theme/text_styles.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/select_input_search_field.dart';

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
                const CenterHeader(
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
                            SelectInputSearchField(
                              errors: state.validateError?.errors.country,
                              title: 'Country',
                              titleStyle: TextStyles.s14w600.copyWith(
                                  color: const Color(0xFF242424)
                              ),
                              style: TextStyles.s14w400.copyWith(
                                  color: const Color(0xFF242424)
                              ),
                              items:  (state.countryList?.length ?? 0) > 0 ?
                              state.countryList : state.listDefaultCountry,
                              selected: state.country,
                              onSelect: (value) {
                                state.changeCountry(value);
                                changeOpen(null);
                              },
                              onSearch: (value) {
                                state.searchCountry(value);
                              },
                              changeOpen: () {
                                changeOpen('country');
                              },
                              isOpen: openField == 'country',
                              hintText: '',
                            ),
                            SelectInputSearchField(
                              errors: state.validateError?.errors.city,
                              title: 'City',
                              titleStyle: TextStyles.s14w600.copyWith(
                                  color: const Color(0xFF242424)
                              ),
                              style: TextStyles.s14w400.copyWith(
                                  color: const Color(0xFF242424)
                              ),
                              items: state.cityList,
                              onSearch: (value) {
                                state.searchCity(value);
                              },
                              selected: state.city,
                              changeOpen: () {
                                changeOpen('city');
                              },
                              isOpen: openField == 'city',
                              onSelect: (index) {
                                state.changeCity(index);
                                changeOpen(null);
                              },
                              hintText: '',
                            ),
                            AppField(
                              label: 'Street',
                              controller: state.street,
                              error: state.validateError?.errors.street?.first,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                              label: 'House',
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
                      title: 'Save changes',
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
