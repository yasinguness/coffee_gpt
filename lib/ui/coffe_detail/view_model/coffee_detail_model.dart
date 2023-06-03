import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/network/models/order_product/order_product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeeDetailViewModel extends BaseModel {
  ProductServices? coffeeServices;
  BasketProvider? basketProvider;
  CoffeeProvider? coffeeProvider;
  OrderProductModel? orderProductModel;
  CoffeeDetailViewModel({this.orderProductModel, this.coffeeServices, this.basketProvider, this.coffeeProvider});

  void incrementCounter() {
    coffeeProvider!.incrementCounter();
  }

  void decrementCounter() {
    coffeeProvider!.decrementCounter();
  }

  void addToBasket() {
    setBusy(true);
    coffeeProvider!.orderProduct = orderProductModel;
    orderProductModel!.currentPrice = coffeeProvider!.getCoffeePrice(orderProductModel!.product!);
    basketProvider!.addProductToBasket(orderProductModel!, coffeeProvider!.productQuantity);
    //orderProductModel.selectedSize=
    /*  final index = basketProvider!.findProductIndex(orderProductModel!);

    if (index != -1) {
      basketProvider!.quantity?[index] = (basketProvider!.quantity?[index])!.toInt() + coffeeProvider!.productQuantity;
      basketProvider!.calculateTotalPrice();
    } else {
      basketProvider!.basketProducts!.add(orderProductModel!);
      basketProvider!.basketCounter++;
      basketProvider!.quantity!.add(coffeeProvider!.productQuantity);
      basketProvider!.calculateTotalPrice();

      setBusy(false);
    } */
  }
}
