import 'dart:convert';

import 'package:coffe_app/network/models/treat.dart';
import 'package:http/http.dart' as http;

class TreatService {
  final String _baseUrl = "http://192.168.0.104:3000";
  var htt = http.Client();

  Future<List<Treat>> getTreatList() async {
    var lists = <Treat>[];
    final response = await htt.get(Uri.parse("$_baseUrl/treats"));
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body) as List<dynamic>;
      for (var parse in parsed) {
        lists.add(Treat.fromJson(parse));
      }
      return lists;
    } else {
      throw Exception("Hata oluştu");
    }
  }

  Future<Treat> getTreatsId(String treatsId) async {
    var response = await htt.get(Uri.parse("$_baseUrl/treats/$treatsId"));
    var parsed = Treat.fromJson(jsonDecode(response.body));
    return parsed;
  }
}
