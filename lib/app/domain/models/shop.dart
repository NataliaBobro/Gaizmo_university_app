import 'package:european_university_app/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ListProducts {
  List<Products> data;

  ListProducts({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$ListProductsToJson(this);

  factory ListProducts.fromJson(Map<String, dynamic> json) => _$ListProductsFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Products {
  int id;
  String? name;
  String? desc;
  int? priceEtm;
  int? priceMoney;
  String? image;
  String? status;
  String? createdAt;
  UserData? user;
  String? deliveryStatus;
  String? paymentType;
  String? clientName;
  String? clientLastName;
  String? clientEmail;
  String? clientPhone;
  String? deliveryCity;
  String? deliveryLocation;
  String? comment;
  int? orderId;

  Products({
    required this.id,
    this.name,
    this.desc,
    this.priceEtm,
    this.priceMoney,
    this.image,
    this.status,
    this.createdAt,
    this.user,
    this.deliveryStatus,
    this.orderId,
    this.paymentType,
    this.clientName,
    this.clientLastName,
    this.clientEmail,
    this.clientPhone,
    this.deliveryCity,
    this.deliveryLocation,
    this.comment,
  });

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class OrdersProduct {
  int? id;
  String? clientName;
  String? clientLastName;
  String? clientPhone;
  String? clientEmail;
  String? deliveryCity;
  String? deliveryLocation;
  String? paymentType;
  String? comment;

  OrdersProduct({
    this.id,
    this.clientName,
    this.clientLastName,
    this.clientPhone,
    this.clientEmail,
    this.deliveryCity,
    this.deliveryLocation,
    this.paymentType,
    this.comment
  });

  Map<String, dynamic> toJson() => _$OrdersProductToJson(this);

  factory OrdersProduct.fromJson(Map<String, dynamic> json) => _$OrdersProductFromJson(json);
}

