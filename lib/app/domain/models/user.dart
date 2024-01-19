import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class UserDataWithToken {
  UserData user;
  String token;

  UserDataWithToken({
    required this.user,
    required this.token,
  });

  Map<String, dynamic> toJson() => _$UserDataWithTokenToJson(this);

  factory UserDataWithToken.fromJson(Map<String, dynamic> json) => _$UserDataWithTokenFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ListUserData {
  List<UserData> users;

  ListUserData({
    required this.users,
  });

  Map<String, dynamic> toJson() => _$ListUserDataToJson(this);

  factory ListUserData.fromJson(Map<String, dynamic> json) =>
      _$ListUserDataFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class UserData {
  int id;
  int type;
  int? languageId;
  String? firstName;
  String? lastName;
  String? surname;
  int? gender;
  String? dateBirth;
  String? phone;
  String? email;
  String? avatar;
  School? school;
  String? country;
  String? street;
  String? house;
  String? city;
  String? about;
  List<WorkDay>? workDay;
  List<Documents>? documents;
  SocialAccounts? socialAccounts;
  int? notifications;

  UserData({
    required this.id,
    required this.type,
    this.languageId,
    this.firstName,
    this.lastName,
    this.surname,
    required this.gender,
    this.dateBirth,
    this.phone,
    this.email,
    this.avatar,
    this.school,
    this.country,
    this.street,
    this.house,
    this.city,
    this.about,
    this.socialAccounts,
    this.notifications
  });

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class School {
  int id;
  int categorySchoolId;
  String name;
  String? siteName;
  String? country;
  String? street;
  String? house;
  String? city;
  String? from;
  String? to;
  Category? category;

  School({
    required this.id,
    required this.categorySchoolId,
    required this.name,
    this.siteName,
    required this.country,
    required this.street,
    required this.house,
    required this.city,
    this.from,
    this.to,
  });

  Map<String, dynamic> toJson() => _$SchoolToJson(this);

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Category {
  int id;
  String define;
  Translate? translate;


  Category({
    required this.id,
    required this.define,
    required this.translate,
  });

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class WorkDay {
  int id;
  int userId;
  int day;


  WorkDay({
    required this.id,
    required this.userId,
    required this.day,
  });

  Map<String, dynamic> toJson() => _$WorkDayToJson(this);

  factory WorkDay.fromJson(Map<String, dynamic> json) => _$WorkDayFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class SocialAccounts {
  String? instagram;
  String? facebook;
  String? linkedin;
  String? twitter;


  SocialAccounts({
    this.instagram,
    this.facebook,
    this.linkedin,
    this.twitter,
  });

  Map<String, dynamic> toJson() => _$SocialAccountsToJson(this);

  factory SocialAccounts.fromJson(Map<String, dynamic> json) => _$SocialAccountsFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Documents {
  int? id;
  int? userId;
  int? typeId;
  String? patch;
  String? name;

  Documents({
    this.id,
    this.userId,
    this.typeId,
    this.patch,
    this.name,
  });

  Map<String, dynamic> toJson() => _$DocumentsToJson(this);

  factory Documents.fromJson(Map<String, dynamic> json) => _$DocumentsFromJson(json);
}

