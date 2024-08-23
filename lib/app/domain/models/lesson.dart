import 'package:european_university_app/app/domain/models/services.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class LessonsList {
  List<Lesson>? lessons;

  LessonsList({
    required this.lessons,
  });

  Map<String, dynamic> toJson() => _$LessonsListToJson(this);

  factory LessonsList.fromJson(Map<String, dynamic> json) => _$LessonsListFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Lesson {
  int id;
  String? name;
  int? teacherId;
  UserData? teacher;
  String? color;
  int duration;
  String? lessonStart;
  String? startLesson;
  String? classId;
  String? start;
  String? end;
  List<ServicesModel?>? services;
  List<ListDay>? day;
  SchoolClass? schoolClass;
  bool? isVisitsExists;
  ZoomMeeting? zoomMeeting;

  Lesson({
    required this.id,
    required this.duration,
    this.name,
    this.teacherId,
    this.teacher,
    this.color,
    this.lessonStart,
    this.startLesson,
    this.classId,
    this.start,
    this.end,
    this.services,
    this.schoolClass,
    this.isVisitsExists,
    this.zoomMeeting,
  });

  Map<String, dynamic> toJson() => _$LessonToJson(this);

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class SchoolClass {
  int id;
  int? schoolId;
  String? name;

  SchoolClass({
    required this.id,
    this.schoolId,
    this.name
  });

  Map<String, dynamic> toJson() => _$SchoolClassToJson(this);

  factory SchoolClass.fromJson(Map<String, dynamic> json) => _$SchoolClassFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ListDay {
  String name;
  String define;

  ListDay({
    required this.name,
    required this.define,
  });

  Map<String, dynamic> toJson() => _$ListDayToJson(this);

  factory ListDay.fromJson(Map<String, dynamic> json) => _$ListDayFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ZoomMeeting {
  String? zoom;
  String? meet;

  ZoomMeeting({
    this.zoom,
    this.meet,
  });

  Map<String, dynamic> toJson() => _$ZoomMeetingToJson(this);

  factory ZoomMeeting.fromJson(Map<String, dynamic> json) => _$ZoomMeetingFromJson(json);
}