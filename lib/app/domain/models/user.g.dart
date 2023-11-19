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
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
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
      'school': instance.school,
    };

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: json['id'] as int,
      categorySchoolId: json['category_school_id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
      street: json['street'] as String,
      house: json['house'] as String,
      city: json['city'] as String,
    )..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>);

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'category_school_id': instance.categorySchoolId,
      'name': instance.name,
      'country': instance.country,
      'street': instance.street,
      'house': instance.house,
      'city': instance.city,
      'category': instance.category,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      define: json['define'] as String,
      translate: json['translate'] == null
          ? null
          : Translate.fromJson(json['translate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'define': instance.define,
      'translate': instance.translate,
    };
