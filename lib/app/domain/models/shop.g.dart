// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProducts _$ListProductsFromJson(Map<String, dynamic> json) => ListProducts(
      data: (json['data'] as List<dynamic>)
          .map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListProductsToJson(ListProducts instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      priceEtm: (json['price_etm'] as num?)?.toInt(),
      priceMoney: (json['price_money'] as num?)?.toInt(),
      image: json['image'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      deliveryStatus: json['delivery_status'] as String?,
      orderId: (json['order_id'] as num?)?.toInt(),
      paymentType: json['payment_type'] as String?,
      clientName: json['client_name'] as String?,
      clientLastName: json['client_last_name'] as String?,
      clientEmail: json['client_email'] as String?,
      clientPhone: json['client_phone'] as String?,
      deliveryCity: json['delivery_city'] as String?,
      deliveryLocation: json['delivery_location'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'price_etm': instance.priceEtm,
      'price_money': instance.priceMoney,
      'image': instance.image,
      'status': instance.status,
      'created_at': instance.createdAt,
      'user': instance.user,
      'delivery_status': instance.deliveryStatus,
      'payment_type': instance.paymentType,
      'client_name': instance.clientName,
      'client_last_name': instance.clientLastName,
      'client_email': instance.clientEmail,
      'client_phone': instance.clientPhone,
      'delivery_city': instance.deliveryCity,
      'delivery_location': instance.deliveryLocation,
      'comment': instance.comment,
      'order_id': instance.orderId,
    };

OrdersProduct _$OrdersProductFromJson(Map<String, dynamic> json) =>
    OrdersProduct(
      id: (json['id'] as num?)?.toInt(),
      clientName: json['client_name'] as String?,
      clientLastName: json['client_last_name'] as String?,
      clientPhone: json['client_phone'] as String?,
      clientEmail: json['client_email'] as String?,
      deliveryCity: json['delivery_city'] as String?,
      deliveryLocation: json['delivery_location'] as String?,
      paymentType: json['payment_type'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$OrdersProductToJson(OrdersProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_name': instance.clientName,
      'client_last_name': instance.clientLastName,
      'client_phone': instance.clientPhone,
      'client_email': instance.clientEmail,
      'delivery_city': instance.deliveryCity,
      'delivery_location': instance.deliveryLocation,
      'payment_type': instance.paymentType,
      'comment': instance.comment,
    };
