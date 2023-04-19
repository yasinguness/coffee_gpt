import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/text_const.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/common/widgets/background_decoration.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/main.dart';
import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/models/order.dart';
import 'package:coffe_app/network/models/treat.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/checkout/view_model/checkout_view_model.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  final Treat? treat;
  final Coffee? coffee;
  const CheckoutView({super.key, this.treat, this.coffee});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> with RouteAware {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseView<CheckoutViewModel>(
      routeObserver: routeObserver,
      onDispose: () => routeObserver.unsubscribe(this),
      builder: (context, value, wtg) {
        return value.busy
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: const CustomAppBar(),
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildBackground(),
                    _coffeImage(),
                    if (widget.treat != null) _treatImage(size),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _myOrderText(context),
                            const SizedBox(
                              height: 25,
                            ),
                            _coffeeRow(context, value),
                            if (widget.treat != null) _treatRow(context),
                            const Spacer(),
                            _checkoutButton(value)
                            /* coffee.price + (treat?.price ?? 0)).toStringAsFixed(2) */
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
      },
      model: CheckoutViewModel(
        orderServices: locator<OrderService>(),
        coffee: widget.coffee!,
        treat: widget.treat,
        order: Order(),
        listTreat: <Treat>[],
        listCoffee: <Coffee>[],
      ),
      onModelReady: (p0) => p0.getCoffeePrice(),
    );
  }

  Row _coffeeRow(BuildContext context, CheckoutViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_coffeName(context), _coffePrice(model, context)],
    );
  }

  Padding _treatRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _treatName(context),
          _treatText(context),
        ],
      ),
    );
  }

  Text _myOrderText(BuildContext context) {
    return Text(
      TextConst.orderText,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Hero _coffeImage() {
    return Hero(
        tag: "nameCoffee", //CoffeImageTag
        child: Image.asset(
          "assets/coffee/GLASS-2.png",
          fit: BoxFit.contain,
        ));
  }

  Align _treatImage(Size size) {
    return Align(
      alignment: const Alignment(2, 0.5),
      child: SizedBox(
        width: size.width * 0.8,
        child: Image.asset(
          "assets/treat/TREAT_0.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Text _coffePrice(CheckoutViewModel model, BuildContext context) {
    return Text(
      "${model.price}",
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w600, color: CoffeeColors.kTitleColor.withOpacity(.8)),
    );
  }

  Expanded _coffeName(BuildContext context) {
    return Expanded(
        child: Text(
      widget.coffee!.name!,
      style: Theme.of(context)
          .textTheme
          .subtitle1!
          .copyWith(fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w800, color: CoffeeColors.kTitleColor),
    ));
  }

  Expanded _treatName(BuildContext context) {
    return Expanded(
      child: Text(widget.treat!.name!,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w700, color: CoffeeColors.kTitleColor)),
    );
  }

  Text _treatText(BuildContext context) {
    return Text("${widget.treat!.price!} TL",
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            color: CoffeeColors.kTitleColor.withOpacity(.8)));
  }

  ElevatedButton _checkoutButton(
    CheckoutViewModel model,
  ) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          model.postOrder();
        },
        child: const Text("Checkout Price"));
  }
}

_buildBackground() {
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: BackgroundDecoration(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [CoffeeColors.kBrownColor.withOpacity(.7), CoffeeColors.kBrownColor.withOpacity(0.0)]),
      ),
      const Expanded(
        flex: 1,
        child: BackgroundDecoration(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ],
  );
}
