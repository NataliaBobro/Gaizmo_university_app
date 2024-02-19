import 'package:etm_crm/app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../ui/widgets/results/add/add_image.dart';
import '../models/results.dart';
import '../models/schedule.dart';
import 'dart:io';

import '../services/result_service.dart';


class MyResultsState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = false;
  bool _isLoadingAdd = false;
  ResultsModel? _resultsModel;
  List<Map<String, dynamic>> _listServices = [];
  final FilterSchedule _filterSchedule = FilterSchedule(
      type: [],
      teacher: [],
      selectClass: []
  );
  File? _selectFile;


  MyResultsState(this.context){
    Future.microtask(() async {
      await fetchList();
      await fetchMetaResults();
    });
  }

  bool get isLoading => _isLoading;
  bool get isLoadingAdd => _isLoadingAdd;
  ResultsModel? get resultsModel => _resultsModel;
  FilterSchedule get filterSchedule => _filterSchedule;
  List<Map<String, dynamic>> get listTypeServices => _listServices;
  File? get selectFile => _selectFile;

  void changeFile(file) {
    _selectFile = file;
    notifyListeners();
  }

  void removeFile() {
    _selectFile = null;
    notifyListeners();
  }

  void onChangeFilter(value)
  {
    fetchList(filterService: value['id']);
  }

  Future<void> fetchList({int? filterService})async {
    _isLoading = true;
    notifyListeners();

    try{
      final result = await ResultService.fetchList(context, filterService);
      if(result != null){
        _resultsModel = result;
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addResult() async {
    _isLoadingAdd = true;
    notifyListeners();
    final service = _listServices.firstWhere((element) => element['id'] == _filterSchedule.type.first);
    try{
      final result = await ResultService.addResult(
        context,
        service['id'],
        _selectFile!
      );
      if(result == true){
        close();
      }
    }catch(e){
      print(e);
    }finally{
      _isLoadingAdd = false;
      notifyListeners();
    }
  }

  Future<void> fetchMetaResults() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await ResultService.fetchMeta(context);
      if (result != null) {
        _listServices = [];
        if (result.services != null) {
          for (var a = 0; a < (result.services?.length ?? 0); a++) {
            _listServices.add({
              "id": result.services?[a]?.id,
              "name": result.services?[a]?.name,
            });
          }
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> openAddPhoto() async {
    await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    isDismissible: true,
    useRootNavigator: true,
    barrierColor: Colors.black.withOpacity(.75),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (_) {
        return ChangeNotifierProvider.value(
            value: this,
            child: SizedBox(
              height: SizerUtil.height,
              child: const AddImage(),
            )
        );
      },
    );
  }

  void changeFilterType(int value) {
    _filterSchedule.type = [value];
    notifyListeners();
  }

  void close() {
    routemaster.pop('close');
    Navigator.pop(context);
  }
}