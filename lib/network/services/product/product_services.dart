import 'dart:async';

import '../../../common/constants/enums/http_request_enum.dart';
import '../../../common/service/base_service.dart';
import '../../models/product/product.dart';

class ProductServices extends BaseService {
  Future fetchProducts() async {
    final response = await coreDio!
        .send<List<ProductModel>, ProductModel>("product", type: HttpTypes.GET, parseModel: ProductModel());

    return response.data;
  }

/*   Future<List<ProductModel>?> fetchProducts() async {
    final response = await dio.get('$BASE_URL/product');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    return null;
  } */

  Future getSweet() async {
    final response = await coreDio!
        .send<List<ProductModel>, ProductModel>("/product/sweets", type: HttpTypes.GET, parseModel: ProductModel());
    response.data;
  }

/*   Future<List<ProductModel>> getSweet() async {
    final response = await dio.get('$BASE_URL/product/sweets');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    return [];
  } */

  Future getCoffee() async {
    final response = await coreDio!
        .send<List<ProductModel>, ProductModel>("/product/coffees", type: HttpTypes.GET, parseModel: ProductModel());
    print(response);
    return response.data;
  }

/*   Future<List<ProductModel>?> getCoffee() async {
    final response = await dio.get('$BASE_URL/product/coffees');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    return null;
  } */

  Future addProduct(ProductModel product) async {
    final response = await coreDio!.send<ProductModel, ProductModel>("/product/create",
        type: HttpTypes.POST, parseModel: ProductModel(), data: product);
    response.data;
  }

/*   Future addProduct(ProductModel product) async {
    try {
      final response = await dio.post<dynamic>('$BASE_URL/product/create', data: product.toJson());
      if (response.data['success']) {
        var data = response.data;
        ProductModel.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }
  } */

  Future getProductById(String id) async {
    final response = await coreDio!
        .send<List<ProductModel>, ProductModel>("/product/$id", type: HttpTypes.GET, parseModel: ProductModel());
    response.data;
  }

  /*  Future<ProductModel?> getProductById(String id) async {
    try {
      final response = await dio.get('$BASE_URL/product/$id');
      if (response.statusCode == HttpStatus.ok) {
        return ProductModel.fromJson(response.data);
      }
    } catch (e) {}
    return null;
  } */
}
