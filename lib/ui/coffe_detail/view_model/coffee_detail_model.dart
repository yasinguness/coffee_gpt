import '../../../common/provider/basket_provider.dart';
import '../../../common/provider/coffe_provider.dart';
import '../../../network/models/order_product/order_product.dart';
import '../../../network/services/product/product_services.dart';
import '../../base/base_model.dart';

class CoffeeDetailViewModel extends BaseViewModel {
  ProductServices? coffeeServices;
  OrderProductModel? orderProductModel;

  BasketProvider? basketProvider;
  CoffeeProvider? coffeeProvider;

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
  }
}
