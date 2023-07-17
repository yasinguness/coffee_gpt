import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/models/response_model/response_model.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/checkout/repository/i_checkout_repository.dart';

class CheckoutRepository extends ICheckoutRepository {
  @override
  Future<ApiResponse> postOrder(OrderModel model) async {
    ApiResponse response;
    try {
      response = await OrderService().postOrder(model);
      if (response.statusCode == 201) {
        return response;
      } else {
        return ApiResponse();
      }
    } catch (e) {
      return ApiResponse();
    }
  }
}
