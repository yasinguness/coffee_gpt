import 'package:flutter/material.dart';

import '../util/coffee_colors.dart';

class IntroText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  const IntroText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(fontSize: fontSize, fontWeight: fontWeight, color: CoffeeColors.black));
  }
}
