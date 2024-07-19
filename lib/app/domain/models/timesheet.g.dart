// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimesheetModel _$TimesheetModelFromJson(Map<String, dynamic> json) =>
    TimesheetModel(
      success: json['success'] as bool,
      timesheet: (json['timesheet'] as List<dynamic>)
          .map((e) => TimesheetItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimesheetModelToJson(TimesheetModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'timesheet': instance.timesheet,
    };

TimesheetItem _$TimesheetItemFromJson(Map<String, dynamic> json) =>
    TimesheetItem(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
      lesson: json['lesson'] == null
          ? null
          : Lesson.fromJson(json['lesson'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimesheetItemToJson(TimesheetItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'lesson_id': instance.lessonId,
      'rating': instance.rating,
      'lesson': instance.lesson,
    };
