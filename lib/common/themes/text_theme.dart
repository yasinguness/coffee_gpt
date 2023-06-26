part of "../themes/coffe_theme.dart";

class _TextTheme {
  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        color: CoffeeColors.kTitleColor,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        color: CoffeeColors.kTitleColor,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
      ),
      displaySmall: TextStyle(
        fontSize: 26,
        color: CoffeeColors.kTitleColor,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
      ),
      bodyMedium: TextStyle(color: CoffeeColors.white, fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
        fontSize: 16,
        color: CoffeeColors.kTitleColor,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: CoffeeColors.kTitleColor,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        color: CoffeeColors.kTitleColor,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
      ),
    );
  }
}
