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
  });

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}

