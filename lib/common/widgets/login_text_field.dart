import 'package:flutter/material.dart';

import '../../ui/login/view_model/login_view_model.dart';
import '../constants/coffee_colors.dart';
import '../constants/coffee_padding.dart';

class LoginTextField extends StatelessWidget {
  final LoginViewModel model;
  final String hintText;
  final TextStyle? labelStyle;
  const LoginTextField({
    super.key,
    required this.model,
    required this.hintText,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CoffeePading.instance.medium,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(CoffeePading.instance.highValue)),
            color: CoffeeColors.white,
            boxShadow: const [
              BoxShadow(blurRadius: 10),
            ]),
        child: TextField(
            controller: model.controller,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hintText,
                labelStyle: labelStyle)),
      ),
    );
  }
}
