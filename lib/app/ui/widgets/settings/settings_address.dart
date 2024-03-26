import 'package:etm_crm/app/domain/models/user.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/meta.dart';
import '../../../domain/services/app_ninjas_service.dart';
import '../../../domain/services/staff_service.dart';
import '../../theme/text_styles.dart';
import '../../utils/get_constant.dart';
import '../app_field.dart';
import '../auth_button.dart';
import '../center_header.dart';
import '../select_input_search_field.dart';

class SettingsAddress extends StatefulWidget {
  const SettingsAddress({
    Key? key,
    required this.user
  }) : super(key: key);

  final UserData? user;

  @override
  State<SettingsAddress> createState() => _SettingsAddressState();
}

class _SettingsAddressState extends State<SettingsAddress> {
  final TextEditingController street = TextEditingController();
  final TextEditingController house = TextEditingController();
  String? value;
  bool loadingSearch = false;
  List<dynamic>? countryList;
  List<dynamic>? cityList;
  Map<String, dynamic>? country;
  Map<String, dynamic>? city;
  String? openField;
  ValidateError? validateError;


  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    if(widget.user?.country != null){
      country = {
        'name': '${widget.user?.country}',
        'id': 1
      };
    }
    if(widget.user?.city != null){
      city = {
        'name': '${widget.user?.city}',
        'id': 1
      };
    }
    if(widget.user?.street != null){
      street.text = '${widget.user?.street}';
    }
    if(widget.user?.house != null){
      house.text = '${widget.user?.house}';
    }
  }

  Future<void> searchCountry(String? value) async {
    if((value?.length ?? 0) < 2) return;
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
    if((value?.length ?? 0) < 2) return;
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24
                            ),
                            physics: const ClampingScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              SelectInputSearchField(
                                errors: validateError?.errors.country?.first,
                                title: getConstant('Country'),
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
                                errors: validateError?.errors.city?.first,
                                title: getConstant('City'),
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
                                label: getConstant('Street'),
                                controller: street,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              AppField(
                                label: getConstant('House'),
                                controller: house,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: getConstant('SAVE_CHANGES'),
                              onPressed: () {
                                saveAddress(
                                  country?['name'],
                                  city?['name'],
                                  street.text,
                                  house.text
                                );
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

  Future<void> saveAddress(
      String? country,
      String? city,
      String? street,
      String? house,
      ) async {
    try{
      final result = await StaffService.saveAddress(
          context,
          widget.user?.id,
          {
            'country': country,
            'city': city,
            'street': street,
            'house': house,
          }
      );
      if(result == true){
        widget.user?.country = country;
        widget.user?.city = city;
        widget.user?.street = street;
        widget.user?.house = house;
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
