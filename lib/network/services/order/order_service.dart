import 'dart:io';

import '../../../common/constants/service_const.dart';
import '../../../common/service/base_service.dart';
import '../../models/order/order.dart';

class OrderService extends BaseService {
  Future<List<OrderModel>?> fetchOrders() async {
    final response = await dio.get('$BASE_URL/order/get-order');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => OrderModel.fromJson(e)).toList();
      }
    }
    return null;
  }

  Future<bool?> postOrder(OrderModel model) async {
    final postOrders = {
      "customer": model.customer!.id,
      "products": model.products!
          .map((product) => {
                "product": product.product!.id,
                "amount": product.amount,
                "selectedSize": product.selectedSize,
                "currentPrice": product.currentPrice
              })
          .toList(),
    };
    try {
      final response = await dio.post(
        '$BASE_URL/order/create',
        data: postOrders, /*  options: Options(headers: {'Content-Type': 'application/json'}) */
      );
      if (response.statusCode == HttpStatus.created) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return null;
  }

  Future<OrderModel?> getOrderById(String id) async {
    try {
      final response = await dio.get("$BASE_URL/order/$id");
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['data'][0];

        return OrderModel.fromJson(data);
      }
    } catch (e) {
      print("Servis hata");
    }
    return null;
  }
}
