import 'package:coffe_app/common/util/coffee_colors.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<Color>? colors;
  final double? height;
  final List<double>? stops;
  final Widget? child;

  const BackgroundDecoration({
    Key? key,
    this.begin,
    this.end,
    this.colors,
    this.height,
    this.stops,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin!,
            end: end!,
            stops: stops ?? const [0.0, .5],
            colors: colors ?? [CoffeeColors.kBrownColor.withOpacity(.5), CoffeeColors.kBrownColor.withOpacity(0.0)],
          ),
        ),
        child: child);
  }
}
