import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'common/provider/basket_provider.dart';
import 'common/provider/coffe_provider.dart';
import 'common/provider/customer_provider.dart';
import 'common/themes/coffe_theme.dart';
import 'locator.dart';
import 'router/app_router.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  await dotenv.load(fileName: "lib/.env");
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
      ],
      child: MaterialApp.router(
        title: 'Coffee GPT',
        routerConfig: _appRouter.config(),
        theme: coffeeTheme,
      ),
    );
  }
}
