import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ServicesData {
  List<ServicesCategory>? category;
  List<ServicesModel?>? allService;

  ServicesData({
    required this.category,
    required this.allService,
  });

  Map<String, dynamic> toJson() => _$ServicesDataToJson(this);

  factory ServicesData.fromJson(Map<String, dynamic> json) => _$ServicesDataFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ServicesCategory {
  int id;
  String name;
  String? color;
  List<ServicesModel?>? services;

  ServicesCategory({
    required this.id,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toJson() => _$ServicesCategoryToJson(this);

  factory ServicesCategory.fromJson(Map<String, dynamic> json) => _$ServicesCategoryFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ServicesModel {
  int id;
  int? branchId;
  int? serviceCategory;
  UserData? teacher;
  int? validity;
  String? validityType;
  int? duration;
  int? cost;
  String name;
  String? numberVisits;
  String? color;
  String? etm;
  Currency? currency;

  ServicesModel({
    required this.id,
    this.branchId,
    this.serviceCategory,
    this.teacher,
    this.validity,
    this.validityType,
    this.duration,
    this.numberVisits,
    this.cost,
    this.currency,
    this.etm,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toJson() => _$ServicesModelToJson(this);

  factory ServicesModel.fromJson(Map<String, dynamic> json) => _$ServicesModelFromJson(json);
}


