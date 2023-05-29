import 'dart:async';

import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class TreatsViewModel extends BaseModel {
  final ProductServices? productServices;
  BasketProvider? basketProvider;
  TreatsViewModel({this.productServices, this.basketProvider});
  int? index = 0;

  List<ProductModel>? treats;

  Future fetchTreats() async {
    setBusy(true);
    treats = await productServices!.getSweet();
    setBusy(false);
  }

  void addToBasket(ProductModel coffee) {
    basketProvider?.addProductToBasket(coffee);
  }
}
