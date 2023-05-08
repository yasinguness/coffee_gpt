import 'dart:async';

import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/models/order.dart';
import 'package:coffe_app/network/services/coffee/coffee_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';
import 'package:coffe_app/ui/checkout/view_model/checkout_view_model.dart';

class CoffeeDetailViewModel extends BaseModel {
  CoffeeServices? coffeeServices;
  //List<Order>? orderList;
  Order? order;
  CheckoutViewModel? checkoutVm;
  CoffeeDetailViewModel({this.coffeeServices, this.order, this.checkoutVm});

  var counter = 1;
  Coffee? coffee;
  double? _price;

  double get price => _price!;

  void incrementCounter() {
    counter++;
    setBusy(false);
  }

  void decrementCounter() {
    if (counter < 1) {
      counter = 1;
    }
    counter--;
    setBusy(false);
  }

  set price(double value) {
    _price = value;
    setBusy(false);
  }

  double getCoffeePrice(String size) {
    setBusy(true);
    coffee!.coffeeSize = size;
    if (coffee!.coffeeSize == 'S') {
      return coffee!.smallPrice!;
    } else if (coffee!.coffeeSize == 'L') {
      return coffee!.largePrice!;
    } else {
      return coffee!.mediumPrice!;
    }
  }

  void addList() {
    order?.coffeeList?.add(coffee!);
  }

  Future getCoffee(String id, String sizeCoffe) async {
    coffee = await coffeeServices!.getCoffeeId(id);
    price = getCoffeePrice(sizeCoffe);
    setBusy(false); // notifyListeners
  }
}
