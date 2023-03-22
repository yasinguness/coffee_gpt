import "package:flutter/material.dart";

class CoffeePading {
  CoffeePading._init();
  static CoffeePading? _instance;
  static CoffeePading get instance {
    _instance ??= CoffeePading._init();
    return _instance!;
  }

  final double lowValue = 4.0;
  final double mediumValue = 8.0;
  final double highValue = 16.0;
  final double veryHighValue = 24.0;

  EdgeInsets get lowHorizontal => EdgeInsets.symmetric(horizontal: lowValue);

  EdgeInsets get mediumHorizontal => EdgeInsets.symmetric(horizontal: mediumValue);

  EdgeInsets get highHorizontal => EdgeInsets.symmetric(horizontal: highValue);

  EdgeInsets get veryHighHorizontal => EdgeInsets.symmetric(horizontal: veryHighValue);

  EdgeInsets get lowVertical => EdgeInsets.symmetric(vertical: lowValue);

  EdgeInsets get mediumVertical => EdgeInsets.symmetric(vertical: mediumValue);

  EdgeInsets get highVertical => EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get veryHighVertical => EdgeInsets.symmetric(vertical: veryHighValue);

  EdgeInsets get low => EdgeInsets.all(lowValue);

  EdgeInsets get medium => EdgeInsets.all(mediumValue);

  EdgeInsets get high => EdgeInsets.all(highValue);

  EdgeInsets get veryHigh => EdgeInsets.all(veryHighValue);

  //Spesific
  EdgeInsets get lowHorizontalMediumVertical => EdgeInsets.symmetric(horizontal: lowValue, vertical: mediumValue);

  EdgeInsets get lowHorizontalHighVertical => EdgeInsets.symmetric(horizontal: lowValue, vertical: highValue);

  EdgeInsets get lowHorizontalVeryHighVertical => EdgeInsets.symmetric(horizontal: lowValue, vertical: veryHighValue);

  EdgeInsets get mediumHorizontalLowVertical => EdgeInsets.symmetric(horizontal: mediumValue, vertical: lowValue);

  EdgeInsets get mediumHorizontalHighVertical => EdgeInsets.symmetric(horizontal: mediumValue, vertical: highValue);

  EdgeInsets get mediumHorizontalVeryHighVertical =>
      EdgeInsets.symmetric(horizontal: mediumValue, vertical: veryHighValue);

  EdgeInsets get highHorizontalLowVertical => EdgeInsets.symmetric(horizontal: highValue, vertical: lowValue);

  EdgeInsets get highHorizontalMediumVertical => EdgeInsets.symmetric(horizontal: highValue, vertical: mediumValue);

  EdgeInsets get highHorizontalHighVertical => EdgeInsets.symmetric(horizontal: highValue, vertical: highValue);

  EdgeInsets get highHorizontalVeryHighVertical => EdgeInsets.symmetric(horizontal: highValue, vertical: veryHighValue);

  EdgeInsets get veryHighHorizontalLowVertical => EdgeInsets.symmetric(horizontal: veryHighValue, vertical: lowValue);

  EdgeInsets get veryHighHorizontalMediumVertical =>
      EdgeInsets.symmetric(horizontal: veryHighValue, vertical: mediumValue);

  EdgeInsets get veryHighHorizontalHighVertical =>
      EdgeInsets.symmetric(horizontal: veryHighValue, vertical: veryHighValue);
}
