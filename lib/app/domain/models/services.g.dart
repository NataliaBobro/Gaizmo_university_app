// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesData _$ServicesDataFromJson(Map<String, dynamic> json) => ServicesData(
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => ServicesCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      allService: (json['all_service'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesDataToJson(ServicesData instance) =>
    <String, dynamic>{
      'category': instance.category,
      'all_service': instance.allService,
    };

ServicesCategory _$ServicesCategoryFromJson(Map<String, dynamic> json) =>
    ServicesCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String?,
    )..services = (json['services'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : ServicesModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ServicesCategoryToJson(ServicesCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'services': instance.services,
    };

ListServicesModel _$ListServicesModelFromJson(Map<String, dynamic> json) =>
    ListServicesModel(
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListServicesModelToJson(ListServicesModel instance) =>
    <String, dynamic>{
      'services': instance.services,
    };

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) =>
    ServicesModel(
      id: json['id'] as int,
      branchId: json['branch_id'] as int?,
      serviceCategory: json['service_category'] as int?,
      validity: json['validity'] as int?,
      validityType: json['validity_type'] as String?,
      duration: json['duration'] as int?,
      numberVisits: json['number_visits'] as int?,
      cost: json['cost'] as int?,
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      etm: json['etm'] as int?,
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFavorites: json['is_favorites'] as int?,
      name: json['name'] as String,
      color: json['color'] as String?,
      payUsers: (json['pay_users'] as List<dynamic>?)
          ?.map((e) => PayUsers.fromJson(e as Map<String, dynamic>))
          .toList(),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      branch: json['branch'] == null
          ? null
          : School.fromJson(json['branch'] as Map<String, dynamic>),
      desc: json['desc'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'service_category': instance.serviceCategory,
      'validity': instance.validity,
      'validity_type': instance.validityType,
      'duration': instance.duration,
      'cost': instance.cost,
      'name': instance.name,
      'desc': instance.desc,
      'image': instance.image,
      'number_visits': instance.numberVisits,
      'color': instance.color,
      'etm': instance.etm,
      'currency': instance.currency,
      'school': instance.school,
      'branch': instance.branch,
      'is_favorites': instance.isFavorites,
      'lessons': instance.lessons,
      'pay_users': instance.payUsers,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as int,
      serviceId: json['service_id'] as int?,
      classId: json['class_id'] as int?,
      startLesson: json['start_lesson'] as String?,
      start: json['start'] as String?,
      end: json['end'] as String?,
      day: (json['day'] as List<dynamic>?)
          ?.map((e) => DayItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'service_id': instance.serviceId,
      'class_id': instance.classId,
      'start_lesson': instance.startLesson,
      'start': instance.start,
      'end': instance.end,
      'day': instance.day,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

DayItem _$DayItemFromJson(Map<String, dynamic> json) => DayItem(
      name: json['name'] as String,
      define: json['define'] as String?,
    );

Map<String, dynamic> _$DayItemToJson(DayItem instance) => <String, dynamic>{
      'name': instance.name,
      'define': instance.define,
    };

PayUsers _$PayUsersFromJson(Map<String, dynamic> json) => PayUsers(
      id: json['id'] as int,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayUsersToJson(PayUsers instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
    };

ListPayUsers _$ListPayUsersFromJson(Map<String, dynamic> json) => ListPayUsers(
      users: (json['users'] as List<dynamic>)
          .map((e) => PayUsers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListPayUsersToJson(ListPayUsers instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
