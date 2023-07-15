import 'package:coffe_app/common/constants/enums/http_request_enum.dart';

import '../../../common/service/base_service.dart';
import '../../models/order/order.dart';

class OrderService extends BaseService {
  Future fetchOrders() async {
    final response = await coreDio!
        .send<List<OrderModel>, OrderModel>("/order/get-order", type: HttpTypes.GET, parseModel: OrderModel());
    return response.data;
  }

/*   Future<List<OrderModel>?> fetchOrders() async {
    final response = await dio.get('$BASE_URL/order/get-order');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => OrderModel.fromJson(e)).toList();
      }
    }
    return null;
  } */

  /*  Future<bool?> postOrder(OrderModel model) async {
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
  } */

  Future postOrder(OrderModel model) async {
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
    final response = await coreDio!
        .send<bool, OrderModel>("/order/create", type: HttpTypes.POST, parseModel: OrderModel(), data: postOrders);

    if (response.data == true) {
      return true;
    } else {
      return false;
    }
  }

  Future getOrderById(String id) async {
    final response =
        await coreDio!.send<OrderModel, OrderModel>("/order/$id", type: HttpTypes.GET, parseModel: OrderModel());
    return response.data;
  }

  /*  Future<OrderModel?> getOrderById(String id) async {
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
  } */
}
