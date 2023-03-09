import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/models/order.dart';
import 'package:coffe_app/network/models/treat.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/checkout/view_model/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  final Treat? treat;
  final Coffee? coffee;
  const CheckoutView({super.key, this.treat, this.coffee});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late Order order;
  @override
  void initState() {
    // TODO: implement initState
    order = Order();
    order.image = widget.coffee!.image;
    order.totalCoffePrice = widget.coffee!.mediumPrice;
    order.totalTreatPrice = 12;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseView<CheckoutViewModel>(
      builder: (context, value, wtg) {
        return Scaffold(
          appBar: _appBar(context),
          body: Stack(
            alignment: Alignment.center,
            children: [
              _buildBackground(),
              Hero(
                  tag: "nameCoffee", //CoffeImageTag
                  child: Image.asset(
                    "assets/coffee/GLASS-2.png",
                    fit: BoxFit.contain,
                  )),
              if (widget.treat != null)
                Align(
                  alignment: const Alignment(2, 0.5),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: Image.asset(
                      "assets/treat/TREAT_0.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "My Order",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _coffeName(context),
                          Text(
                            "Price",
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                color: CoffeeColors.kTitleColor.withOpacity(.8)),
                          )
                        ],
                      ),
                      if (widget.treat != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _treatName(context),
                              _treatText(context),
                            ],
                          ),
                        ),
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
      model: CheckoutViewModel(api: Provider.of(context)),
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

  ElevatedButton _checkoutButton(CheckoutViewModel model) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          model.postOrder(order);
        },
        child: const Text("Checkout Price"));
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            FeatherIcons.shoppingBag,
            color: CoffeeColors.black,
            size: 30,
          ))
    ],
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context, "fromHome");
        },
        icon: const Icon(
          FeatherIcons.chevronLeft,
          color: CoffeeColors.black,
          size: 30,
        )),
  );
}

_buildBackground() {
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
            stops: const [0.0, .50],
            colors: [CoffeeColors.kBrownColor.withOpacity(.7), CoffeeColors.kBrownColor.withOpacity(0.0)],
          ),
        )),
      ),
      Expanded(
        flex: 1,
        child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, .4],
            colors: [CoffeeColors.kBrownColor.withOpacity(.5), CoffeeColors.kBrownColor.withOpacity(0.0)],
          ),
        )),
      ),
    ],
  );
}
