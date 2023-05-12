import 'package:coffe_app/network/services/chat_gpt/chat_gpt_service.dart';
import 'package:coffe_app/network/services/customer/customer_service.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerSingleton<ChatGptServices>(ChatGptServices());
  locator.registerSingleton<ProductServices>(ProductServices());
  locator.registerSingleton<OrderService>(OrderService());
  locator.registerSingleton<CustomerService>(CustomerService());
}
