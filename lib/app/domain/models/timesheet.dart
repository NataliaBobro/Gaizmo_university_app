import 'package:european_university_app/app/domain/models/lesson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timesheet.g.dart';


@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class TimesheetModel {
  bool success;
  List<TimesheetItem> timesheet;

  TimesheetModel({
    required this.success,
    required this.timesheet,
  });

  Map<String, dynamic> toJson() => _$TimesheetModelToJson(this);

  factory TimesheetModel.fromJson(Map<String, dynamic> json) => _$TimesheetModelFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class TimesheetItem {
  int? id;
  int? userId;
  int? lessonId;
  String? serviceName;
  double? rating;
  Lesson? lesson;

  TimesheetItem({
    this.id,
    this.userId,
    this.lessonId,
    this.serviceName,
    this.rating,
    this.lesson
  });

  Map<String, dynamic> toJson() => _$TimesheetItemToJson(this);

  factory TimesheetItem.fromJson(Map<String, dynamic> json) => _$TimesheetItemFromJson(json);
}

