import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:etm_crm/app/domain/services/schedule_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../ui/screens/school/schedule/widgets/add_lesson_screen.dart';
import '../../../ui/utils/show_message.dart';
import '../../../ui/widgets/snackbars.dart';
import '../../models/schedule.dart';

class SchoolScheduleState with ChangeNotifier {
  BuildContext context;
  int _filterDateIndex = 5;
  bool _isLoading = false;
  ScheduleMeta? _scheduleMeta;
  Map<String, dynamic>? _selectService;
  Map<String, dynamic>? _selectClass;
  ValidateError? _validateError;
  List<Map<String, String>> _dayListSelected = [];
  final List<Map<String, dynamic>> _listServices = [];
  final List<Map<String, dynamic>> _listClass = [];
  final MaskedTextController _lessonStart = MaskedTextController(mask: '00 : 00');
  final MaskedTextController _repeatsStart = MaskedTextController(
      mask: '00.00.0000'
  );
  final MaskedTextController _repeatsEnd = MaskedTextController(
      mask: '00.00.0000'
  );

  SchoolScheduleState(this.context){
    Future.microtask(() async {
      await getLesson();
    });
  }

  int get filterDateIndex => _filterDateIndex;
  bool get isLoading => _isLoading;
  ScheduleMeta? get scheduleMeta => _scheduleMeta;
  Map<String, dynamic>? get selectService => _selectService;
  Map<String, dynamic>? get selectClass => _selectClass;
  List<Map<String, dynamic>> get listTypeServices => _listServices;
  List<Map<String, dynamic>> get listClass => _listClass;
  TextEditingController get lessonStart => _lessonStart;
  TextEditingController get repeatsStart => _repeatsStart;
  TextEditingController get repeatsEnd => _repeatsEnd;
  List<Map<String, String>> get dayListSelected => _dayListSelected;
  ValidateError? get validateError => _validateError;

  void changeDateFilter(index) {
    _filterDateIndex = index;
    notifyListeners();
  }

  void clearEndDate() {
    _repeatsEnd.clear();
  }


  void selectAddService(value){
    _selectService = value;
    notifyListeners();
  }
  void changeClass(value){
    _selectClass = value;
    notifyListeners();
  }
  void changeSelectDay(value){
    _dayListSelected.contains(value) ?
      _dayListSelected.remove(value) :
      _dayListSelected.add(value);
    notifyListeners();
  }

  Future<void> addLesson() async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: const AddLessonScreen(),
            )
        )
    );
  }

  Future<void> fetchMeta() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await ScheduleService.fetchMeta(context);
      if(result != null){
        _scheduleMeta = result;
        if(result.services != null){
          for(var a = 0; a < (result.services?.length ?? 0); a++){
            _listServices.add({
              "id": result.services?[a]?.id,
              "name": result.services?[a]?.name,
            });
          }
        }
        if(result.schoolClass != null){
          for(var a = 0; a < (result.schoolClass?.length ?? 0); a++){
            _listClass.add({
              "id": result.schoolClass?[a]?.id,
              "name": result.schoolClass?[a]?.name,
            });
          }
        }
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

  Future<void> getLesson() async {
    DateTime now = DateTime.now();
    DateTime date = now.add(Duration(days: _filterDateIndex - 5));
    try{
      final result = await ScheduleService.getLesson(context, date.toString());
      print(result);
    }catch (e) {
      print(e);
    }
  }

  Future<void> addOrEditLesson() async {
    _validateError = null;
    notifyListeners();
    try {
      final result = await ScheduleService.addLesson(
          context,
          _selectService?['id'],
          _selectClass?['id'],
          _lessonStart.text,
          _repeatsStart.text,
          _repeatsEnd.text,
          _dayListSelected
      );
      if(result != null){
        clear();
        back();
        getLesson();
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

  void back(){
    Navigator.pop(context);
  }

  void clear() {
    _selectService = null;
    _selectClass = null;
    _lessonStart.clear();
    _repeatsStart.clear();
    _repeatsEnd.clear();
    _dayListSelected = [];
    notifyListeners();
  }
}