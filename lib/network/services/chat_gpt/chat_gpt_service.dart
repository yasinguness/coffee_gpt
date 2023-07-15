import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants/app_const/chat_api_const.dart';
import '../../models/gpt/chat_model.dart';
import '../../models/gpt/models_model.dart';

class ChatGptServices {
  Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer ${dotenv.env['BEARER_KEY']}'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  Future<List<ChatModel>> sendMessage({required String message}) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {'Authorization': 'Bearer ${dotenv.env['BEARER_KEY']}', "Content-Type": "application/json"},
        body: jsonEncode(
          {"model": "text-davinci-003", "prompt": message, "max_tokens": 300},
        ),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];

      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  Future<List<ChatModel>> sendMessageGPT({required String message}) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {'Authorization': 'Bearer ${dotenv.env['BEARER_KEY']}', "Content-Type": "application/json"},
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "system",
                "content":
                    "Sen yardımcı asistansın. Adın Cofi. CoffeGpt adında bir kahve sipariş uygulaması için kullanılıyorsun. Bu uygulamada müşteriler kahve siparişi verebiliyor veya sipariş edecekleri kahve için kararsızlarsa sana danışıyorlar. Müşterilerin isteklerine göre en uygun kahveyi öneriyorsun.  Sana uygulamadaki menüyü sorduklarında menünün içeriğinde şunların olduğunu söylüyorsun; Iced Vietnam Coffee , Caramel Machiato, Coffee Mocha, Coffee Latte ,Iced Caramel Machiato, Espresso. Sana belirli bir kahveyi sipariş vermek istediği söylediğinde kahvenyi Small,Medium,Large olandan hangisini istediğini sorar mısın ? Ardından müşteriye belirttiği kahveden kaç adet sipariş vermek istediğini sorar mısın ? Son olarak da tatlı eklemek isteyip istemediğini sorar mısın ? Tatlılar: Chesscake ve Donut. Tatlılar için boyut sorma lütfen. En sonunda bütün sorulara cevap verdikten sonra siparişiniz şu şekilde oluşturulacaktır diye bütün bilgileri toplayıp gösterir misin ?   Eğer sana kahve siparişi veya kahve önerisi dışında başka bir konu hakkında soru sorduklarında onlara bunu cevaplamayacağını, senin sadece sanal barista olduğunu söylüyorsun. Yani kahve ile ilgili bir konu dışında gelene sorulara kesinlikle cevap vermiyorsun ?"
              },
              {"role": "user", "content": message}
            ]
          },
        ),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
