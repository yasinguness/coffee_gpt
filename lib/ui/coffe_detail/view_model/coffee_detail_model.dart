import 'dart:async';

import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/services/api.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeeDetailModel extends BaseModel {
  final Api? api;

  CoffeeDetailModel({this.api});
  Coffee? coffee;
  String? sizeCoffee;
  bool? isSmall = false;
  bool? isMedium = false;

  void updateCoffeeSize(String size) {
    setBusy(true);
    sizeCoffee = size;
    if (sizeCoffee == 'S') {
      isSmall = true;
      isMedium = false;
    } else if (sizeCoffee == 'M') {
      isMedium = true;
      isSmall = false;
    } else {
      isMedium = false;
      isSmall = false;
    }
    setBusy(false);
  }

  Future getCoffee(String id) async {
    setBusy(true);
    coffee = await api!.getCoffeeId(id);
    setBusy(false);
  }
}
