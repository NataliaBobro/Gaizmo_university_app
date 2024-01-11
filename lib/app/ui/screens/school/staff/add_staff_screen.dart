import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/states/school/school_staff_state.dart';
import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../../domain/services/app_ninjas_service.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/auth_title.dart';
import '../../../widgets/center_header.dart';
import '../../../widgets/custom_scroll_physics.dart';
import '../../../widgets/select_date_input.dart';
import '../../../widgets/select_input.dart';
import '../../../widgets/select_input_search_field.dart';


class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController house = TextEditingController();
  final MaskedTextController phone = MaskedTextController(mask: '+00 (000) 000 00 00');
  Map<String, dynamic>? country;
  Map<String, dynamic>? city;
  String? openField;
  String? dateBirth;
  int gender = -1;

  bool loadingSearch = false;
  List<dynamic>? countryList;
  List<dynamic>? cityList;

  Future<void> searchCountry(String? value) async {
    if(loadingSearch || (value?.length ?? 0) < 2) return;
    loadingSearch = true;
    setState(() {});
    try {
      final result = await AppNinjasService.getCountry(value);
      if(result != null){
        countryList = result;
      }
    } catch (e) {
      print(e);
    } finally {
      loadingSearch = false;
      setState(() {});
    }
  }

  Future<void> searchCity(String? value) async {
    if(loadingSearch || (value?.length ?? 0) < 2) return;
    loadingSearch = true;
    setState(() {});
    try {
      final result = await AppNinjasService.getCity(value, country);
      if(result != null){
        cityList = result;
      }
    } catch (e) {
      print(e);
    } finally {
      loadingSearch = false;
      setState(() {});
    }
  }

  List<Map<String, dynamic>>? countryListData() {
    List<Map<String, dynamic>>? list = [];
    for(var a = 0; a < (countryList?.length ?? 0); a++){
      list.add({
        'name': countryList![a]['name'],
        'iso2': countryList![a]['iso2']
      });
    }
    return list;
  }

  List<Map<String, dynamic>>? cityListData() {
    List<Map<String, dynamic>>? list = [];
    for(var a = 0; a < (cityList?.length ?? 0); a++){
      list.add({
        'name': cityList![a]['name']
      });
    }
    return list;
  }

  final List<Map<String, dynamic>> listDefaultCountry = [
    {
      "id": "1",
      "name": "Ukraine",
      "iso2": "UA"
    },
    {
      "id": "2",
      "name": "Poland",
      "iso2": "PL"
    },
    {
      "id": "3",
      "name": "Austria",
      "iso2": "AT"
    },
    {
      "id": "3",
      "name": "Germany",
      "iso2": "DE"
    },
  ];

  void changeCountry(value) {
    country = value;
    setState(() {});
  }

  void changeCity(value) {
    city = value;
    setState(() {});
  }

  void changeOpen(value){
    if(openField == value){
      openField = null;
    }else{
      openField = value;
    }
    setState(() {});
  }

  void changeDateBirth(String date) {
    dateBirth = date;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolStaffState>();
    final listGender = context.watch<AppState>().metaAppData?.genders ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const CenterHeader(
                  title: 'Add staff'
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24
                  ),
                  physics: const BottomBouncingScrollPhysics(),
                  children: [
                    const AppTitle(
                      title: 'Personal info',
                    ),
                    AppField(
                      error: state.validateError?.errors.firstNameErrors?.first,
                      label: 'First name',
                      controller: firstName,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      error: state.validateError?.errors.lastNameErrors?.first,
                      label: 'Last name',
                      controller: lastName,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SelectInput(
                        errors: state.validateError?.errors.genderErrors?.first,
                        title: 'Gender',
                        hintText: '',
                        hintStyle: TextStyles.s14w400.copyWith(
                            color: const Color(0xFF848484)
                        ),
                        items: listGender.map((e) => e.name).toList(),
                        selected: gender,
                        labelStyle: TextStyles.s14w600.copyWith(
                          color: const Color(0xFF242424)
                        ),
                        onSelect: (index) {
                          setState(() {
                            gender = index;
                          });
                        },
                    ),
                    SelectDateInput(
                      errors: state.validateError?.errors.dateBirthErrors?.first,
                      labelStyle: TextStyles.s14w600.copyWith(
                          color: const Color(0xFF242424)
                      ),
                      hintStyle: TextStyles.s14w400.copyWith(
                          color: const Color(0xFF848484)
                      ),
                      onChange: (day, mon, year) {
                        if(day != null && mon != null && year != null){
                          changeDateBirth('$day.$mon.$year');
                        }
                      },
                      // errors: state.validateError?.errors.dateBirthErrors?.first,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      error: state.validateError?.errors.phoneErrors?.first,
                      label: 'Phone number',
                      controller: phone,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      error: state.validateError?.errors.emailErrors?.first,
                      label: 'E-mail adress',
                      controller: email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // const AppTitle(
                    //   title: 'Teaching category',
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // SelectInput(
                    //   // errors: state.validateError?.errors.genderErrors?.first,
                    //   title: 'Category',
                    //   hintText: '',
                    //   hintStyle: TextStyles.s14w400.copyWith(
                    //       color: const Color(0xFF848484)
                    //   ),
                    //   items: listGender.map((e) => e.name).toList(),
                    //   selected: gender,
                    //   labelStyle: TextStyles.s14w600.copyWith(
                    //       color: const Color(0xFF242424)
                    //   ),
                    //   onSelect: (index) {
                    //     setState(() {
                    //       gender = index;
                    //     });
                    //   },
                    // ),

                    const AppTitle(
                      title: 'Address',
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
                      items:  (countryListData()?.length ?? 0) > 0 ?
                      countryListData() : listDefaultCountry,
                      selected: country,
                      onSelect: (value) {
                        changeCountry(value);
                        changeOpen(null);
                      },
                      onSearch: (value) {
                        searchCountry(value);
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
                      items: cityListData(),
                      onSearch: (value) {
                        searchCity(value);
                      },
                      titleStyle: TextStyles.s14w600.copyWith(
                          color: const Color(0xFF242424)
                      ),
                      style: TextStyles.s14w400.copyWith(
                          color: const Color(0xFF242424)
                      ),
                      selected: city,
                      changeOpen: () {
                        changeOpen('city');
                      },
                      isOpen: openField == 'city',
                      onSelect: (index) {
                        changeCity(index);
                        changeOpen(null);
                      },
                      hintText: '',
                    ),
                    AppField(
                      label: 'Street',
                      controller: street,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppField(
                      label: 'House',
                      controller: house,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    AppButton(
                      title: 'ADD EMPLOYEE',
                      onPressed: () {
                        state.addOrEditStaff(
                            firstName.text,
                            lastName.text,
                            gender,
                            dateBirth,
                            phone.text,
                            email.text,
                            country?['name'],
                            city?['name'],
                            street.text,
                            house.text
                        );
                      },
                      horizontalPadding: 16,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
