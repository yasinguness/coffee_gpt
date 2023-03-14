import 'dart:async';

import 'package:coffe_app/network/models/treat.dart';
import 'package:coffe_app/network/services/treat/treat_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class TreatsViewModel extends BaseModel {
  final TreatService? treatService;

  TreatsViewModel({this.treatService});
  int? index = 0;

  List<Treat>? treats;

  Future fetchTreats() async {
    setBusy(true);
    treats = await treatService!.getTreatList();
    setBusy(false);
  }
}
