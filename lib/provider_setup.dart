import 'package:coffe_app/network/services/chat_gpt/chat_gpt_service.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...independentServices, ...dependentServices, ...uiConsumableProviders];
List<SingleChildWidget> independentServices = [
  Provider<ProductServices>(
    create: (context) => ProductServices(),
  ),
  Provider<OrderService>(
    create: (context) => OrderService(),
  ),
  Provider<ChatGptServices>(
    create: (context) => ChatGptServices(),
  ),

  /* ListenableProvider<CheckoutViewModel>(
    create: (context) => CheckoutViewModel(coffee: Coffee()),
  ), */
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
