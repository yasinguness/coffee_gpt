import 'dart:async';

import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/services/coffee/coffee_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeeDetailViewModel extends BaseModel {
  final CoffeeServices? coffeeServices;
  CoffeeDetailViewModel({
    this.coffeeServices,
  });
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

  Future getCoffee(String id, String sizeCoffe) async {
    coffee = await coffeeServices!.getCoffeeId(id);
    price = getCoffeePrice(sizeCoffe); //Seçilen boyuta göre olan kahve fiyatını price değişkenine atıyor.
    // Ben de bu price değerini CheckoutView(ödeme sayfası gibi) de kullanmam lazım. Daha sonra bu değeri
    // OrderModel'deki coffeePrice değerinde kullanıcam ama o sonraki iş.Şuan bu değeri Checkoutta göstermem lazım.
    setBusy(false); // notifyListeners
  }
}
/* double getCoffeePrice(String size) {
    if (size == 'S') {
      return coffee!.smallPrice!;
    } else if (size == 'L') {
      return coffee!.largePrice!;
    } else {
      return coffee!.mediumPrice!;
    }
  } */
