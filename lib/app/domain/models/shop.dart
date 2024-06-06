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
  String? deliveryStatus;
  int? orderId;

  Products({
    required this.id,
    this.name,
    this.desc,
    this.priceEtm,
    this.priceMoney,
    this.image,
    this.status,
    this.deliveryStatus,
    this.orderId,
  });

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);
}

