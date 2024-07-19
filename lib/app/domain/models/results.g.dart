// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultsModel _$ResultsModelFromJson(Map<String, dynamic> json) => ResultsModel(
      success: json['success'] as bool,
      results: (json['results'] as List<dynamic>)
          .map((e) => ResultItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultsModelToJson(ResultsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'results': instance.results,
    };

ResultItem _$ResultItemFromJson(Map<String, dynamic> json) => ResultItem(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : ServicesModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultItemToJson(ResultItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'created_at': instance.createdAt,
      'user': instance.user,
      'service': instance.service,
    };
