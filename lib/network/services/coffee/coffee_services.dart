import 'dart:async';
import 'dart:convert';

import 'package:coffe_app/network/models/coffee.dart';
import 'package:http/http.dart' as http;

class CoffeeServices {
  final String _baseUrl = "http://192.168.0.104:3000";
  var htt = http.Client();

  Future<List<Coffee>> getCoffeeList() async {
    var lists = <Coffee>[];
    final response = await htt.get(Uri.parse("$_baseUrl/"));
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body) as List<dynamic>;
      for (var parse in parsed) {
        lists.add(Coffee.fromJson(parse));
      }
      return lists;
    } else {
      throw Exception("Hata oluştu");
    }
  }

  Future<Coffee> getCoffeeId(String coffeId) async {
    var response = await htt.get(Uri.parse("$_baseUrl/$coffeId"));
    var parsed = Coffee.fromJson(jsonDecode(response.body));
    return parsed;
  }
}
