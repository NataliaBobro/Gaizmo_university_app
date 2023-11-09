// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataWithToken _$UserDataWithTokenFromJson(Map<String, dynamic> json) =>
    UserDataWithToken(
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserDataWithTokenToJson(UserDataWithToken instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as int,
      type: json['type'] as int,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as int?,
      dateBirth: json['date_birth'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'surname': instance.surname,
      'gender': instance.gender,
      'date_birth': instance.dateBirth,
      'phone': instance.phone,
      'email': instance.email,
    };
