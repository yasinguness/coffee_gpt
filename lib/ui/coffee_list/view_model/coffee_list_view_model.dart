import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeListViewModel extends BaseModel {
  final ProductServices? coffeeServices;

  CoffeListViewModel({this.coffeeServices});
  int? index = 0;

  List<ProductModel>? coffees;
  Future fetchCoffees() async {
    setBusy(true);
    coffees = await coffeeServices!.getCoffee();
    setBusy(false);
  }
}
