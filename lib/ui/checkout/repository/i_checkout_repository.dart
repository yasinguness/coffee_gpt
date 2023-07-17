import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/models/response_model/response_model.dart';

abstract class ICheckoutRepository {
  Future<ApiResponse> postOrder(OrderModel model);
}
