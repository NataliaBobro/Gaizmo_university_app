import 'dart:io';
import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/utils/get_token.dart';
import '../../data/api_client.dart';
import '../models/meta.dart';
import '../models/shop.dart';

class ShopService {
  static Future<ListProducts?> fetchListProduct(
      context,
      int? schoolId,
      {bool isPayedUser = false}) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/shop/products/list',
      queryParameters: {
        'school_id': schoolId,
        'is_payed_user': isPayedUser,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListProducts.fromJson(data);
  }

  static Future<ListUserData?> fetchMeta(
      context
     ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/shop/meta',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListUserData.fromJson(data);
  }

  static Future<ListProducts?> fetchListOrders(
      context,
      {int? userId = 0, int? schoolId = 0}
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/shop/products/orders',
      queryParameters: {
        'user_id': userId,
        'school_id': schoolId,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return ListProducts.fromJson(data);
  }

  static Future<bool?> updateOrderStatus(
      context,
      orderId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/shop/products/orders/update-delivery-status',
      data: {
        'order_id': orderId,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<Map<String, dynamic>?> addOrEditProduct(
      context,
      int? productId,
      String? name,
      String? desc,
      String? priceEtm,
      String? priceMoney,
      String? imageUrl,
      File? image,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final formData = FormData();
    formData.fields.addAll(
      [
        MapEntry('name', name ?? ''),
        MapEntry('desc', desc ?? ''),
        MapEntry('price_etm', priceEtm ?? ''),
        MapEntry('price_money', priceMoney ?? ''),
        MapEntry('image_url', imageUrl ?? ''),
      ]
    );

    if(productId != null){
      formData.fields.add(MapEntry('product_id', '$productId'));
    }

    if(image != null){
      formData.files.add(
          MapEntry('image',  await MultipartFile.fromFile(image.path))
      );
    }
    final response = await ApiClient().dio.post(
      '/shop/products/add-or-edit',
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data;
  }

  static Future<Map<String, dynamic>?> deleteProduct(
      context,
      int? productId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.delete(
      '/shop/products/delete',
      data: {
        'product_id': productId
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data;
  }


  static Future<Map<String, dynamic>?> payProduct(
      context,
      int? productId
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/shop/products/$productId/fetch-payment-link',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data;
  }

  static Future<CredWithProductOrder?> fetchLiqPayCred(
      context,
      productId,
      OrdersProduct ordersProduct
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/shop/products/$productId/fetch-school-cred',
      data: {
        "last_name": ordersProduct.clientLastName,
        "name": ordersProduct.clientName,
        "email": ordersProduct.clientEmail,
        "phone": ordersProduct.clientPhone,
        "delivery_city": ordersProduct.deliveryCity,
        "delivery_location": ordersProduct.deliveryLocation,
        "comment": ordersProduct.comment,
        "payment_type": ordersProduct.paymentType,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return CredWithProductOrder.fromJson(data);
  }

  static Future<bool?> payProductEtm(
      context,
      int? productId,
      OrdersProduct ordersProduct
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.post(
      '/shop/products/$productId/pay-etm',
      data: {
        "last_name": ordersProduct.clientLastName,
        "name": ordersProduct.clientName,
        "email": ordersProduct.clientEmail,
        "phone": ordersProduct.clientPhone,
        "delivery_city": ordersProduct.deliveryCity,
        "delivery_location": ordersProduct.deliveryLocation,
        "comment": ordersProduct.comment,
        "payment_type": ordersProduct.paymentType,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data['success'];
  }

  static Future<Map<String, dynamic>?> fetchPayStatus(
      context,
      productId,
      orderReference,
      ) async {
    final token = getToken(context);
    if(token == null) return null;
    final response = await ApiClient().dio.get(
      '/shop/products/$productId/fetch-payment-status/$orderReference',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    final data = response.data as Map<String, dynamic>;
    return data;
  }
}
