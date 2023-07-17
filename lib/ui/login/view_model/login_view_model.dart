import 'package:coffe_app/network/models/response_model/response_model.dart';
import 'package:flutter/material.dart';

import '../../../common/provider/customer_provider.dart';
import '../../../network/models/customer/customer.dart';
import '../../base/base_model.dart';
import '../repository/login_repository.dart';

class LoginViewModel extends BaseModel {
  final LoginRepository _repo = LoginRepository();
  late CustomerModel customerModel;
  late CustomerProvider customerProvider;
  LoginViewModel({required this.customerProvider, required this.customerModel});

  final TextEditingController controller = TextEditingController();
  final TextEditingController qrcontroller = TextEditingController();

  Future createCustomer() async {
    setBusy(true);
    customerModel.name = controller.text;
    customerModel.qrNo = qrcontroller.text;
    final ApiResponse response = await _repo.createCustomer(customerModel);
    if (response.statusCode == 201) {
      customerProvider.model = response.data;
    }
    setBusy(false);
  }
}
