import 'dart:async';

import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/services/api.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeeOrderServices extends BaseModel {
  final Api? api;

  CoffeeOrderServices({this.api});

  Coffee? coffee;

  Future getCoffee(String id) async {
    setBusy(true);
    coffee = await api!.getCoffeeId(id);

    setBusy(false);
  }
}
