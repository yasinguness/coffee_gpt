import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/ui/checkout/checkout_view.dart';
import 'package:coffe_app/ui/treats/view/treats_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SweetTreatsWidget extends StatefulWidget {
  final Coffee? coffee;
  const SweetTreatsWidget({super.key, this.coffee});

  @override
  State<SweetTreatsWidget> createState() => _SweetTreatsWidgetState();
}

class _SweetTreatsWidgetState extends State<SweetTreatsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _appBar(context),
      body: Stack(
        children: [
          _buildBackground(),
          TreatsListView(coffee: widget.coffee),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: size.width * 0.55,
                height: size.height * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(flex: 4, child: _coffeNameText(context)),
                    Expanded(flex: 3, child: _questionText(context)),
                    Expanded(flex: 3, child: _noThanksButton()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
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
            Navigator.pop(context, "fromCoffeeDetail");
          },
          icon: const Icon(
            FeatherIcons.chevronLeft,
            color: CoffeeColors.black,
            size: 30,
          )),
    );
  }

  Hero _coffeNameText(BuildContext context) {
    return Hero(
        tag: "name${widget.coffee!.name!.toString()}", //CoffeNameTag
        child: Text(
          widget.coffee!.name!,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.right,
        ));
  }

  Text _questionText(BuildContext context) {
    return Text(
      "Would you like to add some sweet treats?",
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: CoffeeColors.kTitleColor.withOpacity(0.5),
          ),
    );
  }

  Align _noThanksButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteConst.checkoutView,
              arguments: CheckoutView(
                coffee: widget.coffee,
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          alignment: Alignment.centerLeft,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: const Text("No Thanks"),
      ),
    );
  }
}

_buildBackground() {
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.0, .4],
            colors: [CoffeeColors.kBrownColor.withOpacity(.5), CoffeeColors.kBrownColor.withOpacity(0.0)],
          ),
        )),
      ),
    ],
  );
}
