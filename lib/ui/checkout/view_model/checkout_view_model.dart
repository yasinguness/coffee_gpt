import 'package:coffe_app/network/models/order.dart';
import 'package:coffe_app/network/services/api.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CheckoutViewModel extends BaseModel {
  Api? api;
  CheckoutViewModel({this.api});
  Order? orrder;
  Future postOrder(Order order) async {
    setBusy(true);
    orrder = order;
    api!.postOrder(orrder!);
    setBusy(false);
  }
}
