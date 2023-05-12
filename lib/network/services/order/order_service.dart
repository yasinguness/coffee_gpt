import 'dart:io';

import 'package:coffe_app/common/constants/service_const.dart';
import 'package:coffe_app/common/service/base_service.dart';
import 'package:coffe_app/network/models/order/order.dart';

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

  Future postOrder(OrderModel order) async {
    try {
      final response = await dio.post<dynamic>('$BASE_URL/product/create', data: order.toJson());
      if (response.data['success']) {
        var data = response.data;
        OrderModel.fromJson(data);
      }
    } catch (e) {
      print("Sipariş verilemedi");
      rethrow;
    }
  }
}
