import 'dart:async';

import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/network/models/order_product/order_product.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class TreatsViewModel extends BaseModel {
  final ProductServices? productServices;
  BasketProvider? basketProvider;
  OrderProductModel? sweet;
  TreatsViewModel({this.sweet, this.productServices, this.basketProvider});
  int? index = 0;

  List<ProductModel>? treats;

  Future fetchTreats() async {
    setBusy(true);
    treats = await productServices!.getSweet();
    setBusy(false);
  }

  void addToBasket() {
    basketProvider?.addProductToBasket(sweet!, 1);
  }
}
