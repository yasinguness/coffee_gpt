import 'package:flutter/material.dart';

import '../util/coffee_colors.dart';

part "../themes/text_theme.dart";

// ignore: constant_identifier_names
const String FONT_FAM = "Montserrat";

final ThemeData coffeeTheme = ThemeData(
  fontFamily: FONT_FAM,
  textTheme: _TextTheme.textTheme,
);
