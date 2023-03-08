import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:flutter/material.dart';
part "../themes/text_theme.dart";

const String FONT_FAM = "Montserrat";

final ThemeData coffeeTheme = ThemeData(
  fontFamily: FONT_FAM,
  textTheme: _TextTheme.textTheme,
);
