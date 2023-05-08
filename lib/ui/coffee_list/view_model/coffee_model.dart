import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/services/coffee/coffee_services.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeListViewModel extends ServiceModel {
  final CoffeeServices? coffeeServices;
  CoffeListViewModel({this.coffeeServices});
  int? index = 0;

  List<Coffee>? coffees;
  Future fetchCoffees() async {
    setBusy(true);
    coffees = await coffeeServices!.getCoffeeList();
    setBusy(false);
  }
}
