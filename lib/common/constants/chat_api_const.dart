class ChatGptApi {
  static ChatGptApi? _instance;
  static ChatGptApi get instance {
    _instance ??= ChatGptApi._init();
    return _instance!;
  }

  ChatGptApi._init();

  // ignore: non_constant_identifier_names
  String BASE_URL = "https://api.openai.com/v1";
}
