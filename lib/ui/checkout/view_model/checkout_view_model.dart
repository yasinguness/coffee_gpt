import 'dart:async';

import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CheckoutViewModel extends BaseModel {
  OrderService? orderServices;
  OrderModel? order;
  List<ProductModel>? productList;
  CheckoutViewModel({this.productList, this.orderServices, this.order, this.coffeeProvider, this.basketProvider});

  CoffeeProvider? coffeeProvider;
  BasketProvider? basketProvider;

  Future getOrderById(String id) async {
    setBusy(true);
    order = await orderServices!.getOrderById(id);
    setBusy(false);
  }

  Future postOrder() async {
    setBusy(true);
    await orderServices!.postOrder(order!);
    setBusy(false);
  }
}
