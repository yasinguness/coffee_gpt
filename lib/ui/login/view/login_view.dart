import 'package:auto_route/auto_route.dart';
import 'package:coffe_app/common/provider/customer_provider.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/network/services/customer/customer_service.dart';
import 'package:coffe_app/router/app_router.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BaseView<LoginViewModel>(
      model: LoginViewModel(
          customerService: locator<CustomerService>(), customerProvider: Provider.of<CustomerProvider>(context)),
      builder: (context, value, widget) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: size.height * 1,
          child:
              Stack(children: [_backgroundImage(size), _textFields(size, value), _loginButton(size, context, value)]),
        ),
      ),
    );
  }

  Positioned _textFields(Size size, LoginViewModel model) {
    return Positioned(
      top: size.height * 0.25,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 10),
                  ]),
              child: TextField(
                  controller: model.controller,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "İsminizi Giriniz",
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Colors.grey.shade400,
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ]),
              child: TextField(
                  controller: model.qrcontroller,
                  //enabled: false,
                  //readOnly: true,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      labelText: "Masa Numaranız",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _loginButton(Size size, BuildContext context, LoginViewModel model) {
    return Positioned(
      left: size.width * 0.1,
      right: size.width * 0.1,
      bottom: size.height * 0.1,
      child: SizedBox(
          width: size.width * 0.5,
          height: size.width * 0.15,
          child: ElevatedButton(
            onPressed: () {
              model.createCustomer();
              context.router.push(const EntryRoute());
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28), // <-- Radius
                )),
            child: const Text("Giriş Yap",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          )),
    );
  }

  Container _backgroundImage(Size size) {
    return Container(
        width: double.infinity,
        height: size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: Image.asset("assets/coffee/backg.jpg").image)));
  }
}
