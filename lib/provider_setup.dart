import 'package:coffe_app/network/services/coffee/coffee_services.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/network/services/treat/treat_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...independentServices, ...dependentServices, ...uiConsumableProviders];
List<SingleChildWidget> independentServices = [
  Provider<CoffeeServices>(
    create: (context) => CoffeeServices(),
  ),
  Provider<OrderService>(
    create: (context) => OrderService(),
  ),
  Provider<TreatService>(
    create: (context) => TreatService(),
  ),
/*   ListenableProvider<CheckoutViewModel>(
    create: (context) => CheckoutViewModel(coffee: Coffee()),
  ),
  ListenableProvider<CoffeeDetailViewModel>(
    create: (context) => CoffeeDetailViewModel(),
  ), */
];

List<SingleChildWidget> dependentServices = [
  /*  ProxyProvider2<CoffeeDetailModel, OrderService, CheckoutViewModel>(
    update: (context, value, value2, previous) => CheckoutViewModel(coffeeDetailModel: value, orderServices: value2),
  ) */
];
List<SingleChildWidget> uiConsumableProviders = [];
