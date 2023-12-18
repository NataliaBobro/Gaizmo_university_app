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

ListUserData _$ListUserDataFromJson(Map<String, dynamic> json) => ListUserData(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListUserDataToJson(ListUserData instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as int,
      type: json['type'] as int,
      languageId: json['language_id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as int?,
      dateBirth: json['date_birth'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      socialAccounts: json['social_accounts'] == null
          ? null
          : SocialAccounts.fromJson(
              json['social_accounts'] as Map<String, dynamic>),
    )..workDay = (json['work_day'] as List<dynamic>?)
        ?.map((e) => WorkDay.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'language_id': instance.languageId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'surname': instance.surname,
      'gender': instance.gender,
      'date_birth': instance.dateBirth,
      'phone': instance.phone,
      'email': instance.email,
      'avatar': instance.avatar,
      'school': instance.school,
      'work_day': instance.workDay,
      'social_accounts': instance.socialAccounts,
    };

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: json['id'] as int,
      categorySchoolId: json['category_school_id'] as int,
      name: json['name'] as String,
      siteName: json['site_name'] as String?,
      country: json['country'] as String,
      street: json['street'] as String,
      house: json['house'] as String,
      city: json['city'] as String,
      from: json['from'] as String?,
      to: json['to'] as String?,
    )..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>);

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'category_school_id': instance.categorySchoolId,
      'name': instance.name,
      'site_name': instance.siteName,
      'country': instance.country,
      'street': instance.street,
      'house': instance.house,
      'city': instance.city,
      'from': instance.from,
      'to': instance.to,
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

WorkDay _$WorkDayFromJson(Map<String, dynamic> json) => WorkDay(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      day: json['day'] as int,
    );

Map<String, dynamic> _$WorkDayToJson(WorkDay instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'day': instance.day,
    };

SocialAccounts _$SocialAccountsFromJson(Map<String, dynamic> json) =>
    SocialAccounts(
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      linkedin: json['linkedin'] as String?,
      twitter: json['twitter'] as String?,
    );

Map<String, dynamic> _$SocialAccountsToJson(SocialAccounts instance) =>
    <String, dynamic>{
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
    };
