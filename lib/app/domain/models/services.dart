import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ServicesData {
  List<ServicesCategory>? category;
  List<ServicesModel?>? allService;

  ServicesData({
    required this.category,
    required this.allService,
  });

  Map<String, dynamic> toJson() => _$ServicesDataToJson(this);

  factory ServicesData.fromJson(Map<String, dynamic> json) => _$ServicesDataFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ServicesCategory {
  int id;
  String name;
  String? sheetId;
  String? color;
  List<ServicesModel?>? services;

  ServicesCategory({
    required this.id,
    required this.name,
    required this.sheetId,
    required this.color,
  });

  Map<String, dynamic> toJson() => _$ServicesCategoryToJson(this);

  factory ServicesCategory.fromJson(Map<String, dynamic> json) => _$ServicesCategoryFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ListServicesModel {
  List<ServicesModel?>? services;

  ListServicesModel({
    required this.services,
  });

  Map<String, dynamic> toJson() => _$ListServicesModelToJson(this);

  factory ListServicesModel.fromJson(Map<String, dynamic> json) => _$ListServicesModelFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ServicesModel {
  int id;
  int? branchId;
  int? serviceCategory;
  int? validity;
  String? validityType;
  int? duration;
  int? cost;
  String name;
  String? desc;
  String? image;
  int? numberVisits;
  String? color;
  int? etm;
  Currency? currency;
  School? school;
  School? branch;
  int? isFavorites;
  List<Lesson>? lessons;
  List<PayUsers>? payUsers;

  ServicesModel({
    required this.id,
    this.branchId,
    this.serviceCategory,
    this.validity,
    this.validityType,
    this.duration,
    this.numberVisits,
    this.cost,
    this.currency,
    this.etm,
    this.lessons,
    this.isFavorites,
    required this.name,
    required this.color,
    this.payUsers,
    this.school,
    this.branch,
    this.desc,
    this.image
  });

  Map<String, dynamic> toJson() => _$ServicesModelToJson(this);

  factory ServicesModel.fromJson(Map<String, dynamic> json) => _$ServicesModelFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Lesson {
  int id;
  int? serviceId;
  String? classId;
  String? startLesson;
  int? duration;
  String? type;
  String? start;
  String? end;
  List<DayItem>? day;
  String? createdAt;
  String? updatedAt;

  Lesson({
    required this.id,
    this.serviceId,
    this.classId,
    this.startLesson,
    this.duration,
    this.type,
    this.start,
    this.end,
    this.day,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$LessonToJson(this);

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class DayItem {
  String name;
  String? define;

  DayItem({
    required this.name,
    required this.define,
  });

  Map<String, dynamic> toJson() => _$DayItemToJson(this);

  factory DayItem.fromJson(Map<String, dynamic> json) => _$DayItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class PayUsers {
  int id;
  UserData user;

  PayUsers({
    required this.id,
    required this.user,
  });

  Map<String, dynamic> toJson() => _$PayUsersToJson(this);

  factory PayUsers.fromJson(Map<String, dynamic> json) => _$PayUsersFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ListPayUsers {
  List<PayUsers> users;

  ListPayUsers({
    required this.users,
  });

  Map<String, dynamic> toJson() => _$ListPayUsersToJson(this);

  factory ListPayUsers.fromJson(Map<String, dynamic> json) => _$ListPayUsersFromJson(json);
}

