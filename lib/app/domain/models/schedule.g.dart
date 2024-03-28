// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleMeta _$ScheduleMetaFromJson(Map<String, dynamic> json) => ScheduleMeta(
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      schoolClass: (json['school_class'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SchoolClassModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..teacher = (json['teacher'] as List<dynamic>?)
        ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ScheduleMetaToJson(ScheduleMeta instance) =>
    <String, dynamic>{
      'services': instance.services,
      'school_class': instance.schoolClass,
      'teacher': instance.teacher,
    };

SchoolClassModel _$SchoolClassModelFromJson(Map<String, dynamic> json) =>
    SchoolClassModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      schoolId: json['school_id'] as int?,
    );

Map<String, dynamic> _$SchoolClassModelToJson(SchoolClassModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'school_id': instance.schoolId,
    };

FilterSchedule _$FilterScheduleFromJson(Map<String, dynamic> json) =>
    FilterSchedule(
      type: (json['type'] as List<dynamic>).map((e) => e as int).toList(),
      teacher: (json['teacher'] as List<dynamic>).map((e) => e as int).toList(),
      selectClass:
          (json['select_class'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$FilterScheduleToJson(FilterSchedule instance) =>
    <String, dynamic>{
      'type': instance.type,
      'teacher': instance.teacher,
      'select_class': instance.selectClass,
    };
