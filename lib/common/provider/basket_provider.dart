import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/network/models/order_product/order_product.dart';
import 'package:flutter/cupertino.dart';

class BasketProvider extends ChangeNotifier {
  CoffeeProvider? coffeeProvider;
  final List<OrderProductModel> _products = [];

  List<OrderProductModel>? get basketProducts => _products;

  int basketCounter = 0;
  List<int>? quantity = [];
  double totalPrice = 0;

  void addProductToBasket(OrderProductModel orderProduct, int productQuant, {double? price}) {
    final index = findProductIndex(orderProduct);

    if (index != -1) {
      _products[index].amount = _products[index].amount! + productQuant;

      quantity?[index] = (quantity?[index])!.toInt() + productQuant;
    } else {
      orderProduct.amount = productQuant;

      _products.add(orderProduct);
      basketCounter++;
      quantity!.add(productQuant);

      notifyListeners();
    }
  }

  void increaseQuantity(int index) {
    quantity?[index] = quantity![index] + 1;
    _products[index].amount = quantity![index];
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (quantity![index] > 1) {
      quantity?[index] = quantity![index] - 1;
      _products[index].amount = quantity![index];
    } else {
      _products.removeAt(index);
      quantity?.removeAt(index);
    }
    notifyListeners();
  }

  int findProductIndex(OrderProductModel orderProduct) {
    for (int i = 0; i < _products.length; i++) {
      if (_products[i].product == orderProduct.product && _products[i].product!.size == orderProduct.product!.size) {
        return i;
      }
    }
    return -1;
  }

  double? calculateTotalPrice() {
    for (var i = 0; i < _products.length; i++) {
      totalPrice += (quantity?[i])!.toDouble() * (_products[i].product!.price)!.toDouble();
      return totalPrice;
    }
    return null;
  }
}
