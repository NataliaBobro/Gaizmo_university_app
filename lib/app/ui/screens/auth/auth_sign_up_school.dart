import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/screens/auth/widgets/already_account.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_title.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:etm_crm/app/ui/widgets/select_input_search.dart';
import 'package:etm_crm/app/ui/widgets/select_input_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';

class AuthSignUpSchool extends StatefulWidget {
  const AuthSignUpSchool({Key? key}) : super(key: key);

  @override
  State<AuthSignUpSchool> createState() => _AuthSignUpSchoolState();
}

class _AuthSignUpSchoolState extends State<AuthSignUpSchool> {
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
    final state = context.watch<AuthState>();
    List<Map<String, dynamic>> listSchoolType = [];

    if(context.read<AppState>().metaAppData?.categorySchool != null){
      final cat = context.read<AppState>().metaAppData?.categorySchool ?? [];
      for(var a = 0; a < cat.length; a++){
        listSchoolType.add({
          "id":   cat[a].id,
          "name": cat[a].translate?.value,
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.registerBg,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 24
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign up',
                    style: TextStyles.s24w600.copyWith(
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const BottomBouncingScrollPhysics(),
                    children: [
                      const AuthTitle(
                        title: 'General info *',
                      ),
                      AuthInput(
                        controller: state.phone,
                        title: 'Phone number',
                        hintText: '+380',
                        errors: state.validateError?.errors.phoneErrors?.first,
                      ),
                      AuthInput(
                        controller: state.email,
                        title: 'E-mail adress',
                        errors: state.validateError?.errors.emailErrors?.first,
                      ),
                      AuthInput(
                        controller: state.password,
                        title: 'Password',
                        isPass: true,
                        errors: state.validateError?.errors.passwordErrors?.first,
                      ),
                      AuthInput(
                        controller: state.confirmPassword,
                        title: 'Confirm password',
                        isPass: true,
                        isBottomPadding: false,
                      ),
                      const AuthTitle(
                        title: 'School info',
                      ),
                      AuthInput(
                        controller: state.schoolName,
                        title: 'Name of school',
                        errors: state.validateError?.errors.schoolName?.first,
                      ),
                      SelectInputSearch(
                        errors: state.validateError?.errors.schoolCategory,
                        title: 'School category',
                        items: listSchoolType,
                        selected: state.schoolCategory,
                        onSelect: (value) {
                          state.changeSchoolCategory(value);
                        },
                        hintText: '',
                      ),
                      SelectInputSearchField(
                        errors: state.validateError?.errors.country,
                        title: 'Country',
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
                      // SelectInputSearch(
                      //     // errors: state.validateError?.errors.genderErrors?.first,
                      //     title: 'Region',
                      //     items: listSchoolType,
                      //     // selected: state.gender,
                      //     onSelect: (index) {
                      //       state.changeGander(index);
                      //     },
                      //   hintText: '',
                      // ),
                      SelectInputSearchField(
                        errors: state.validateError?.errors.city,
                        title: 'City',
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
                      AuthInput(
                        controller: state.street,
                        title: 'Street',
                        errors: state.validateError?.errors.street?.first,
                      ),
                      AuthInput(
                        controller: state.house,
                        title: 'House',
                        maxWidth: 80,
                        isBottomPadding: false,
                        errors: state.validateError?.errors.house?.first,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const CheckboxAuth(),

                      const SizedBox(
                        height: 40,
                      ),
                      AuthButton(
                        title: 'Sign up',
                        onPressed: () {
                          if(!state.isLoading) {
                            state.signUp('school');
                          }
                        },
                        horizontalPadding: 16.0,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const AlreadyAccount()
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}

class CheckboxAuth extends StatefulWidget {
  const CheckboxAuth({Key? key}) : super(key: key);

  @override
  State<CheckboxAuth> createState() => _CheckboxAuthState();
}

class _CheckboxAuthState extends State<CheckboxAuth> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthState>();
    final isActivePrivacy = state.isActivePrivacy;
    final error = state.validateError?.errors.privacyErrors?.first;

    return CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: const Color(0xFF848484)
                  ),
                  color: isActivePrivacy ? const Color(0xFF848484) : null
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Container(
              constraints: const BoxConstraints(
                  maxWidth: 270
              ),
              child: Text(
                'I have read and agree to the  privacy policy, '
                    'terms of service, and community guidlines',
                style: TextStyles.s10w600.copyWith(
                    color: error != null ? const Color(0xFFFFC700) : Colors.white,
                    letterSpacing: 0.0
                ),
              ),
            )
          ],
        ),
        onPressed: () {
          state.changeActivePrivacy();
        }
    );
  }
}


