import 'dart:async';

import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/models/services.dart';
import 'package:european_university_app/app/domain/services/meta_service.dart';
import 'package:european_university_app/app/domain/services/services_service.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../ui/screens/school/service/widgets/add_service_screen.dart';
import '../../ui/utils/show_message.dart';
import '../../ui/widgets/snackbars.dart';
import '../models/meta.dart';
import '../models/user.dart';
import 'dart:io';

class ServicesState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  int? _onEditId;
  dynamic editedService;

  bool get isLoading => _isLoading;
  int? get onEditId => _onEditId;
  ValidateError? _validateError;
  List<ServicesCategory> _servicesCategory = [];
  List<ServicesModel?> _allServices = [];

  Map<String, dynamic>? _selectService;
  Map<String, dynamic>? _selectBranch;
  UserData? _selectTeacher;
  Map<String, dynamic>? _selectCategory;
  Map<String, dynamic>? _selectValidityType;
  Map<String, dynamic>? _selectCurrency;
  String? _selectColor;
  File? _uploadsFile;
  final TextEditingController _categoryName = TextEditingController();
  final TextEditingController _serviceName = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final MaskedTextController _visits = MaskedTextController(mask: '000');
  final MaskedTextController _cost = MaskedTextController(mask: '00000');
  final MaskedTextController _etm = MaskedTextController(mask: '00000');
  final MaskedTextController _validity = MaskedTextController(mask: '00');
  final MaskedTextController _duration = MaskedTextController(mask: '00 : 00');
  final List<Map<String, dynamic>> _listTypeServices = [
    {
      "id": 1,
      "name": getConstant('Category')
    },
    {
      "id": 2,
      "name": getConstant('Service')
    }
  ];

  List<UserData>? _listTeacherData = [];
  List<UserData>? _listBranchData = [];
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


  ServicesState(this.context){
    Future.microtask(() {
      fetchServices();
    });
  }

  ValidateError? get validateError => _validateError;
  List<ServicesCategory> get servicesCategory => _servicesCategory;
  List<ServicesModel?> get allServices => _allServices;
  List<Map<String, dynamic>> get listTypeServices => _listTypeServices;
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

  List<Map<String, dynamic>> get listBranch {
    List<Map<String, dynamic>> list = [
      {
        "id": 0,
        "name": "All branches"
      }
    ];
    for(var a = 0; a < (_listBranchData?.length ?? 0); a++){
      list.add({
        "id": _listBranchData?[a].school?.id,
        "name": '${_listBranchData?[a].school?.name}'
      });
    }
    return list;
  }

  List<UserData>? get listTeacherData => _listTeacherData;
  List<UserData>? get listBranchData => _listBranchData;
  List<Map<String, dynamic>> get listValidityType => _listValidityType;
  List<Map<String, dynamic>> get listCurrency => _listCurrency;
  Map<String, dynamic>? get selectService => _selectService;
  Map<String, dynamic>? get selectBranch => _selectBranch;
  Map<String, dynamic>? get selectCategory => _selectCategory;
  UserData? get selectTeacher => _selectTeacher;
  Map<String, dynamic>? get selectValidityType => _selectValidityType;
  Map<String, dynamic>? get selectCurrency => _selectCurrency;
  TextEditingController get categoryName => _categoryName;
  TextEditingController get serviceName => _serviceName;
  TextEditingController get desc => _desc;
  TextEditingController get validity => _validity;
  TextEditingController get duration => _duration;
  TextEditingController get visits => _visits;
  TextEditingController get cost => _cost;
  TextEditingController get etm => _etm;
  String? get selectColor => _selectColor;
  File? get uploadsFile => _uploadsFile;

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

  void selectImage(value){
    _uploadsFile = value;
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

  Future<void> onEdit(dynamic services) async {
    _onEditId = null;
    editedService = services;
    notifyListeners();
    await Future.microtask(() async {
      await openAddOrEditService(isEdit: true);
    });
  }

  void setStateEdit() {
    if(editedService is ServicesCategory){
      ServicesCategory serCat = editedService;
      _categoryName.text = serCat.name;
      _selectService = listTypeServices.first;
      _selectColor = serCat.color;
      _onEditId = serCat.id;
    }
    if(editedService is ServicesModel){
      ServicesModel servEdit = editedService;
      _selectService = listTypeServices.last;
      _serviceName.text = servEdit.name;
      if(servEdit.desc != null){
        _desc.text = '${servEdit.desc}';
      }

      _selectBranch = listBranch.firstWhere((element) => element['id'] == (servEdit.branchId ?? 0));
      // if((_listTeacherData?.length ?? 0) > 0){
      //   _selectTeacher = _listTeacherData?.firstWhere((element) => element.id == (servEdit.teacher?.id ?? 0));
      // }
      _selectCurrency = _listCurrency.firstWhere((element) => element['id'] == servEdit.currency?.id);
      _selectValidityType = _listValidityType.firstWhere((element) => element['name'] == servEdit.validityType);
      _etm.text = '${servEdit.etm}';
      _cost.text = '${servEdit.cost}';
      _visits.text = '${servEdit.numberVisits}';
      if(servEdit.serviceCategory != null){
        _selectCategory = listCategory.firstWhere((element) => element['id'] == servEdit.serviceCategory);
      }
      _selectColor = servEdit.color;
      _validity.text = '${servEdit.validity}';
      // _duration.text = '${(servEdit.duration! ~/ 60).toString().padLeft(2, '0')}${servEdit.duration! % 60}';
      _onEditId = servEdit.id;
    }
    notifyListeners();
  }

  Future<void> fetchServices({String? search}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await ServicesService.fetchService(context, search);
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

  Future<void> openAddOrEditService({bool isEdit = false}) async {
    if(isEdit == false){
      _onEditId = null;
      notifyListeners();
    }
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: AddServiceScreen(
                  isEdit: isEdit
              ),
            )
        )
    );
  }

  Future<void> getMeta() async {
    try {
      final result = await MetaService.getAddServiceMeta(context);
      if(result?.teacher != null){
        _listTeacherData = result?.teacher;
      }

      if(result?.branch != null){
        _listBranchData = result?.branch;
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

  Future<void> addOrEditCategory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = _onEditId != null ?
          await ServicesService.editCategory(
          context,
          _onEditId,
          _categoryName.text,
          _selectColor ?? ''
      ) : await ServicesService.addCategory(
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

  Future<void> addOrEditServiceService() async {
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
      final result = await ServicesService.addOrEditService(
          context,
          _onEditId,
          _serviceName.text,
          _desc.text,
          _selectColor ?? '',
          _selectBranch?['id'],
          _selectCategory?['id'],
          _selectTeacher?.id,
          _validity.text.isNotEmpty ? int.parse(_validity.text) : 0,
          _selectValidityType?['name'],
          duration,
          _visits.text,
          _cost.text,
          _selectCurrency?['id'],
          _etm.text,
          _uploadsFile
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
  
  Future<void> deleteService(ServicesModel service) async {
    try {
      final result = await ServicesService.deleteService(
          context,
          service.id,
      );
      if(result == true){
        for(var a = 0; a < servicesCategory.length; a++){
          final delService = servicesCategory[a].services?.indexOf(service);
          if(delService != -1){
            servicesCategory[a].services?.removeAt(delService!);
            break;
          }
        }
        for(var a = 0; a < allServices.length; a++){
          if(allServices[a]?.id == service.id){
            allServices.remove(allServices[a]);
          }
        }
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteCategory(ServicesCategory category) async {
    try {
      final result = await ServicesService.deleteCategory(
        context,
        category.id,
      );
      if(result == true){
        for(var a = 0; a < servicesCategory.length; a++){
          if(servicesCategory[a].id == category.id){
            servicesCategory.remove(servicesCategory[a]);
            break;
          }
        }
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
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
    _desc.clear();
    _visits.clear();
    _uploadsFile = null;
    notifyListeners();
  }
}