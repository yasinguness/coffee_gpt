import 'dart:async';
import 'dart:io';

import '../../../common/constants/service_const.dart';
import '../../../common/service/base_service.dart';
import '../../models/product/product.dart';

class ProductServices extends BaseService {
  Future<List<ProductModel>?> fetchProducts() async {
    final response = await dio.get('$BASE_URL/product');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    return null;
  }

  Future<List<ProductModel>> getSweet() async {
    final response = await dio.get('$BASE_URL/product/sweets');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    return [];
  }

  Future<List<ProductModel>?> getCoffee() async {
    final response = await dio.get('$BASE_URL/product/coffees');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    return null;
  }

  Future addProduct(ProductModel product) async {
    try {
      final response = await dio.post<dynamic>('$BASE_URL/product/create', data: product.toJson());
      if (response.data['success']) {
        var data = response.data;
        ProductModel.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel?> getProductById(String id) async {
    try {
      final response = await dio.get('$BASE_URL/product/$id');
      if (response.statusCode == HttpStatus.ok) {
        return ProductModel.fromJson(response.data);
      }
    } catch (e) {}
    return null;
  }
}
