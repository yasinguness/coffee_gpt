import 'dart:async';

import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/common/provider/customer_provider.dart';
import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/models/response_model/response_model.dart';
import 'package:coffe_app/ui/base/base_model.dart';
import 'package:coffe_app/ui/checkout/repository/checkout_repository.dart';

class CheckoutViewModel extends BaseModel {
  final CheckoutRepository _repo = CheckoutRepository();
  late OrderModel model;
  late final CoffeeProvider coffeeProvider;
  late final BasketProvider basketProvider;
  late final CustomerProvider customerProvider;

  bool? isSuccess;

  CheckoutViewModel({
    required this.model,
    required this.coffeeProvider,
    required this.basketProvider,
    required this.customerProvider,
  });

  Future postOrder() async {
    setBusy(true);
    model.customer = customerProvider.model;
    model.products = basketProvider.basketProducts;

    final ApiResponse response = await _repo.postOrder(model);

    if (response.statusCode == 201) {
      isSuccess = true;
      basketProvider.basketProducts!.clear();
      basketProvider.basketCounter = 0;
      coffeeProvider.productQuantity = 1;
      basketProvider.quantity!.clear();
    }

    return isSuccess;
  }
}
