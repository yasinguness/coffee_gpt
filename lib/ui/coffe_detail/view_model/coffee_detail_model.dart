import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeeDetailViewModel extends BaseModel {
  ProductServices? coffeeServices;
  CoffeeDetailViewModel({
    this.coffeeServices,
  });

  var counter = 1;

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

  double getCoffeePrice(ProductModel coffee, String size) {
    setBusy(true);
    coffee.size = size;
    if (coffee.size == 'S') {
      setBusy(false);

      return coffee.smallPrice!;
    } else if (coffee.size == 'L') {
      setBusy(false);

      return coffee.largePrice!;
    } else {
      setBusy(false);

      return coffee.price!;
    }
  }
}
