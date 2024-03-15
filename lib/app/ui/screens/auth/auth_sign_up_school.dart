import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/states/auth_state.dart';
import 'package:etm_crm/app/ui/screens/auth/widgets/already_account.dart';
import 'package:etm_crm/app/ui/screens/auth/widgets/check_box_auth.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_title.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:etm_crm/app/ui/widgets/select_input_search.dart';
import 'package:etm_crm/app/ui/widgets/select_input_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../widgets/arrow_back.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input.dart';

class AuthSignUpSchool extends StatefulWidget {
  const AuthSignUpSchool({Key? key}) : super(key: key);

  @override
  State<AuthSignUpSchool> createState() => _AuthSignUpSchoolState();
}

class _AuthSignUpSchoolState extends State<AuthSignUpSchool> {
  String? openField;
  FocusScopeNode? oldFocus;
  final GlobalKey _containerKey = GlobalKey();

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

    state.streetFocus.addListener(() {
      if (state.streetFocus.hasFocus) {
        changeOpen(null);
      }
    });

    state.houseFocus.addListener(() {
      if (state.houseFocus.hasFocus) {
        changeOpen(null);
      }
    });

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
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();

                  final RenderBox? containerRenderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
                  if (containerRenderBox != null) {
                    final containerPosition = containerRenderBox.localToGlobal(Offset.zero);
                    final containerSize = containerRenderBox.size;
                    final tapPosition = MediaQuery.of(context).size.width - containerPosition.dx;
                    if (tapPosition < 0 || tapPosition > containerSize.width) {
                      changeOpen(null);
                    }
                  }
                },
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
                            const AppTitle(
                              title: 'General info',
                            ),
                            AuthInput(
                              keyboardType: TextInputType.number,
                              controller: state.phone,
                              title: 'Phone number',
                              hintText: '+380',
                              errors: state.validateError?.errors.phoneErrors?.first,
                            ),
                            AuthInput(
                              controller: state.email,
                              title: 'E-mail address',
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
                            const AppTitle(
                              title: 'School information',
                            ),
                            AuthInput(
                              controller: state.schoolName,
                              title: 'Name of the school',
                              errors: state.validateError?.errors.schoolName?.first,
                            ),
                            SelectInputSearch(
                              errors: state.validateError?.errors.schoolCategory?.first,
                              title: 'School category',
                              items: listSchoolType,
                              selected: state.schoolCategory,
                              onSelect: (value) {
                                state.changeSchoolCategory(value);
                              },
                              hintText: '',
                            ),
                            Column(
                              key: _containerKey,
                              children: [
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
                              ],
                            ),
                            AuthInput(
                              focusNode: state.streetFocus,
                              controller: state.street,
                              title: 'Street',
                              errors: state.validateError?.errors.street?.first,
                            ),
                            AuthInput(
                              focusNode: state.houseFocus,
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
                            AppButton(
                              title: 'Sign up',
                              onPressed: () {
                                if(!state.isLoading) {
                                  state.sendCode();
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
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: ArrowBack(
                  onArrowBack: () {
                    state.clear();
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}

