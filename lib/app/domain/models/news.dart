import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class NewsList {
  List<News>? data;

  NewsList({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$NewsListToJson(this);

  factory NewsList.fromJson(Map<String, dynamic> json) => _$NewsListFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class News {
  int? id;
  String? title;
  int? schoolId;
  String? content;
  String? image;
  String? publishedAt;

  News({
    this.id,
    this.title,
    this.schoolId,
    this.content,
    this.image,
    this.publishedAt,
  });

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}