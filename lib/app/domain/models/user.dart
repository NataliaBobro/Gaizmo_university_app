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
class UserData {
  int id;
  int type;
  String? firstName;
  String? lastName;
  String? surname;
  int? gender;
  String? dateBirth;
  String? phone;
  String? email;
  School? school;

  UserData({
    required this.id,
    required this.type,
    this.firstName,
    this.lastName,
    this.surname,
    required this.gender,
    this.dateBirth,
    this.phone,
    this.email,
    this.school,
  });

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class School {
  int id;
  int categorySchoolId;
  String name;
  String country;
  String street;
  String house;
  String city;
  Category? category;


  School({
    required this.id,
    required this.categorySchoolId,
    required this.name,
    required this.country,
    required this.street,
    required this.house,
    required this.city,
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

