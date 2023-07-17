import 'dart:async';

import 'package:coffe_app/network/models/response_model/response_model.dart';

import '../../../common/provider/basket_provider.dart';
import '../../../network/models/order_product/order_product.dart';
import '../../../network/models/product/product.dart';
import '../../base/base_model.dart';
import '../repository/treat_repository.dart';

class TreatsViewModel extends BaseModel {
  final TreatRepository _repo = TreatRepository();
  late final BasketProvider? basketProvider;

  late OrderProductModel sweet;
  TreatsViewModel({required this.sweet, this.basketProvider});
  int? index = 0;

  List<ProductModel>? treats;

  Future fetchTreats() async {
    setBusy(true);
    final ApiResponse response = await _repo.fetchTreat();
    if (response.data == null) {
      treats = [];
    } else if (response.statusCode == 200) {
      treats = response.data;
    }
    setBusy(false);
  }

  void addToBasket() {
    basketProvider?.addProductToBasket(sweet, 1);
  }
}
