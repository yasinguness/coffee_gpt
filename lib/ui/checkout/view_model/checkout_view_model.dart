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
  Order? order;

  CheckoutViewModel(
      {this.orderServices, required this.coffee, this.treat, this.order, this.listTreat, this.listCoffee});
  double? _price;

  List<Treat?>? listTreat;
  List<Coffee>? listCoffee;
  double get price => _price!;
  var counter = 1;

  void incrementCounter() {
    counter++;
    setBusy(false);
  }

  void decrementCounter() {
    counter--;
    setBusy(false);
  }

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

  void addTreat() {
    listTreat?.add(treat);
    order!.treatList = listTreat;
  }

  Future postOrder() async {
    setBusy(true);
    await orderServices!.postOrder(order!);
    setBusy(false);
  }
}
