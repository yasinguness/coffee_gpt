class AssetConst {
  AssetConst._init();
  static AssetConst? _instance;
  static AssetConst get instance {
    _instance ??= AssetConst._init();
    return _instance!;
  }

  final String loginBackground = "assets/coffee/backg.jpg";
  final String coffiAsset = "assets/rive/bot.riv";
  final String homeCoffeRive = "assets/rive/donut.riv";
}
