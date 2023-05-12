import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class SplashViewModel extends BaseModel {
  OrderService orderService = OrderService();
  List<OrderModel>? orders;

  Future getORders() async {
    setBusy(true);
    orders = await orderService.fetchOrders();
    setBusy(false);
  }
}
