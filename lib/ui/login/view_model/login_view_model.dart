import 'package:coffe_app/common/provider/customer_provider.dart';
import 'package:coffe_app/network/services/customer/customer_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseModel {
  CustomerService? customerService;
  CustomerProvider? customerProvider;
  LoginViewModel({this.customerService, this.customerProvider});

  final TextEditingController controller = TextEditingController();
  final TextEditingController qrcontroller = TextEditingController();

  Future createCustomer() async {
    setBusy(true);
    customerProvider!.model = await customerService!.createCustomer(controller.text, qrcontroller.text);
    setBusy(false);
  }

  init() {
    //qrcontroller.text = "D62";
  }
}
