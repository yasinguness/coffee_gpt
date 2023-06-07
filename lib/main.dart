import 'package:coffe_app/common/constants/themes/coffe_theme.dart';
import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/common/provider/customer_provider.dart';
import 'package:coffe_app/common/provider/order_product_provider.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BasketProvider>(create: (context) => BasketProvider()),
        ChangeNotifierProvider<CoffeeProvider>(create: (context) => CoffeeProvider()),
        ChangeNotifierProvider<CustomerProvider>(create: (context) => CustomerProvider()),
        ChangeNotifierProvider<OrderProductProvider>(create: (context) => OrderProductProvider()),
      ],
      child: MaterialApp.router(
        title: 'Material App',
        routerConfig: _appRouter.config(),
        /*  onGenerateRoute: router.generateRoute,
        initialRoute: RouteConst.homeView, */
        theme: coffeeTheme,
      ),
    );
  }
}
