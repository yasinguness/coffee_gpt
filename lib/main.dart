import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/common/constants/themes/coffe_theme.dart';
import 'package:coffe_app/provider_setup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router.dart' as router;

void main() => runApp(const MyApp());
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Material App',
        onGenerateRoute: router.generateRoute,
        initialRoute: RouteConst.homeView,
        theme: coffeeTheme,
      ),
    );
  }
}
