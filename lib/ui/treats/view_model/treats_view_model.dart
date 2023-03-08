import 'dart:async';

import 'package:coffe_app/network/models/treat.dart';
import 'package:coffe_app/network/services/api.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class TreatsViewModel extends BaseModel {
  final Api? api;

  TreatsViewModel({this.api});
  int? index = 0;
  final StreamController<int> _streamIndex = StreamController<int>();
  Stream<int> get streamInd => _streamIndex.stream;

  List<Treat>? treats;

  Future fetchTreats() async {
    setBusy(true);
    treats = await api!.getTreatList();
    setBusy(false);
  }
}
