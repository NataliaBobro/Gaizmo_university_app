import 'package:dio/dio.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/services/schedule_service.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../../../ui/screens/teacher/schedule/filter/schedule_filter_screen.dart';
import '../../../ui/screens/teacher/schedule/widgets/add_lesson_screen.dart';
import '../../../ui/utils/show_message.dart';
import '../../../ui/widgets/snackbars.dart';
import '../../models/lesson.dart';
import '../../models/schedule.dart';

class TeacherScheduleState with ChangeNotifier {
  BuildContext context;
  int _filterDateIndex = 5;
  int? _editId;
  bool _isLoading = true;
  ScheduleMeta? _scheduleMeta;
  List<dynamic>? _selectService;
  Map<String, dynamic>? _selectClass;
  ValidateError? _validateError;
  LessonsList? _lessonsList;
  String? _selectColor;
  final TextEditingController _lessonName = TextEditingController();
  final FilterSchedule _filterSchedule = FilterSchedule(
      type: [],
      teacher: [],
      selectClass: []
  );
  List<Map<String, String>> _dayListSelected = [];
  List<Map<String, dynamic>> _listServices = [];
  List<Map<String, dynamic>> _listClass = [];
  List<Map<String, dynamic>> _listTeacher = [];
  String? get selectColor => _selectColor;
  final MaskedTextController _duration = MaskedTextController(mask: '00 : 00');
  TextEditingController get lessonName => _lessonName;
  final MaskedTextController _lessonStart = MaskedTextController(mask: '00 : 00');
  final TextEditingController _repeatsStart = MaskedTextController(
      mask: '00.00.0000'
  );
  final MaskedTextController _repeatsEnd = MaskedTextController(
      mask: '00.00.0000'
  );

  TeacherScheduleState(this.context){
    Future.microtask(() async {
      await getLesson();
      fetchMeta();
    });
  }

  int get filterDateIndex => _filterDateIndex;
  int? get editId => _editId;
  bool get isLoading => _isLoading;
  TextEditingController get duration => _duration;
  FilterSchedule get filterSchedule => _filterSchedule;
  LessonsList? get lessonsList => _lessonsList;
  ScheduleMeta? get scheduleMeta => _scheduleMeta;
  List<dynamic>? get selectService => _selectService;
  Map<String, dynamic>? get selectClass => _selectClass;
  List<Map<String, dynamic>> get listTypeServices => _listServices;
  List<Map<String, dynamic>> get listTeacher => _listTeacher;
  List<Map<String, dynamic>> get listClass => _listClass;
  TextEditingController get lessonStart => _lessonStart;
  TextEditingController get repeatsStart => _repeatsStart;
  TextEditingController get repeatsEnd => _repeatsEnd;
  List<Map<String, String>> get dayListSelected => _dayListSelected;
  ValidateError? get validateError => _validateError;

  void changeDateFilter(index) {
    _filterDateIndex = index;
    notifyListeners();
    getLesson();
  }

  void changeRepeatsStart(value){
    _repeatsStart.text = value;
    notifyListeners();
  }

  void changeRepeatsEnd(value){
    _repeatsEnd.text = value;
    notifyListeners();
  }
  void changeLessonStart(value){
    _lessonStart.text = value;
    notifyListeners();
  }

  void selectServiceColor(value){
    _selectColor = value;
    notifyListeners();
  }

  void changeFilterType(List<int>value) {
    _filterSchedule.type = value;
    notifyListeners();
  }

  void changeFilterTeacher(List<int>value) {
    _filterSchedule.teacher = value;
    notifyListeners();
  }

  void changeFilterClass(List<int>value) {
    _filterSchedule.selectClass = value;
    notifyListeners();
  }

  void clearEndDate() {
    _repeatsEnd.clear();
    notifyListeners();
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
    for(var a = 0; a < _dayListSelected.length; a++){
      if(value['define'] == _dayListSelected[a]['define']){
        _dayListSelected.removeAt(a);
        notifyListeners();
        return;
      }
    }
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

  Future<void> openFilter() async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: const ScheduleFilterScreen(),
            )
        )
    );
  }

  Future<void> openEditLesson(Lesson? lesson) async{
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: AddLessonScreen(
                  edit: lesson
              ),
            )
        )
    );
  }

  void initEditData(Lesson? edit) {
    _editId = edit?.id;
    _lessonName.text = '${edit?.name}';
    _selectService = [];
    for(var a = 0; a < (edit?.services?.length ?? 0); a++){
      _selectService?.add({
        "id": edit?.services?[a]?.id,
        "name": edit?.services?[a]?.name,
      });
    }
    if(edit?.schoolClass?.id != null){
      _selectClass = _listClass.firstWhere((element) => element['id'] == edit?.schoolClass?.id);
    }

    _lessonStart.text = '${edit?.startLesson}';
    _repeatsStart.text = '${edit?.start?.replaceAll('-', '')}';
    _repeatsEnd.text = '${edit?.end?.replaceAll('-', '')}';

    _duration.text = '${((edit?.duration ?? 0) ~/ 60).toString().padLeft(2, '0')}${(edit?.duration ?? 0) % 60}';
    _selectColor = edit?.color;

    final date = DateTime.parse('${edit?.start}');
    _repeatsStart.text =
    '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

    if(edit?.end != null){
      final dateEnd = DateTime.parse('${edit?.end}');
      _repeatsEnd.text =
      '${dateEnd.day.toString().padLeft(2, '0')}.${dateEnd.month.toString().padLeft(2, '0')}.${dateEnd.year}';
    }

    _dayListSelected = [];
    if(edit?.day != null){
      for(var a = 0; a < (edit?.day?.length ?? 0); a++){
        _dayListSelected.add({
          'define': '${edit?.day?[a].define}',
          'name': '${edit?.day?[a].name}',
        });
      }
    }
    notifyListeners();
  }

  Future<void> fetchMeta() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await ScheduleService.fetchMetaTeacher(context);
      if(result != null){
        _scheduleMeta = result;
        _listServices = [];
        if(result.services != null){
          for(var a = 0; a < (result.services?.length ?? 0); a++){
            _listServices.add({
              "id": result.services?[a]?.id,
              "name": result.services?[a]?.name,
            });
          }
        }
        _listClass = [];
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
      _lessonsList = await ScheduleService.getLessonTeacher(
          context,
          date.toString(),
          filterSchedule
      );
    }catch (e) {
      if(kDebugMode){
        print(e);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteLesson(int? id) async {
    DateTime now = DateTime.now();
    DateTime date = now.add(Duration(days: _filterDateIndex - 5));
    try{
      final result = await ScheduleService.deleteLesson(context, id, date.toString());
      if(result == true){
        getLesson();
      }
    }catch (e) {
      if(kDebugMode){
        print(e);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> addOrEditLesson() async {
    _validateError = null;
    notifyListeners();
    int duration = 0;
    if(_duration.text.isNotEmpty) {
      List<String> parts = _duration.text.split(' : ');
      if(parts.length < 2) return;
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      duration = hours * 60 + minutes;
    }

    final user = context.read<AppState>().userData;

    Map<String, dynamic> data = {
      'id': _editId,
      'teacher_id': user?.id,
      'lesson_name': _lessonName.text,
      'color': _selectColor,
      'duration': duration,
      'service': _selectService,
      'school_class':  _selectClass?['id'],
      'start_lesson': _lessonStart.text.replaceAll(' ', ''),
      'start': _repeatsStart.text,
      'end': _repeatsEnd.text,
      'day': _dayListSelected,
    };

    try {
      final result = await ScheduleService.addLessonTeacher(
          context,
          data
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