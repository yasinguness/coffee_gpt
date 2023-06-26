import 'package:flutter/cupertino.dart';

import '../../network/models/order_product/order_product.dart';

class BasketProvider extends ChangeNotifier {
  final List<OrderProductModel> _products = [];
  List<OrderProductModel>? get basketProducts => _products;

  final List<int> _quantity = [];
  List<int>? get quantity => _quantity;

  double totalPrice = 0;
  int basketCounter = 0;

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
      basketCounter--;
    }
    notifyListeners();
  }

  int findProductIndex(OrderProductModel orderProduct) {
    for (int i = 0; i < _products.length; i++) {
      if (_products[i].product == orderProduct.product && _products[i].selectedSize == orderProduct.selectedSize) {
        return i;
      }
    }
    return -1;
  }

  double calculateTotalPrice() {
    for (var i = 0; i < _products.length; i++) {
      int amount = _products[i].amount ?? 0;
      double currentPrice = _products[i].currentPrice ?? 0;
      totalPrice += amount * currentPrice;
    }

    return totalPrice;
  }
}
