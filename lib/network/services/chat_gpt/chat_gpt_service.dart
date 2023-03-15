import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coffe_app/common/constants/chat_api_const.dart';
import 'package:coffe_app/network/models/models_model.dart';
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
}
