// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonsList _$LessonsListFromJson(Map<String, dynamic> json) => LessonsList(
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonsListToJson(LessonsList instance) =>
    <String, dynamic>{
      'lessons': instance.lessons,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as int,
      name: json['name'] as String?,
      lessonStart: json['lesson_start'] as String?,
      startLesson: json['start_lesson'] as String?,
      start: json['start'] as String?,
      end: json['end'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      schoolClass: json['school_class'] == null
          ? null
          : SchoolClass.fromJson(json['school_class'] as Map<String, dynamic>),
      isVisitsExists: json['is_visits_exists'] as bool?,
      zoomMeeting: json['zoom_meeting'] == null
          ? null
          : ZoomMeeting.fromJson(json['zoom_meeting'] as Map<String, dynamic>),
    )..day = (json['day'] as List<dynamic>?)
        ?.map((e) => ListDay.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lesson_start': instance.lessonStart,
      'start_lesson': instance.startLesson,
      'start': instance.start,
      'end': instance.end,
      'services': instance.services,
      'school_class': instance.schoolClass,
      'day': instance.day,
      'is_visits_exists': instance.isVisitsExists,
      'zoom_meeting': instance.zoomMeeting,
    };

SchoolClass _$SchoolClassFromJson(Map<String, dynamic> json) => SchoolClass(
      id: json['id'] as int,
      schoolId: json['school_id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SchoolClassToJson(SchoolClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'name': instance.name,
    };

ListDay _$ListDayFromJson(Map<String, dynamic> json) => ListDay(
      name: json['name'] as String,
      define: json['define'] as String,
    );

Map<String, dynamic> _$ListDayToJson(ListDay instance) => <String, dynamic>{
      'name': instance.name,
      'define': instance.define,
    };

ZoomMeeting _$ZoomMeetingFromJson(Map<String, dynamic> json) => ZoomMeeting(
      startUrl: json['start_url'] as String?,
      joinUrl: json['join_url'] as String?,
    );

Map<String, dynamic> _$ZoomMeetingToJson(ZoomMeeting instance) =>
    <String, dynamic>{
      'start_url': instance.startUrl,
      'join_url': instance.joinUrl,
    };
