import 'package:coffe_app/network/models/order_product/order_product.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:flutter/cupertino.dart';

class CoffeeProvider extends ChangeNotifier {
  OrderProductModel? orderProduct;
  CoffeeProvider({this.orderProduct});

  int productQuantity = 1;

  void incrementCounter() {
    productQuantity = productQuantity + 1;
    notifyListeners();
  }

  void decrementCounter() {
    if (productQuantity < 1) {
      productQuantity = 1;
    }
    productQuantity = productQuantity - 1;
    notifyListeners();
  }

  double getCoffeePrice(ProductModel model) {
    if (model.size == 'S') {
      return model.price! - 5;
    } else if (model.size == 'M') {
      return model.price!;
    } else if (model.size == 'L') {
      return model.price! + 5;
    } else {
      return 0;
    }
  }

  void selectedSize(ProductModel model, String size) {
    model.size = size;
    notifyListeners();
  }
}
