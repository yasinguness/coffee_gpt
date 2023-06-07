import 'package:auto_route/auto_route.dart';
import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.actions, this.leading, this.elevation, this.backgroundColor, this.height = 60});
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  final Color? backgroundColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context);
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation ?? 0,
      leading: leading ??
          IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: const Icon(
                FeatherIcons.chevronLeft,
                color: CoffeeColors.black,
                size: 30,
              )),
      actions: actions ??
          [
            Padding(
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
                child: IconButton(
                    onPressed: () {
                      context.router.push(const CheckoutRoute());
                    },
                    icon: const Icon(
                      FeatherIcons.shoppingCart,
                      color: CoffeeColors.black,
                      size: 25,
                    )),
              ),
            )
          ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height!);
}
