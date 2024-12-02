import 'dart:io';

import 'package:dio/dio.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/domain/services/school_service.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../ui/utils/show_message.dart';
import '../../../ui/widgets/snackbars.dart';
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
  final TextEditingController _country = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _house = TextEditingController();
  final MaskedTextController _phone = MaskedTextController(
      mask: '+00 (000) 000 00 00'
  );
  final TextEditingController _email = TextEditingController();
  final TextEditingController _siteAddress = TextEditingController();
  ValidateError? _validateError;
  Map<String, dynamic>? _schoolCategory;


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
  TextEditingController get city => _city;
  TextEditingController get country => _country;
  TextEditingController get siteAddress => _siteAddress;
  Map<String, dynamic>? get schoolCategory => _schoolCategory;

  TextEditingController get instagramField => _instagramField;
  TextEditingController get facebookField => _facebookField;
  TextEditingController get linkedinField => _linkedinField;
  TextEditingController get twitterField => _twitterField;


  void changeClear(TextEditingController controller){
    controller.clear();
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
    _country.text = userData?.school?.country ?? '';
    _city.text = userData?.school?.city ?? '';
    _street.text = userData?.school?.street ?? '';
    _house.text = userData?.school?.house ?? '';
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
          _country.text,
          _city.text,
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

  Future<void> saveGeneralInfo() async {
    _isLoading = true;
    _validateError = null;
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