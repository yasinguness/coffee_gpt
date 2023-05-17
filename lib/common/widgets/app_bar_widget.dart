import 'package:badges/badges.dart';
import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/common/provider/basket_provider.dart';
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
                Navigator.pop(context, "fromHome");
              },
              icon: const Icon(
                FeatherIcons.chevronLeft,
                color: CoffeeColors.black,
                size: 30,
              )),
      actions: actions ??
          [
            Badge(
              badgeStyle: const BadgeStyle(
                badgeColor: CoffeeColors.kBrownColor,
              ),
              position: BadgePosition.topEnd(end: 3, top: 0),
              badgeContent: Text(
                basket.basketCounter.toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteConst.checkoutView);
                  },
                  icon: const Icon(
                    FeatherIcons.shoppingCart,
                    color: CoffeeColors.black,
                    size: 30,
                  )),
            )
          ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height!);
}
