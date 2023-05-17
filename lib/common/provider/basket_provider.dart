import 'package:coffe_app/network/models/product/product.dart';
import 'package:flutter/cupertino.dart';

class BasketProvider extends ChangeNotifier {
  final List<ProductModel> _products = [];
  List<ProductModel>? get basketProducts => _products;

  int basketCounter = 0;

  /* void addProducts(ProductModel model) {
    basketProducts!.add(model);
    basketCounter++;
    notifyListeners();
  } */
  double totalPrice = 0;

  void addProductToBasket(ProductModel coffee, double price) {
    _products.add(coffee.copyWith(price: price));
    basketCounter++;
    totalPrice += price;
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _products[index].quantitiy = _products[index].quantitiy! + 1;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_products[index].quantitiy! > 1) {
      _products[index].quantitiy = _products[index].quantitiy! - 1;
    } else {
      _products.removeAt(index);
      basketCounter--;
    }
    notifyListeners();
  }

/*   int get totalAmount {
    int sum = 0;
    for (var order in _products!) {
      for (var product in order. ?? []) {
        sum += _products.price ?? 0;
      }
    }
    return sum;
  } */
}
