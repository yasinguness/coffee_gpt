import 'package:coffe_app/network/models/product/product.dart';
import 'package:flutter/cupertino.dart';

class CoffeeProvider extends ChangeNotifier {
  ProductModel? coffee;
  CoffeeProvider({this.coffee});

  void selectedSize(ProductModel model, String size) {
    model.size = size;
    notifyListeners();
  }

  double getCoffeePrice(ProductModel coffee) {
    if (coffee.size == 'S') {
      return coffee.smallPrice!;
    } else if (coffee.size == 'M') {
      return coffee.price!;
    } else if (coffee.size == 'L') {
      return coffee.largePrice!;
    } else {
      return 0;
    }
  }

  void incrementCounter(ProductModel product) {
    product.quantitiy = product.quantitiy! + 1;
    notifyListeners();
  }

  void decrementCounter(ProductModel product) {
    if (product.quantitiy! < 1) {
      product.quantitiy = 1;
    }
    product.quantitiy = product.quantitiy! - 1;
    notifyListeners();
  }
}
