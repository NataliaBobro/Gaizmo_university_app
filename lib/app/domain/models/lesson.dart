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
  String? start;
  String? end;
  ServicesModel? service;
  SchoolClass? schoolClass;
  List<ListDay>? day;

  Lesson({
    required this.id,
    this.lessonStart,
    this.start,
    this.end,
    this.service,
    this.schoolClass,
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