import 'dart:async';
import 'dart:io';

import 'package:coffe_app/common/constants/service_const.dart';
import 'package:coffe_app/common/service/base_service.dart';
import 'package:coffe_app/network/models/product/product.dart';

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

  Future addProduct(ProductModel product) async {
/*     final productData = {
      'name': product.name,
      'price': product.price,
      'description': product.description,
      'size': product.size
    }; */
    try {
      final response = await dio.post<dynamic>('$BASE_URL/product/create', data: product.toJson());
      if (response.data['success']) {
        var data = response.data;
        ProductModel.fromJson(data);
      }
    } catch (e) {
      print("ürün eklenemedi");
      rethrow;
    }
  }
}

  /*  Future<List<Coffee>> getCoffeeList() async {
    var lists = <Coffee>[];
    final response = await htt.get(Uri.parse("$BASE_URL/"));
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body) as List<dynamic>;
      for (var parse in parsed) {
        lists.add(Coffee.fromJson(parse));
      }
      return lists;
    } else {
      throw Exception("Hata oluştu");
    }
  }

  Future<Coffee> getCoffeeId(String coffeId) async {
    var response = await htt.get(Uri.parse("$BASE_URL/$coffeId"));
    var parsed = Coffee.fromJson(jsonDecode(response.body));
    return parsed;
  } */

