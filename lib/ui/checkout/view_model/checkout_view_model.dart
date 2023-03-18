import 'dart:async';

import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/models/order.dart';
import 'package:coffe_app/network/models/treat.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CheckoutViewModel extends BaseModel {
  OrderService? orderServices;
  Coffee coffee;
  Treat? treat;

  //Şu yöntemle consturoctor ile CoffeDetailViewModeli alıp öyle kullanayım dedim.
  // Ancak bunda da değerler null düştü hep.

  CheckoutViewModel({this.orderServices, required this.coffee, this.treat});
  double? _price;
  double get price => _price!;

  set price(double value) {
    _price = value;
    setBusy(false);
  }

  double getCoffeePrice() {
    setBusy(true);
    if (coffee.coffeeSize == 'S') {
      price = coffee.smallPrice!;

      return price;
    } else if (coffee.coffeeSize == 'L') {
      price = coffee.largePrice!;

      return price;
    } else {
      price = coffee.mediumPrice!;

      return price;
    }
  }

  Future postOrder(Order order) async {
    setBusy(true);
    order.totalCoffeePrice = price;
    order.totalTreatPrice = treat!.price;
    order.image = order.image;
    orderServices!.postOrder(order);
    setBusy(false);
  }
}
