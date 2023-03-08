import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/services/api.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeListViewModel extends BaseModel {
  final Api? api;
  CoffeListViewModel({this.api});
  int? index = 0;

  List<Coffee>? coffees;
  Future fetchCoffees() async {
    setBusy(true);
    coffees = await api!.getCoffeeList();
    setBusy(false);
  }
}
