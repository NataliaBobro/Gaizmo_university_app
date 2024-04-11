// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsList _$NewsListFromJson(Map<String, dynamic> json) => NewsList(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsListToJson(NewsList instance) => <String, dynamic>{
      'data': instance.data,
    };

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['id'] as int?,
      title: json['title'] as String?,
      schoolId: json['school_id'] as int?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      publishedAt: json['published_at'] as String?,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'school_id': instance.schoolId,
      'content': instance.content,
      'image': instance.image,
      'published_at': instance.publishedAt,
    };
