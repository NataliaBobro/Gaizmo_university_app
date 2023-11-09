import 'dart:async';

import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/services/app_ninjas_service.dart';
import 'package:etm_crm/app/domain/services/auth_service.dart';
import 'package:etm_crm/app/ui/screens/auth/auth_sign_up_school.dart';
import 'package:etm_crm/resources/resources.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../app.dart';
import '../../ui/screens/auth/auth_sign_in.dart';
import '../../ui/screens/auth/auth_sign_up_student.dart';
import '../../ui/screens/auth/widgets/auth_select_language_screen.dart';
import '../../ui/screens/auth/widgets/auth_select_login_type.dart';
import '../../ui/screens/auth/widgets/auth_select_user_type.dart';
import '../../ui/utils/show_message.dart';
import '../../ui/widgets/select_bottom_sheet.dart';
import '../../ui/widgets/snackbars.dart';
import '../models/meta.dart';

class AuthState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  bool _isActivePrivacy = false;
  ValidateError? _validateError;
  int _selectLang = 0;
  bool get isLoading => _isLoading;
  final MaskedTextController _phone = MaskedTextController(mask: '+38 (000) 000 00 00');
  final MaskedTextController _controllerNumberCart = MaskedTextController(
        mask: '0000 0000 0000 0000'
  );
  final MaskedTextController _controllerDateCart = MaskedTextController(
        mask: '00/00'
  );
  final MaskedTextController _controllerCodeCart = MaskedTextController(
      mask: '000'
  );
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _schoolName = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _house = TextEditingController();
  Map<String, dynamic>? _schoolCategory;
  Map<String, dynamic>? _country;
  Map<String, dynamic>? _city;
  String? _birthDate;
  int _gender = -1;
  int _userType = 0;
  bool _loadingSearch = false;
  List<dynamic>? _countryList;
  List<dynamic>? _cityList;

  AuthState(this.context);

  ValidateError? get validateError => _validateError;
  int get selectLang => _selectLang;
  bool get isActivePrivacy => _isActivePrivacy;
  MaskedTextController get phone => _phone;
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  TextEditingController get confirmPassword => _confirmPassword;
  TextEditingController get firstName => _firstName;
  TextEditingController get schoolName => _schoolName;
  TextEditingController get street => _street;
  TextEditingController get house => _house;
  TextEditingController get lastName => _lastName;
  TextEditingController get surname => _surname;
  String? get birthDate => _birthDate;
  TextEditingController get controllerNumberCart => _controllerNumberCart;
  TextEditingController get controllerDateCart => _controllerDateCart;
  TextEditingController get controllerCodeCart => _controllerCodeCart;
  int get gender => _gender;
  int get userType => _userType;
  bool get loadingSearch => _loadingSearch;
  List<Map<String, dynamic>>? get countryList {
    List<Map<String, dynamic>>? list = [];
    for(var a = 0; a < (_countryList?.length ?? 0); a++){
      list.add({
        'name': _countryList![a]['name'],
        'iso2': _countryList![a]['iso2']
      });
    }
    return list;
  }

  List<Map<String, dynamic>>? get cityList {
    List<Map<String, dynamic>>? list = [];
    for(var a = 0; a < (_cityList?.length ?? 0); a++){
      list.add({
        'name': _cityList![a]['name']
      });
    }
    return list;
  }


  final List<Map<String, dynamic>> _listDefaultCountry = [
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

  Map<String, dynamic>? get schoolCategory => _schoolCategory;
  Map<String, dynamic>? get country => _country;
  Map<String, dynamic>? get city => _city;
  List<Map<String, dynamic>> get listDefaultCountry => _listDefaultCountry;

  void changeLang(index) {
    _selectLang = index;
    routemaster.pop();
    notifyListeners();
    pageOpen(
        const AuthSelectType()
    );
  }

  void changeGander(index) {
    _gender = index;
    notifyListeners();
  }

  void changeActivePrivacy() {
    _isActivePrivacy = !_isActivePrivacy;
    notifyListeners();
  }

  void changeDateBirth(value) {
    _birthDate = value;
    notifyListeners();
  }

  // 1 - Student
  // 2 - School
  // 3 - Teacher
  // 4 - Parent
  Future<void> changeUserType(value) async {
    _userType = value;
    notifyListeners();
    await context.read<AppState>().getMeta(_selectLang);
    if(value == 1){
      openSignUpStudent();
    }else if(value == 2){
      openSignUpSchool();
    }
  }

  void changeSchoolCategory(value) {
    _schoolCategory = value;
    notifyListeners();
  }

  Future<void> searchCountry(String? value) async {
    if(_loadingSearch || (value?.length ?? 0) < 2) return;
    _loadingSearch = true;
    notifyListeners();
    try {
      final result = await AppNinjasService.getCountry(value);
      if(result != null){
        _countryList = result;
        print(_countryList);
      }
    } on DioError catch (e) {
      showMessage(e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _loadingSearch = false;
      notifyListeners();
    }
  }

  Future<void> searchCity(String? value) async {
    if(_loadingSearch || (value?.length ?? 0) < 2) return;
    _loadingSearch = true;
    notifyListeners();
    try {
      final result = await AppNinjasService.getCity(value, _country);
      if(result != null){
        _cityList = result;
      }
    } on DioError catch (e) {
      showMessage(e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _loadingSearch = false;
      notifyListeners();
    }
  }

  void changeCountry(value) {
    _country = value;
    notifyListeners();
  }

  void changeCity(value) {
    _city = value;
    notifyListeners();
  }

  void openSignUpStudent() {
    pageOpen(
      const AuthSignUpStudent()
    );
  }
  void openSignUpSchool() {
    pageOpen(
      const AuthSignUpSchool()
    );
  }

  void openSignIn() {
    pageOpen(
        const AuthSignIn()
    );
  }

  void openSelectUserType() {
    pageOpen(
      const AuthSelectUserType()
    );
  }

  void pageOpen(Widget widget) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ChangeNotifierProvider.value(
              value: this,
              child: child,
            ),
          );
        },
      ),
    );
  }

  List<Map<String, String>> languageList() {
    return [
      {
        "name": "English",
        "icon": Svgs.en
      },
      {
        "name": "Українська",
        "icon": Svgs.ua
      },
      {
        "name": "Deutsch",
        "icon": Svgs.en
      },
      {
        "name": "Español",
        "icon": Svgs.en
      },
    ];
  }

  List<String> listGender() {
    return [
      'Male',
      'Female'
    ];
  }

  Future<void> changeLogInState()async {
    await context.read<AppState>().changeLogInState(true);
  }

  Future<void> openShowBottomSelectLang() async {
    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(.75),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (_) {
        final height = SizerUtil.height / 3;
        return SizedBox(
          height: height,
          child: ChangeNotifierProvider.value(
            value: this,
            child: const SelectLangBottomSheet(),
          ),
        );
      },
    );
  }

  Future<void> openShowBottomSelect(
      String title,
      List<String> list,
      {
        Function? onPress
      }
      ) async {
    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(.75),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (_) {
        final height = (list.length * 48) + 68;
        return SizedBox(
          height: height.toDouble(),
          child: ChangeNotifierProvider.value(
            value: this,
            child: SelectBottomSheet(
                list: list,
                title: title,
                onPress: onPress
            ),
          ),
        );
      },
    );
  }

  void signUp(type) {
    if(type == 'student'){
      signUpStudent();
    }else if(type == 'school'){
      signUpSchool();
    }
  }


  Future<void> signUpStudent() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.registerStudent(
          _selectLang,
          _userType,
          _firstName.text,
          _lastName.text,
          _surname.text,
          _gender,
          _birthDate,
          _phone.text,
          _email.text,
          _password.text,
          _confirmPassword.text,
          _controllerNumberCart.text,
          _controllerDateCart.text,
          _controllerCodeCart.text,
          _isActivePrivacy
      );

      if(result != null){
        setToken(result.token, result.user);
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpSchool() async {
    _validateError = null;
    if(_schoolCategory == null){
      _validateError = ValidateError(
          message: 'Select school category',
          errors: Errors(
            schoolCategory: 'Select school category'
          )
      );
      notifyListeners();
      return;
    }
    if(_country == null){
      _validateError = ValidateError(
          message: 'Select school category',
          errors: Errors(
              country: 'Select country'
          )
      );
      notifyListeners();
      return;
    }
    if(_city == null){
      _validateError = ValidateError(
          message: 'Select school category',
          errors: Errors(
              city: 'Select city'
          )
      );
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.registerSchool(
          _selectLang,
          _userType,
          _phone.text,
          _email.text,
          _password.text,
          _confirmPassword.text,
          _schoolName.text,
          _schoolCategory!['id'],
          _country!['name'],
          _city!['name'],
          _street.text,
          _house.text,
          _isActivePrivacy
      );

      if(result != null){
        setToken(result.token, result.user);
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn() async {
    _isLoading = true;
    _validateError = null;
    notifyListeners();
    try {
      final result = await AuthService.login(
          _phone.text,
          _password.text
      );
      if(result != null){
        setToken(result.token, result.user);
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage('Phone or password is incorrect.');
      }
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setToken (token, user) async {
    Hive.openBox('settings');
    await Hive.box('settings').clear();
    await Hive.box('settings').put('token', token);
    await setUser(user);
  }

  Future<void> setUser(user) async {
    await context.read<AppState>().setUser(user);
    await changeLogInState();
  }


  void clear() {

  }
}
