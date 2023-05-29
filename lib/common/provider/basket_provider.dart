import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:flutter/cupertino.dart';

class BasketProvider extends ChangeNotifier {
  OrderModel? model;
  final List<ProductModel> _products = [];

  List<ProductModel>? get basketProducts => _products;

  int basketCounter = 0;
  double totalPrice = 0;
//TODO: Total price işlemleri yapılacak

  void addProductToBasket(ProductModel coffee, {double? price}) {
    if (coffee.isSweet == "sweet") {
      _products.add(coffee);
      basketCounter++;
      notifyListeners();
    } else {
      _products.add(coffee.copyWith(price: price));
      basketCounter++;
      //totalPrice += (price! * coffee.quantitiy!);
      calculalteTotalOrder();
      notifyListeners();
    }
  }

  void increaseQuantity(int index) {
    _products[index].quantitiy = _products[index].quantitiy! + 1;
    calculalteTotalOrder();
    notifyListeners();
  }

  updateQuantityTriggerPrice(int index) {
    double newPrice = (_products[index].quantitiy)!.toDouble() * (_products[index].price)!.toDouble();
    totalPrice += newPrice - ((_products[index].price)!.toDouble() * _products[index].quantitiy!);
    _products[index].copyWith(price: newPrice);
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_products[index].quantitiy! > 1) {
      _products[index].quantitiy = _products[index].quantitiy! - 1;
      calculalteTotalOrder();
    } else {
      totalPrice -= _products[index].price!;

      _products.removeAt(index);
      basketCounter--;
    }
    notifyListeners();
  }

  calculalteTotalOrder() {
    for (var i = 0; i < _products.length; i++) {
      totalPrice = _products[i].quantitiy!.toDouble() * _products[i].price!.toDouble();
    }
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
