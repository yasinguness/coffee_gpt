import 'dart:convert';

import 'package:coffe_app/common/constants/service_const.dart';
import 'package:coffe_app/network/models/order.dart';
import 'package:http/http.dart' as http;

class OrderService {
  var htt = http.Client();
  Future<void> postOrder(Order order) async {
    final url = Uri.parse('$BASE_URL/order');
    final headers = {'Content-Type': 'application/json'};
    final jsonBody = jsonEncode(order.toJson());

    final response = await http.post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 201) {
      print("Post succesful");
    } else {
      print(response.statusCode);
      throw Exception("Hata");
      // hata durumu
    }
  }
}
