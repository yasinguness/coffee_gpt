import 'dart:async';

import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/common/provider/customer_provider.dart';
import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CheckoutViewModel extends BaseModel {
  OrderService? orderServices;
  OrderModel? model;

  CoffeeProvider? coffeeProvider;
  BasketProvider? basketProvider;
  CustomerProvider? customerProvider;

  CheckoutViewModel({
    this.model,
    this.orderServices,
    this.coffeeProvider,
    this.basketProvider,
    this.customerProvider,
  });

  Future postOrder() async {
    setBusy(true);
    model!.customer = customerProvider!.model;
    model!.products = basketProvider!.basketProducts;
    bool? isSuccess = await orderServices!.postOrder(model!);
    if (isSuccess!) {
      basketProvider!.basketProducts!.clear();
      basketProvider!.basketCounter = 0;
      coffeeProvider!.productQuantity = 1;
      basketProvider!.quantity!.clear();
    }
    setBusy(false);

    return isSuccess;
  }
}
