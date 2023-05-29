import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeeDetailViewModel extends BaseModel {
  ProductServices? coffeeServices;
  BasketProvider? basketProvider;
  CoffeeProvider? coffeeProvider;
  CoffeeDetailViewModel({this.coffeeServices, this.basketProvider, this.coffeeProvider});

  void incrementCounter(ProductModel product) {
    coffeeProvider!.incrementCounter(product);
  }

  void decrementCounter(ProductModel product) {
    coffeeProvider!.decrementCounter(product);
  }

  void addToBasket(ProductModel coffee) {
    if (coffeeProvider?.selectedSize != null) {
      double price = coffeeProvider!.getCoffeePrice(coffee);
      basketProvider?.addProductToBasket(coffee, price: price);
    }
  }
}
