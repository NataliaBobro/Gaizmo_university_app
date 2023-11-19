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

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) =>
    ServicesModel(
      id: json['id'] as int,
      branchId: json['branch_id'] as int?,
      serviceCategory: json['service_category'] as int?,
      teacher: json['teacher'] == null
          ? null
          : UserData.fromJson(json['teacher'] as Map<String, dynamic>),
      validity: json['validity'] as int?,
      validityType: json['validity_type'] as String?,
      duration: json['duration'] as int?,
      numberVisits: json['number_visits'] as String?,
      cost: json['cost'] as int?,
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      etm: json['etm'] as String?,
      name: json['name'] as String,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'service_category': instance.serviceCategory,
      'teacher': instance.teacher,
      'validity': instance.validity,
      'validity_type': instance.validityType,
      'duration': instance.duration,
      'cost': instance.cost,
      'name': instance.name,
      'number_visits': instance.numberVisits,
      'color': instance.color,
      'etm': instance.etm,
      'currency': instance.currency,
    };
