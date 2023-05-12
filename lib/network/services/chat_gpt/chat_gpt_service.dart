import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coffe_app/common/constants/chat_api_const.dart';
import 'package:coffe_app/network/models/gpt/chat_model.dart';
import 'package:coffe_app/network/models/gpt/models_model.dart';
import 'package:http/http.dart' as http;

class ChatGptServices {
  Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$Base_Url/models"),
        headers: {'Authorization': 'Bearer $BEARER_KEY'},
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
        Uri.parse("$Base_Url/completions"),
        headers: {'Authorization': 'Bearer $BEARER_KEY', "Content-Type": "application/json"},
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
        Uri.parse("$Base_Url/chat/completions"),
        headers: {'Authorization': 'Bearer $BEARER_KEY', "Content-Type": "application/json"},
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      // Map jsonResponse = jsonDecode(response.body);
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
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
