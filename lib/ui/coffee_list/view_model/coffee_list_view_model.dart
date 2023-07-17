import 'package:coffe_app/network/models/response_model/response_model.dart';

import '../../../network/models/product/product.dart';
import '../../base/base_model.dart';
import '../repository/coffee_list_repository.dart';

class CoffeListViewModel extends BaseModel {
  final CoffeeListRepository _repo = CoffeeListRepository();

  CoffeListViewModel();

  int _index = 0;
  int? get index => _index;

  set index(int? ind) {
    _index = ind!;
  }

  List<ProductModel>? coffees;

  Future fetchCoffees() async {
    setBusy(true);
    final ApiResponse response = await _repo.fetchCoffees();

    if (response.data == null) {
      coffees = [];
    } else if (response.statusCode == 200) {
      coffees = response.data;
    }

    setBusy(false);
  }
}
