import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/ui/checkout/checkout_view.dart';
import 'package:coffe_app/ui/coffe_detail/view/coffee_detail_view.dart';
import 'package:coffe_app/ui/coffee_list/view/coffe_list_view.dart';
import 'package:coffe_app/ui/home/view/home_view.dart';
import 'package:coffe_app/ui/Intro/view/intro_view.dart';
import 'package:coffe_app/ui/treats/view/sweet_treats.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteConst.homeView:
      return MaterialPageRoute(
        builder: (context) => const HomeView(),
      );

    case RouteConst.loginView:
      return MaterialPageRoute(
        builder: (context) => const IntroView(),
      );

    case RouteConst.coffeeListView:
      return MaterialPageRoute(
        builder: (context) => const CoffeeListView(),
      );

    case RouteConst.coffeeDetailView:
      var arguments = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CoffeeDetailView(
                coffee: arguments as Coffee,
              ));

    case RouteConst.sweetTreatsView:
      var arguments = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => SweetTreatsWidget(coffee: arguments as Coffee),
      );

    case RouteConst.checkoutView:
      var arg = settings.arguments;
      return MaterialPageRoute(
        builder: (context) {
          final argu = arg as CheckoutView;
          return CheckoutView(treat: argu.treat, coffee: argu.coffee);
        },
      );
    default:
  }
  return null;
}
