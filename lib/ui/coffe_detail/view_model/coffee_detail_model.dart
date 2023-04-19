import 'dart:async';

import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/services/coffee/coffee_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';
import 'package:coffe_app/ui/checkout/view_model/checkout_view_model.dart';

class CoffeeDetailViewModel extends BaseModel {
  CoffeeServices? coffeeServices;
  List<Coffee>? listCoffee;
  CheckoutViewModel? checkoutVm;
  CoffeeDetailViewModel({this.coffeeServices, this.listCoffee, this.checkoutVm});

  Coffee? coffee;
  double? _price;

  double get price => _price!;

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
    listCoffee?.add(coffee!);
  }

  Future getCoffee(String id, String sizeCoffe) async {
    coffee = await coffeeServices!.getCoffeeId(id);
    price = getCoffeePrice(sizeCoffe);
    setBusy(false); // notifyListeners
  }
}
