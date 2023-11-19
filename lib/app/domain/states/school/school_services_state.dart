import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/services.dart';
import 'package:etm_crm/app/domain/services/meta_service.dart';
import 'package:etm_crm/app/domain/services/services_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../ui/screens/school/service/widgets/add_service_screen.dart';
import '../../../ui/utils/show_message.dart';
import '../../../ui/widgets/snackbars.dart';
import '../../models/meta.dart';

class SchoolServicesState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  ValidateError? _validateError;
  List<ServicesCategory> _servicesCategory = [];
  List<ServicesModel?> _allServices = [];

  Map<String, dynamic>? _selectService;
  Map<String, dynamic>? _selectBranch;
  Map<String, dynamic>? _selectCategory;
  Map<String, dynamic>? _selectTeacher;
  Map<String, dynamic>? _selectValidityType;
  Map<String, dynamic>? _selectCurrency;
  String? _selectColor;
  final TextEditingController _categoryName = TextEditingController();
  final TextEditingController _serviceName = TextEditingController();
  final TextEditingController _visits = TextEditingController();
  final MaskedTextController _cost = MaskedTextController(mask: '00000');
  final MaskedTextController _etm = MaskedTextController(mask: '00000');
  final MaskedTextController _validity = MaskedTextController(mask: '00');
  final MaskedTextController _duration = MaskedTextController(mask: '00 : 00');
  final List<Map<String, dynamic>> _listTypeServices = [
    {
      "id": 1,
      "name": "Category"
    },
    {
      "id": 2,
      "name": "Service"
    }
  ];

  final List<Map<String, dynamic>> _listBranch = [
    {
      "id": 1,
      "name": "All branches"
    }
  ];

  List<Map<String, dynamic>> _listTeacher = [];
  List<Map<String, dynamic>> _listCurrency = [];
  final List<Map<String, dynamic>> _listValidityType = [
    {
      "id": 1,
      "name": "Day"
    },{
      "id": 2,
      "name": "Month"
    },{
      "id": 3,
      "name": "Year"
    },
  ];


  SchoolServicesState(this.context){
    Future.microtask(() {
      fetchServices();
    });
  }

  ValidateError? get validateError => _validateError;
  List<ServicesCategory> get servicesCategory => _servicesCategory;
  List<ServicesModel?> get allServices => _allServices;
  List<Map<String, dynamic>> get listTypeServices => _listTypeServices;
  List<Map<String, dynamic>> get listBranch => _listBranch;
  List<Map<String, dynamic>> get listCategory {
    List<Map<String, dynamic>> list = [];
    for(var a = 0; a < _servicesCategory.length; a++){
      list.add({
        "id": _servicesCategory[a].id,
        "name": _servicesCategory[a].name
      });
    }
    return list;
  }
  List<Map<String, dynamic>> get listTeacher => _listTeacher;
  List<Map<String, dynamic>> get listValidityType => _listValidityType;
  List<Map<String, dynamic>> get listCurrency => _listCurrency;
  Map<String, dynamic>? get selectService => _selectService;
  Map<String, dynamic>? get selectBranch => _selectBranch;
  Map<String, dynamic>? get selectCategory => _selectCategory;
  Map<String, dynamic>? get selectTeacher => _selectTeacher;
  Map<String, dynamic>? get selectValidityType => _selectValidityType;
  Map<String, dynamic>? get selectCurrency => _selectCurrency;
  TextEditingController get categoryName => _categoryName;
  TextEditingController get serviceName => _serviceName;
  TextEditingController get validity => _validity;
  TextEditingController get duration => _duration;
  TextEditingController get visits => _visits;
  TextEditingController get cost => _cost;
  TextEditingController get etm => _etm;
  String? get selectColor => _selectColor;

  void selectServiceType(value){
    _selectService = value;
    notifyListeners();
  }

  void selectBranchType(value){
    _selectBranch = value;
    notifyListeners();
  }

  void changeCategory(value){
    _selectCategory = value;
    notifyListeners();
  }

  void changeCurrency(value){
    _selectCurrency = value;
    notifyListeners();
  }

  void changeSelectTeacher(value){
    _selectTeacher = value;
    notifyListeners();
  }

  void changeValidityType(value){
    _selectValidityType = value;
    notifyListeners();
  }

  void selectServiceColor(value){
    _selectColor = value;
    notifyListeners();
  }

  Future<void> fetchServices() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await ServicesService.fetchService(context);
      if(result != null){
        _servicesCategory = result.category ?? [];
        _allServices = result.allService ?? [];
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

  void openAddService() {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: const AddServiceScreen(),
            )
        )
    );
  }

  Future<void> getMeta() async {
    try {
      final result = await MetaService.getAddServiceMeta(context);
      if(result?.teacher != null){
        _listTeacher = [];
        for(var a = 0; a < (result?.teacher?.length ?? 0); a++) {
            _listTeacher.add(
              {
                "id": result?.teacher?[a].id,
                "name": result?.teacher?[a].firstName
              }
          );
        }
      }

      if(result?.currency != null){
        _listCurrency = [];
        for(var a = 0; a < (result?.currency?.length ?? 0); a++) {
          _listCurrency.add(
              {
                "id": result?.currency?[a].id,
                "name": result?.currency?[a].name
              }
          );
        }
      }
    } on DioError catch (e) {
      showMessage(e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCategory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await ServicesService.addCategory(
          context,
          _categoryName.text,
          _selectColor ?? ''
      );
      if(result != null){
        fetchServices();
        clear();
        back();
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

  Future<void> addService() async {
    int duration = 0;
    if(_duration.text.isNotEmpty) {
      List<String> parts = _duration.text.split(' : ');
      if(parts.length < 2) return;
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      duration = hours * 60 + minutes;
    }
    _isLoading = true;
    notifyListeners();
    try {
      final result = await ServicesService.addService(
          context,
          _serviceName.text,
          _selectColor ?? '',
          _selectBranch?['id'],
          _selectCategory?['id'],
          _selectTeacher?['id'],
          _validity.text.isNotEmpty ? int.parse(_validity.text) : 0,
          _selectValidityType?['name'],
          duration,
          _visits.text,
          _cost.text,
          _selectCurrency?['id'],
          _etm.text

      );
      if(result != null){
        fetchServices();
        clear();
        back();
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
      print(e);
      showErrorSnackBar(title: 'App request error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void back() {
    Navigator.pop(context);
  }

  void clear() {
    _validateError = null;
    _categoryName.clear();
    _selectColor = null;
    _serviceName.clear();
    _selectBranch = null;
    _selectCategory = null;
    _selectTeacher = null;
    _validity.clear();
    _selectValidityType = null;
    _duration.clear();
    _cost.clear();
    _selectCurrency = null;
    _etm.clear();
    notifyListeners();
  }
}