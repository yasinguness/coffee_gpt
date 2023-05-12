import 'dart:io';

import 'package:coffe_app/common/constants/service_const.dart';
import 'package:coffe_app/common/service/base_service.dart';
import 'package:coffe_app/network/models/customer/customer.dart';

class CustomerService extends BaseService {
  Future<List<CustomerModel>?> fetchCustomers() async {
    final response = await dio.get('$BASE_URL/customer');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data['data'];
      if (datas is List) {
        return datas.map((e) => CustomerModel.fromJson(e)).toList();
      }
    }
    return null;
  }

  Future createCustomer(String name, String qrNo) async {
    var customerData = {
      "name": name,
      "qr": qrNo,
      "phone": "5555555555",
    };
    try {
      final response = await dio.post<dynamic>(
        '$BASE_URL/customer/create',
        data: customerData, /* options: Options(contentType: "application/json") */
      );
      if (response.data['success']) {
        var data = response.data;
        CustomerModel.fromJson(data);
      }
    } catch (e) {
      print("Müşteri oluşturulamadı");
      rethrow;
    }
  }
}
