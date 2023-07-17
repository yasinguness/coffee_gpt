import 'package:flutter/material.dart';

import '../util/coffee_colors.dart';
import '../util/coffee_padding.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final TextStyle? labelStyle;
  final TextEditingController controller;
  const LoginTextField({
    super.key,
    required this.hintText,
    this.labelStyle,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CoffeePadding.instance.medium,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(CoffeePadding.instance.highValue)),
            color: CoffeeColors.white,
            boxShadow: const [
              BoxShadow(blurRadius: 10),
            ]),
        child: TextField(
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hintText,
                labelStyle: labelStyle)),
      ),
    );
  }
}
