import 'dart:io';

import 'package:dio/dio.dart';

import '../../../common/constants/service_const.dart';
import '../../../common/service/base_service.dart';
import '../../models/customer/customer.dart';

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

  Future<CustomerModel?> createCustomer(String? name, String? qrNo) async {
    var customerData = {
      "name": name,
      "qrNo": qrNo,
    };
    try {
      final response = await dio.post<dynamic>('$BASE_URL/customer/create',
          data: customerData, options: Options(contentType: "application/json"));
      if (response.data['success']) {
        var data = response.data['data'];
        return CustomerModel.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<CustomerModel?> getCustomerById(String id) async {
    try {
      final response = await dio.get('$BASE_URL/customer/$id');
      if (response.statusCode == HttpStatus.ok) {
        return CustomerModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
