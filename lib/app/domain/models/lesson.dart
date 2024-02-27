import 'package:etm_crm/app/domain/models/services.dart';
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
  String? lessonStart;
  String? startLesson;
  String? start;
  String? end;
  List<ServicesModel?>? services;
  SchoolClass? schoolClass;
  List<ListDay>? day;
  bool? isVisitsExists;
  ZoomMeeting? zoomMeeting;

  Lesson({
    required this.id,
    this.lessonStart,
    this.startLesson,
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
  String? startUrl;
  String? joinUrl;

  ZoomMeeting({
    this.startUrl,
    this.joinUrl,
  });

  Map<String, dynamic> toJson() => _$ZoomMeetingToJson(this);

  factory ZoomMeeting.fromJson(Map<String, dynamic> json) => _$ZoomMeetingFromJson(json);
}