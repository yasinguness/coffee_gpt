class TextConst {
  TextConst._init();
  static TextConst? _instance;
  static TextConst get instance {
    _instance ??= TextConst._init();
    return _instance!;
  }

//LOGIN
  String loginNameTextField = "İsminizi Giriniz";
  String loginTableNumberTextField = "Masa Numaranız";
  String loginButtonText = "Giriş Yap";

  //Home
  String askCoffi = "Cofiye Sor";
  String titleCoffi = "Yardım etmemi ister misin ?";
  String coffiDesc =
      "Hey! Ben sanal barista Cofi. Benimle birlikte hangi lezzette kahve içmekten hoşlandığına karar verebilirsin. Senin için en güzel kahveyi bulmamız için haydi hemen soru sormaya başla!!";
  String textProductList = "Ürün Listesi";
  String animatedText1 = 'KOLAY KARAR VER';
  String animatedText2 = 'HIZLI SİPARİŞ VER';
  String animatedText3 = 'HEMEN GELSİN';
  String productListText = "Ürün Listesi";

  String orderText = "Siparişlerim";
  String addToCard = "Siparişe Ekle";
  String treatText = "Tatlı eklememi ister misiniz ?";
  String noThanks = "Teşekkürler";
}
