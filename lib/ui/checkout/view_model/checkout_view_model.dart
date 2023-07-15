import 'dart:async';

import '../../../common/provider/basket_provider.dart';
import '../../../common/provider/coffe_provider.dart';
import '../../../common/provider/customer_provider.dart';
import '../../../network/models/order/order.dart';
import '../../../network/services/order/order_service.dart';
import '../../base/base_model.dart';

class CheckoutViewModel extends BaseViewModel {
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
