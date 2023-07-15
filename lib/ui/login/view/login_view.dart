import 'package:auto_route/auto_route.dart';
import '../../../common/constants/app_const/assets_const.dart';
import '../../../common/constants/app_const/text_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/coffee_colors.dart';
import '../../../common/provider/customer_provider.dart';
import '../../../common/widgets/login_text_field.dart';
import '../../../locator.dart';
import '../../../network/services/customer/customer_service.dart';
import '../../../router/app_router.dart';
import '../../base/base_view.dart';
import '../view_model/login_view_model.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 28;
    var size = MediaQuery.of(context).size;
    return BaseView<LoginViewModel>(
      model: LoginViewModel(
        customerService: locator<CustomerService>(),
        customerProvider: Provider.of<CustomerProvider>(context),
      ),
      builder: (context, value, widget) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: size.height * 1,
          child: Stack(children: [
            _backgroundImage(size),
            _textFields(size, value),
            _loginButton(size, context, value, borderRadius)
          ]),
        ),
      ),
    );
  }

  Container _backgroundImage(Size size) {
    return Container(
        width: double.infinity,
        height: size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: Image.asset(AssetConst.instance.loginBackground).image)));
  }

  Positioned _textFields(Size size, LoginViewModel model) {
    return Positioned(
      top: size.height * 0.25,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginTextField(hintText: TextConst.instance.loginNameTextField, model: model, cntrl: model.controller),
          LoginTextField(
            model: model,
            hintText: TextConst.instance.loginTableNumberTextField,
            cntrl: model.qrcontroller,
          ),
        ],
      ),
    );
  }

  Positioned _loginButton(Size size, BuildContext context, LoginViewModel model, double borderRadius) {
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
            style: _buttonStyle(borderRadius),
            child: Text(TextConst.instance.loginButtonText, style: Theme.of(context).textTheme.bodyMedium),
          )),
    );
  }

  ButtonStyle _buttonStyle(double borderRadius) {
    return ElevatedButton.styleFrom(
        backgroundColor: CoffeeColors.kBrownColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ));
  }
}
