import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.actions, this.leading, this.elevation, this.backgroundColor, this.height = 60});
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  final Color? backgroundColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
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
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FeatherIcons.shoppingBag,
                  color: CoffeeColors.black,
                  size: 30,
                ))
          ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height!);
}
