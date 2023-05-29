import 'dart:async';

import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/common/provider/customer_provider.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CheckoutViewModel extends BaseModel {
  OrderService? orderServices;
  CheckoutViewModel({
    this.orderServices,
    this.coffeeProvider,
    this.basketProvider,
    this.customerProvider,
  });

  CoffeeProvider? coffeeProvider;
  BasketProvider? basketProvider;
  CustomerProvider? customerProvider;

  Future postOrder(List<String?> products, String customerId) async {
    setBusy(true);
    bool? isSuccess = await orderServices!.postOrder(products, customerId, basketProvider!.totalPrice);
    print(isSuccess);
    if (isSuccess!) {
      basketProvider!.basketProducts!.clear();
      basketProvider!.basketCounter = 0;
    }
    setBusy(false);

    return isSuccess;
  }
}
