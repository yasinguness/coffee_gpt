import 'package:auto_route/auto_route.dart';
import '../util/coffee_colors.dart';
import '../provider/basket_provider.dart';
import '../../router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;
  final double? elevation;
  final Color? backgroundColor;
  final double? height;
  const CustomAppBar(
      {super.key, this.actions, this.leading, this.elevation, this.backgroundColor, this.height = 60, this.title});

  @override
  Widget build(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context);
    return AppBar(
      title: title,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation ?? 0,
      leading: leading ?? _backButton(context),
      actions: actions ?? [_badge(basket, context)],
    );
  }

  Padding _badge(BasketProvider basket, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Badge(
        textStyle: const TextStyle(
          color: CoffeeColors.kBrownColor,
        ),
        alignment: Alignment.topRight,
        label: Text(
          basket.basketCounter.toString(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        child: _basketButton(context),
      ),
    );
  }

  IconButton _backButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: const Icon(
          FeatherIcons.chevronLeft,
          color: CoffeeColors.black,
          size: 30,
        ));
  }

  IconButton _basketButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.router.push(const CheckoutRoute());
        },
        icon: const Icon(
          FeatherIcons.shoppingCart,
          color: CoffeeColors.black,
          size: 25,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
