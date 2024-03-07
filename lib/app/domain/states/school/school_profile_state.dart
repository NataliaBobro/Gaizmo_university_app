import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etm_crm/app/app.dart';
import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/school_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../ui/utils/show_message.dart';
import '../../../ui/widgets/snackbars.dart';
import '../../services/app_ninjas_service.dart';
import '../../services/user_service.dart';

class SchoolProfileState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  bool _loadingSearch = false;
  Map<String, dynamic>? _selectLanguage;
  final TextEditingController _instagramField = TextEditingController();
  final TextEditingController _facebookField = TextEditingController();
  final TextEditingController _linkedinField = TextEditingController();
  final TextEditingController _twitterField = TextEditingController();


  final TextEditingController _nameSchool = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _house = TextEditingController();
  final MaskedTextController _phone = MaskedTextController(
      mask: '+00 (000) 000 00 00'
  );
  final TextEditingController _email = TextEditingController();
  final TextEditingController _siteAddress = TextEditingController();
  ValidateError? _validateError;
  Map<String, dynamic>? _schoolCategory;
  List<dynamic>? _countryList;
  List<dynamic>? _cityList;
  Map<String, dynamic>? _country;
  Map<String, dynamic>? _city;
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


  SchoolProfileState(this.context){
    setFieldSetting();
  }

  Map<String, dynamic>? get selectLanguage {
    if(_selectLanguage != null) return _selectLanguage;
    final appStateLanguage = context.read<AppState>().metaAppData?.language;
    final activeLang = appStateLanguage?.firstWhere(
            (element) => element.id == context.read<AppState>().userData?.languageId);
    return  {
      "id": activeLang?.id,
      "name": activeLang?.name
    };
  }
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

  bool get isLoading => _isLoading;
  bool get loadingSearch => _loadingSearch;
  ValidateError? get validateError => _validateError;
  TextEditingController get nameSchool => _nameSchool;
  TextEditingController get street => _street;
  TextEditingController get house => _house;
  TextEditingController get phone => _phone;
  TextEditingController get email => _email;
  TextEditingController get siteAddress => _siteAddress;
  Map<String, dynamic>? get schoolCategory => _schoolCategory;
  List<Map<String, dynamic>> get listDefaultCountry => _listDefaultCountry;
  Map<String, dynamic>? get country => _country;
  Map<String, dynamic>? get city => _city;

  TextEditingController get instagramField => _instagramField;
  TextEditingController get facebookField => _facebookField;
  TextEditingController get linkedinField => _linkedinField;
  TextEditingController get twitterField => _twitterField;


  void changeClear(TextEditingController controller){
    controller.clear();
  }

  void changeCountry(value) {
    _country = value;
    notifyListeners();
  }

  void changeCity(value) {
    _city = value;
    notifyListeners();
  }

  void setFieldSetting() {
    final userData = context.read<AppState>().userData;
    _nameSchool.text = '${userData?.school?.name}';
    _siteAddress.text = userData?.school?.siteName != null ? '${userData?.school?.siteName}' : '';

    _phone.text = '${userData?.phone}';
    _email.text = '${userData?.email}';

    _schoolCategory = {
      'id': userData?.school?.category?.id,
      'name': userData?.school?.category?.translate?.value,
    };
    _country = {
      'id': 0,
      'name': userData?.school?.country,
    };
    _city = {
      'id': 0,
      'name': userData?.school?.city,
    };
    _street.text = '${userData?.school?.street}';
    _house.text = '${userData?.school?.house}';
    _instagramField.text = '${userData?.socialAccounts?.instagram}';
    _facebookField.text = '${userData?.socialAccounts?.facebook}';
    _linkedinField.text = '${userData?.socialAccounts?.linkedin}';
    _twitterField.text = '${userData?.socialAccounts?.twitter}';
    notifyListeners();
  }

  void changeLanguage(value) {
    _selectLanguage = value;
    saveLanguage();
    notifyListeners();
  }

  void changeSchoolCategory(value) {
    _schoolCategory = value;
    notifyListeners();
  }


  Future<void> saveLanguage() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await UserService.changeLanguage(
          context,
          _selectLanguage?['id']
      );
      if(result == true){
        setUserLanguage();
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveCategory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await SchoolService.changeCategory(
          context,
          _schoolCategory?['id']
      );
      if(result == true){
        updateUser();
        close();
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveAddress() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await SchoolService.changeAddress(
          context,
          _country?['name'],
          _city?['name'],
          _street.text,
          _house.text,
      );
      if(result == true){
        updateUser();
        close();
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

  Future<void> saveGeneralInfo() async {
    _isLoading = true;
    notifyListeners();

    final userId = context.read<AppState>().userData?.id;
    try {
      final result = await UserService.changeGeneralInfo(
          context,
          userId,
          _nameSchool.text,
          _phone.text,
          _email.text,
          _siteAddress.text
      );
      if(result == true){
        setUser();
        close();
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

  Future<void> saveSocialLinks() async {
    _isLoading = true;
    notifyListeners();
    final userId = context.read<AppState>().userData?.id;
    try {
      final result = await UserService.changeSocialAccounts(
          context,
          userId,
          _instagramField.text,
          _facebookField.text,
          _linkedinField.text,
          _twitterField.text
      );
      if(result == true){
        close();
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

  Future<void> uploadAvatar(File file, {int? uploadUserId}) async {
    final userId = uploadUserId ?? context.read<AppState>().userData?.id;
    try {
      final result = await UserService.uploadAvatar(context, userId, file);
      if(result != null){
       updateUser();
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

  void setUser() {
    UserData? user = context.read<AppState>().userData;
    user?.school?.name = _email.text;
    user?.phone = _phone.text;
    user?.email = _email.text;
    context.read<AppState>().setUser(user!);
    notifyListeners();
  }

  void setUserLanguage() {
    context.read<AppState>().changeLanguage(_selectLanguage?['id']);
    notifyListeners();
  }

  void updateUser() {
    context.read<AppState>().getUser();
    notifyListeners();
  }

  void close(){
    Navigator.pop(context);
  }

}