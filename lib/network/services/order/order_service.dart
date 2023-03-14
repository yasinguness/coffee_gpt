import 'dart:convert';

import 'package:coffe_app/network/models/order.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String _baseUrl = "http://192.168.0.104:3000";
  var htt = http.Client();
  Future<void> postOrder(Order order) async {
    final url = Uri.parse('$_baseUrl/order');
    final headers = {'Content-Type': 'application/json'};
    final jsonBody = jsonEncode(order.toJson());

    final response = await http.post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      print("Post succesful");
    } else {
      throw Exception("Hata");
      // hata durumu
    }
  }
}
