import 'dart:convert';

import 'package:coffe_app/common/constants/service_const.dart';
import 'package:coffe_app/network/models/treat.dart';
import 'package:http/http.dart' as http;

class TreatService {
  var htt = http.Client();

  Future<List<Treat>> getTreatList() async {
    var lists = <Treat>[];
    final response = await htt.get(Uri.parse("$BASE_URL/treats"));
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
    var response = await htt.get(Uri.parse("$BASE_URL/treats/$treatsId"));
    var parsed = Treat.fromJson(jsonDecode(response.body));
    return parsed;
  }
}
