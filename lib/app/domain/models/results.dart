import 'package:european_university_app/app/domain/models/services.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'results.g.dart';


@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ResultsModel {
  bool success;
  List<ResultItem> results;

  ResultsModel({
    required this.success,
    required this.results,
  });

  Map<String, dynamic> toJson() => _$ResultsModelToJson(this);

  factory ResultsModel.fromJson(Map<String, dynamic> json) => _$ResultsModelFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ResultItem {
  int? id;
  String? image;
  String? createdAt;
  UserData? user;
  ServicesModel? service;

  ResultItem({
    this.id,
    this.image,
    this.createdAt,
    this.user,
    this.service
  });

  Map<String, dynamic> toJson() => _$ResultItemToJson(this);

  factory ResultItem.fromJson(Map<String, dynamic> json) => _$ResultItemFromJson(json);
}

