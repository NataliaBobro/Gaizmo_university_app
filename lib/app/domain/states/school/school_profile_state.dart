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
import '../../services/user_service.dart';

class SchoolProfileState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  Map<String, dynamic>? _selectLanguage;
  final TextEditingController _nameSchool = TextEditingController();
  final MaskedTextController _phone = MaskedTextController(
      mask: '+00 (000) 000 00 00'
  );
  final MaskedTextController _scheduleFrom = MaskedTextController(
      mask: '00 : 00'
  );
  final MaskedTextController _scheduleTo = MaskedTextController(
      mask: '00 : 00'
  );
  final TextEditingController _email = TextEditingController();
  final TextEditingController _siteAddress = TextEditingController();
  ValidateError? _validateError;
  List<int> _listWorkDay = [];


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
  List<int> get listWorkDay => _listWorkDay;
  ValidateError? get validateError => _validateError;
  TextEditingController get nameSchool => _nameSchool;
  TextEditingController get scheduleFrom => _scheduleFrom;
  TextEditingController get scheduleTo => _scheduleTo;
  TextEditingController get phone => _phone;
  TextEditingController get email => _email;
  TextEditingController get siteAddress => _siteAddress;


  void changeClear(TextEditingController controller){
    controller.clear();
  }

  void setFieldSetting() {
    _nameSchool.text = '${context.read<AppState>().userData?.school?.name}';
    _siteAddress.text = '${context.read<AppState>().userData?.school?.siteName}';
    _scheduleFrom.text = '${context.read<AppState>().userData?.school?.from}';
    _scheduleTo.text = '${context.read<AppState>().userData?.school?.to}';

    _phone.text = '${context.read<AppState>().userData?.phone}';
    _email.text = '${context.read<AppState>().userData?.email}';

    _listWorkDay = [];
    List<WorkDay>? workDayUser = context.read<AppState>().userData?.workDay;
    for(var a = 0; a < (workDayUser?.length ?? 0); a++){
      _listWorkDay.add(workDayUser![a].day);
    }
    notifyListeners();
  }

  void changeLanguage(value) {
    _selectLanguage = value;
    notifyListeners();
  }

  void changeWorkDay(index){
    bool contain = _listWorkDay.contains(index);
    if(contain){
      _listWorkDay.remove(index);
    }else{
      _listWorkDay.add(index);
    }
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

  Future<void> saveGeneralInfo() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await UserService.changeGeneralInfo(
          context,
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

  Future<void> saveSchoolSchedule() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await SchoolService.changeSchoolSchedule(
          context,
          _listWorkDay,
          _scheduleFrom.text.replaceAll(' ', ''),
          _scheduleTo.text.replaceAll(' ', ''),
      );
      if(result == true){
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

  void close(){
    Navigator.pop(context);
  }

}