import 'package:coffe_app/network/services/customer/customer_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseModel {
  CustomerService? customerService;

  LoginViewModel({this.customerService});
  final TextEditingController controller = TextEditingController();
  final TextEditingController qrcontroller = TextEditingController();

  Future createCustomer() async {
    setBusy(true);
    customerService!.createCustomer(controller.text, qrcontroller.text);
    setBusy(false);
  }

  init() {
    //qrcontroller.text = "D62";
  }
}
