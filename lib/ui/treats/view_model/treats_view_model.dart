import 'dart:async';

import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class TreatsViewModel extends BaseModel {
  final ProductServices? productServices;

  TreatsViewModel({this.productServices});
  int? index = 0;

  List<ProductModel>? treats;

  Future fetchTreats() async {
    setBusy(true);
    //treats = await treatService!.getTreatList();
    setBusy(false);
  }
}
