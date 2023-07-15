import '../../../network/models/product/product.dart';
import '../../../network/services/product/product_services.dart';
import '../../base/base_model.dart';

class CoffeListViewModel extends BaseViewModel {
  final ProductServices? coffeeServices;

  CoffeListViewModel({this.coffeeServices});

  int _index = 0;
  int? get index => _index;

  set index(int? ind) {
    _index = ind!;
  }

  List<ProductModel>? coffees;

  Future fetchCoffees() async {
    setBusy(true);
    coffees = await coffeeServices!.getCoffee();
    setBusy(false);
  }
}
