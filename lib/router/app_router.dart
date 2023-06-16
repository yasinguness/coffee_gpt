import 'package:auto_route/auto_route.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/ui/checkout/view/checkout_view.dart';
import 'package:coffe_app/ui/coffe_detail/view/coffee_detail_view.dart';
import 'package:coffe_app/ui/coffeeGpt/view/chat_screen.dart';
import 'package:coffe_app/ui/coffee_list/view/coffe_list_view.dart';
import 'package:coffe_app/ui/home/view/entry_view.dart';
import 'package:coffe_app/ui/home/view/home_view.dart';
import 'package:coffe_app/ui/login/view/login_view.dart';
import 'package:coffe_app/ui/splash/view/splash_view.dart';
import 'package:coffe_app/ui/treats/view/sweet_treats.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: EntryRoute.page),
        AutoRoute(page: ChatScreenRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CoffeeListRoute.page),
        AutoRoute(page: CoffeeDetailRoute.page),
        AutoRoute(page: SweetTreatsRoute.page),
        AutoRoute(page: CheckoutRoute.page),
      ];
}
