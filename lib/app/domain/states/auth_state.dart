import 'dart:async';

import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/services/app_ninjas_service.dart';
import 'package:european_university_app/app/domain/services/auth_service.dart';
import 'package:european_university_app/app/ui/screens/auth/auth_sign_up_school.dart';
import 'package:european_university_app/app/ui/screens/auth/confirm_code_screen.dart';
import 'package:european_university_app/app/ui/screens/auth/new_password.dart';
import 'package:european_university_app/resources/resources.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../app.dart';
import '../../ui/screens/auth/auth_sign_in.dart';
import '../../ui/screens/auth/auth_sign_up_student.dart';
import '../../ui/screens/auth/auth_sign_up_teacher.dart';
import '../../ui/screens/auth/confirm_recovery_password.dart';
import '../../ui/screens/auth/widgets/auth_select_login_type.dart';
import '../../ui/screens/auth/widgets/auth_select_user_type.dart';
import '../../ui/theme/app_colors.dart';
import '../../ui/utils/show_message.dart';
import '../../ui/widgets/snackbars.dart';
import '../models/meta.dart';

class AuthState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  bool _isActivePrivacy = false;
  ValidateError? _validateError;
  int _selectLang = 0;
  bool get isLoading => _isLoading;
  final MaskedTextController _phone = MaskedTextController(mask: '+00 (000) 000 00 00', text: '+38 (0');

  final MaskedTextController _code = MaskedTextController(
      mask: '000000'
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
  final TextEditingController _codeRegister = TextEditingController();
  Map<String, dynamic>? _schoolCategory;
  Map<String, dynamic>? _country;
  Map<String, dynamic>? _city;
  String? _birthDate;
  int _gender = -1;
  int _userType = 0;
  bool _loadingSearch = false;
  List<dynamic>? _countryList;
  List<dynamic>? _cityList;

  final _phoneFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _houseFocus = FocusNode();

  AuthState(this.context);

  ValidateError? get validateError => _validateError;
  int get selectLang => _selectLang;
  bool get isActivePrivacy => _isActivePrivacy;
  MaskedTextController get phone => _phone;
  TextEditingController get email => _email;
  TextEditingController get code => _code;
  TextEditingController get codeRegister => _codeRegister;
  TextEditingController get password => _password;
  TextEditingController get confirmPassword => _confirmPassword;
  TextEditingController get firstName => _firstName;
  TextEditingController get schoolName => _schoolName;
  TextEditingController get street => _street;
  TextEditingController get house => _house;
  TextEditingController get lastName => _lastName;
  TextEditingController get surname => _surname;
  String? get birthDate => _birthDate;
  FocusNode get phoneFocus => _phoneFocus;
  FocusNode get countryFocus => _countryFocus;
  FocusNode get cityFocus => _cityFocus;
  FocusNode get streetFocus => _streetFocus;
  FocusNode get houseFocus => _houseFocus;
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
    context.read<AppState>().fetchConstant(languageId: _selectLang + 1);
    routemaster.pop();
    notifyListeners();
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

  // 1 - School
  // 2 - Teacher
  // 3 - Student
  // 4 - Parent
  Future<void> changeUserType(value) async {
    _userType = value;
    notifyListeners();
    await context.read<AppState>().getMeta(_selectLang + 1);
    if(value == 1){
      openSignUpSchool();
    }else if(value == 2){
      openSignUpTeacher();
    }else if(value == 3){
      openSignUpStudent();
    }
  }

  void changeSchoolCategory(value) {
    _schoolCategory = value;
    notifyListeners();
  }

  Future<void> searchCountry(String? value) async {
    if((value?.length ?? 0) < 2) return;
    _loadingSearch = true;
    notifyListeners();
    try {
      final result = await AppNinjasService.getCountry(value);
      if(result != null){
        _countryList = result;
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
    if((value?.length ?? 0) < 2) return;
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

  void openSignUpTeacher() {
    pageOpen(
      const AuthSignUpTeacher()
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
      // {
      //   "name": "Deutsch",
      //   "icon": Svgs.de
      // },
      // {
      //   "name": "Español",
      //   "icon": Svgs.es
      // },
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


  Future<void> sendCode({bool open = true}) async {
    try{
      final result = await AuthService.sendCode(_email.text);
      if(result == true){
        if(open){
          openWriteCode();
        }
      }else{
        showMessage('Email required', color: AppColors.appButton);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> openWriteCode() async {
    Future? registerVoid;
    if(_userType == 3){
      registerVoid = signUpStudent();
    }else if(_userType == 1){
      registerVoid = signUpSchool();
    } else if(_userType == 2) {
      registerVoid = signUpTeacher();
    }
    await registerVoid!;

  }

  void signUp(code){
    _codeRegister.text = code;
    if(_userType == 3){
      signUpStudent();
    }else if(_userType == 1){
      signUpSchool();
    } else if(_userType == 2) {
      signUpTeacher();
    }
  }

  void openConfirmCode(){
    pageOpen(
      const ConfirmCodeScreen()
    );
  }

  Future<void> signUpStudent({bool sendCode = false}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.registerStudent(
          _selectLang + 1,
          _userType,
          _firstName.text,
          _lastName.text,
          _surname.text,
          _gender,
          _birthDate,
          (_phone.text == "+38 (0" ? null : _phone.text),
          _email.text,
          _password.text,
          _confirmPassword.text,
          _isActivePrivacy,
          _codeRegister.text,
          sendCode
      );

      if(result != null && result.token != null){
        setToken(result.token, result.user);
      }else{
        if(_codeRegister.text.isEmpty){
          openConfirmCode();
        }else{
          showMessage('Code invalid', color: AppColors.appButton);
        }
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: AppColors.appButton);
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    } catch (e) {
      print(e);
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpTeacher({bool sendCode = false}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.registerTeacher(
          _selectLang + 1,
          _userType,
          _firstName.text,
          _lastName.text,
          _surname.text,
          _gender,
          _birthDate,
          _email.text,
          (_phone.text == "+38 (0" ? null : _phone.text),
          _password.text,
          _confirmPassword.text,
          _isActivePrivacy,
          _codeRegister.text,
          sendCode
      );

      if(result != null && result.token != null){
        setToken(result.token, result.user);
      }else{
        if(_codeRegister.text.isEmpty){
          openConfirmCode();
        }else{
          showMessage('Code invalid', color: AppColors.appButton);
        }
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: AppColors.appButton);
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

  Future<void> signUpSchool({bool sendCode = false}) async {
    _validateError = null;
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.registerSchool(
          _selectLang + 1,
          _userType,
          (_phone.text == "+38 (0" ? null : _phone.text),
          _email.text,
          _password.text,
          _confirmPassword.text,
          _schoolName.text,
          (_schoolCategory != null ? _schoolCategory!['id'] : null),
          (_country != null ? _country!['name'] : null),
          (_city != null ? _city!['name'] : null),
          _street.text,
          _house.text,
          _isActivePrivacy,
          _codeRegister.text,
          sendCode
      );

      if(result != null && result.token != null){
        setToken(result.token, result.user);
      }else{
        if(_codeRegister.text.isEmpty){
          openConfirmCode();
        }else{
          showMessage('Code invalid', color: AppColors.appButton);
        }
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: AppColors.appButton);
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
          _email.text,
          _password.text
      );
      if(result != null){
        setToken(result.token, result.user);
        if(result.user?.languageId != _selectLang){
          fetchNewConstant(result.user?.languageId);
        }
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: AppColors.appButton);
      }else{
        showMessage('Email or password is incorrect.');
      }
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchNewConstant(languageId){
    context.read<AppState>().fetchConstant(languageId: languageId);
  }

  Future<void> sendRecoveryCode() async {
    if(_email.text.isEmpty){
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.sendRecoveryCode(
          _email.text,
      );
      if(result == true){
        pageOpen(
          const ConfirmPasswordRecovery()
        );
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: AppColors.appButton);
      }else{
        showMessage('Phone or password is incorrect.');
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> confirmCode() async {
    if(_code.text.isEmpty || _code.text.length < 6){
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.confirmCode(
          _email.text,
          _code.text,
      );
      if(result == true){
        pageOpen(
          const NewPassword()
        );
      }
  } catch (e) {
      showMessage('Code incorrect.');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setNewPass() async {
    if(_code.text.isEmpty || _code.text.length < 6 ||
        _password.text.isEmpty ||
        _confirmPassword.text.isEmpty){
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.setNewPassword(
          _email.text,
          _code.text,
          _password.text,
          _confirmPassword.text,
      );
      if(result == true){
        showMessage('Success', color: Colors.green);
        pageOpen(
          const AuthSignIn()
        );
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: AppColors.appButton);
      }else{
        showMessage('Time out');
      }
    } catch (e) {
      showMessage('Code incorrect.');
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
    await initFirebase();

  }

  Future<void> setUser(user) async {
    await context.read<AppState>().setUser(user);
    await changeLogInState();
  }

  Future<void> initFirebase()async {
    await context.read<AppState>().initFirebase();
  }


  void clear() {
    _validateError = null;
    _phone.setText('+38 (0');
    _code.clear();
    _codeRegister.clear();
    _email.clear();
    _password.clear();
    _confirmPassword.clear();
    _firstName.clear();
    _lastName.clear();
    _surname.clear();
    _schoolName.clear();
    _street.clear();
    _house.clear();
    notifyListeners();
  }

  void clearCode() {
    _codeRegister.clear();
    notifyListeners();
  }
}
