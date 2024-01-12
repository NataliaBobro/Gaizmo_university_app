import 'package:etm_crm/app/domain/states/school/school_staff_item_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/services/app_ninjas_service.dart';
import '../../../../../theme/text_styles.dart';
import '../../../../../widgets/app_field.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/center_header.dart';
import '../../../../../widgets/select_input_search_field.dart';

class StaffAddress extends StatefulWidget {
  const StaffAddress({Key? key}) : super(key: key);

  @override
  State<StaffAddress> createState() => _StaffAddressState();
}

class _StaffAddressState extends State<StaffAddress> {
  final TextEditingController street = TextEditingController();
  final TextEditingController house = TextEditingController();
  String? value;
  bool loadingSearch = false;
  List<dynamic>? countryList;
  List<dynamic>? cityList;
  Map<String, dynamic>? country;
  Map<String, dynamic>? city;
  String? openField;


  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final read = context.read<SchoolStaffItemState>();
    if(read.staff?.country != null){
      country = {
        'name': '${read.staff?.country}',
        'id': 1
      };
    }
    if(read.staff?.city != null){
      city = {
        'name': '${read.staff?.city}',
        'id': 1
      };
    }
    if(read.staff?.street != null){
      street.text = '${read.staff?.street}';
    }
    if(read.staff?.house != null){
      house.text = '${read.staff?.house}';
    }
  }

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
    final state = context.watch<SchoolStaffItemState>();
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                              title: 'Save changes',
                              onPressed: () {
                                state.saveAddress(
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
}
