import 'package:etm_crm/app/domain/models/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ScheduleMeta {
  List<ServicesModel?>? services;
  List<SchoolClassModel?>? schoolClass;

  ScheduleMeta({
    this.services,
    this.schoolClass,
  });

  Map<String, dynamic> toJson() => _$ScheduleMetaToJson(this);

  factory ScheduleMeta.fromJson(Map<String, dynamic> json) => _$ScheduleMetaFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class SchoolClassModel {
  int? id;
  String? name;
  int? schoolId;

  SchoolClassModel({
    this.id,
    this.name,
    this.schoolId,
  });

  Map<String, dynamic> toJson() => _$SchoolClassModelToJson(this);

  factory SchoolClassModel.fromJson(Map<String, dynamic> json) => _$SchoolClassModelFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class FilterSchedule {
  List<int> type = [];
  List<int> teacher = [];
  List<int> selectClass = [];

  FilterSchedule({
    required this.type,
    required this.teacher,
    required this.selectClass,
  });

  Map<String, dynamic> toJson() => _$FilterScheduleToJson(this);
  factory FilterSchedule.fromJson(Map<String, dynamic> json) => _$FilterScheduleFromJson(json);
}


